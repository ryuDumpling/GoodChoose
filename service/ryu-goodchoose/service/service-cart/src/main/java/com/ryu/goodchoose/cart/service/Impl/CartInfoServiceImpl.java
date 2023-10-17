package com.ryu.goodchoose.cart.service.Impl;

import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.ryu.goodchoose.activity.client.ActivityFeignClient;
import com.ryu.goodchoose.cart.service.CartInfoService;
import com.ryu.goodchoose.client.product.ProductFeignClient;
import com.ryu.goodchoose.client.search.SkuFeignClient;
import com.ryu.goodchoose.client.user.UserFeignClient;
import com.ryu.goodchoose.common.constant.RedisConst;
import com.ryu.goodchoose.common.exception.GcException;
import com.ryu.goodchoose.common.result.ResultCodeEnum;
import com.ryu.goodchoose.enums.SkuType;
import com.ryu.goodchoose.model.order.CartInfo;
import com.ryu.goodchoose.model.product.SkuInfo;
import org.checkerframework.checker.units.qual.C;
import org.ietf.jgss.GSSException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.BoundHashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * @author ryuDumpling
 * @version 2023/10/14 7:56
 */
@Service
public class CartInfoServiceImpl implements CartInfoService {

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private ActivityFeignClient activityFeignClient;

    @Autowired
    private UserFeignClient userFeignClient;

    @Autowired
    private ProductFeignClient productFeignClient;

    @Autowired
    private SkuFeignClient skuFeignClient;

    //返回购物车在redis中的key
    private String getCartKey(Long userId){
        return RedisConst.USER_KEY_PREFIX + userId + RedisConst.USER_CART_KEY_SUFFIX;
    }

    //设置key的过期时间
    private void setCartKeyExpire(String key){
        redisTemplate.expire(key,RedisConst.USER_CART_EXPIRE, TimeUnit.SECONDS);
    }
    //添加商品到购物车
    @Override
    public void addToCart(Long userId, Long skuId, Integer skuNum) {
        //1 从redis中获取key数据-肯定有userId数据
        String cartKey = this.getCartKey(userId);
        //2 根据第一步查询出的结果得到skuId+skuMum的关系 判断是否是第一次添加该商品到购物车
        BoundHashOperations<String, String, CartInfo> hashOperations = redisTemplate.boundHashOps(cartKey);
        CartInfo cartInfo = new CartInfo();
        if(hashOperations.hasKey(skuId.toString())){ ///2.1 如果结果中有skuId -非首次
            ////2.1.1 根据skuId得到对应数量，更新skuMuM
            cartInfo = hashOperations.get(skuId.toString());
            Integer currentSkuNum = cartInfo.getSkuNum() + skuNum;//更新后的购物车商品数量
            if (currentSkuNum < 1 ){
                return;//TODO 应该删除商品
            }
            ////2.1.2 根据限量判断是否超出
            Integer perLimit = cartInfo.getPerLimit();//获取限购数量
            if (currentSkuNum > perLimit){//超出 抛出自定义异常
                throw new GcException(ResultCodeEnum.SKU_LIMIT_ERROR);
            } else {
                //更新cartInfo对象
                cartInfo.setSkuNum(currentSkuNum);
                cartInfo.setCurrentBuyNum(currentSkuNum);//预留字段
                //添加到购物车的商品默认选中
                cartInfo.setIsChecked(1);
                //更新时间
                cartInfo.setUpdateTime(new Date());
            }
        } else {///2.2 如果没有 -首次
            ////2.2.1 直接添加
            skuNum = 1;
            SkuInfo skuInfo = productFeignClient.getSku(skuId);
            if (skuInfo == null){//数据为空则抛出异常
                throw new GcException(ResultCodeEnum.DATA_ERROR);
            }
            cartInfo.setSkuId(skuId);
            cartInfo.setCategoryId(skuInfo.getCategoryId());
            cartInfo.setSkuType(skuInfo.getSkuType());
            cartInfo.setIsNewPerson(skuInfo.getIsNewPerson());
            cartInfo.setUserId(userId);
            cartInfo.setCartPrice(skuInfo.getPrice());
            cartInfo.setSkuNum(skuNum);
            cartInfo.setCurrentBuyNum(skuNum);
            cartInfo.setSkuType(SkuType.COMMON.getCode());
            cartInfo.setPerLimit(skuInfo.getPerLimit());
            cartInfo.setImgUrl(skuInfo.getImgUrl());
            cartInfo.setSkuName(skuInfo.getSkuName());
            cartInfo.setWareId(skuInfo.getWareId());
            cartInfo.setIsChecked(1);
            cartInfo.setStatus(1);
            cartInfo.setCreateTime(new Date());
            cartInfo.setUpdateTime(new Date());
        }
        //3 更新redis缓存
        hashOperations.put(skuId.toString(),cartInfo);
        //4 设置有效时间
        this.setCartKeyExpire(cartKey);
    }
    //购物车列表
    @Override
    public List<CartInfo> cartList(Long userId) {
        List<CartInfo> cartInfoList = new ArrayList<>();
        if (StringUtils.isEmpty(userId.toString())){
            return cartInfoList;
        }
        BoundHashOperations<String, String, CartInfo> hashOperations =
                redisTemplate.boundHashOps(this.getCartKey(userId));
        if (CollectionUtils.isEmpty(hashOperations.values())){
            return cartInfoList;
        } else {
            cartInfoList = hashOperations.values();
            cartInfoList.sort(new Comparator<CartInfo>() {//根据更新时间降序排列
                @Override
                public int compare(CartInfo o1, CartInfo o2) {
                    return o1.getUpdateTime().compareTo(o2.getUpdateTime());
                }
            });
        }
        return cartInfoList;
    }


    //切换购物车中商品的选中状态

    //删除购物车商品
    //删一个商品
    @Override
    public void deleteCart(Long skuId, Long userId) {
        BoundHashOperations<String, String, CartInfo> hashOperations =
                redisTemplate.boundHashOps(this.getCartKey(userId));
        if (hashOperations.hasKey(skuId.toString())){
            //如果redis中有这个商品的数据-删除
         hashOperations.delete(skuId.toString());
        }
    }
    //清除购物车
    @Override
    public void deleteAllCart(Long userId) {
        BoundHashOperations<String, String, CartInfo> hashOperations =
                redisTemplate.boundHashOps(this.getCartKey(userId));
        if (hashOperations == null){
            throw new GcException(ResultCodeEnum.DATA_ERROR);
        }
        List<CartInfo> cartInfoList = hashOperations.values();
        for(CartInfo cartInfo:cartInfoList){
            hashOperations.delete(cartInfo.getSkuId().toString());
        }
    }
    //批量删除
    @Override
    public void batchDeleteCart(List<Long> skuIdList, Long userId) {
        BoundHashOperations<String, String, CartInfo> hashOperations =
                redisTemplate.boundHashOps(this.getCartKey(userId));
        for (Long skuId:skuIdList){
            if (hashOperations.hasKey(skuId.toString())){
                //如果redis中有这个商品的数据-删除
                hashOperations.delete(skuId.toString());
            }
        }
    }

    @Override
    public void checkCart(Long userId, Long skuId, Integer isChecked) {
        //从redis中取址
        BoundHashOperations<String, String, CartInfo> hashOperations =
                redisTemplate.boundHashOps(this.getCartKey(userId));
        CartInfo cartInfo = hashOperations.get(skuId.toString());
        if (cartInfo != null){
            cartInfo.setIsChecked(isChecked);
            //更新
            hashOperations.put(skuId.toString(),cartInfo);
            this.setCartKeyExpire(this.getCartKey(userId));
        }
    }

    @Override
    public void checkAllCart(Long userId, Integer isChecked) {
        //从redis中取址
        BoundHashOperations<String, String, CartInfo> hashOperations =
                redisTemplate.boundHashOps(this.getCartKey(userId));
        List<CartInfo> cartInfoList = hashOperations.values();
        for (CartInfo cartInfo:cartInfoList){
            if (cartInfo != null){
                cartInfo.setIsChecked(isChecked);
                //更新
                hashOperations.put(cartInfo.getSkuId().toString(),cartInfo);
            }
        }
        this.setCartKeyExpire(this.getCartKey(userId));
    }

    @Override
    public void batchCheckCart(List<Long> skuIdList, Long userId, Integer isChecked) {
        String cartKey = getCartKey(userId);
        //获取缓存对象
        BoundHashOperations<String, String, CartInfo> hashOperations = redisTemplate.boundHashOps(cartKey);
        skuIdList.forEach(skuId -> {
            CartInfo cartInfo = hashOperations.get(skuId.toString());
            cartInfo.setIsChecked(isChecked);
            hashOperations.put(cartInfo.getSkuId().toString(), cartInfo);
        });
    }

    //获取购物车中选中的商品信息
    @Override
    public List<CartInfo> getCartCheckedList(Long userId) {
        //从redis中取址
        BoundHashOperations<String, String, CartInfo> hashOperations =
                redisTemplate.boundHashOps(this.getCartKey(userId));
        List<CartInfo> cartInfoList = new ArrayList<>();
        List<CartInfo> cartInfos = hashOperations.values();
        if(CollectionUtils.isEmpty(cartInfos)){
            return cartInfoList;
        }
        cartInfos.stream().forEach(item -> {
            if(item.getIsChecked().intValue() == 1){
                cartInfoList.add(item);
            }
        });
        return cartInfoList;
    }

    @Override
    public void deleteCartCheck(Long userId) {
        //根据userId查询选中的购物车信息
        List<CartInfo> cartInfoList = getCartCheckedList(userId);
        //查询list数据处理，得到skuId集合
        List<Long> skuIdList = cartInfoList.stream().map(item -> item.getSkuId()).collect(Collectors.toList());

        //构建redis的key值
        String cartKey = this.getCartKey(userId);
        BoundHashOperations hashOperations = redisTemplate.boundHashOps(cartKey);
        skuIdList.forEach(skuId -> {
            hashOperations.delete(skuId.toString());
        });
    }
}
