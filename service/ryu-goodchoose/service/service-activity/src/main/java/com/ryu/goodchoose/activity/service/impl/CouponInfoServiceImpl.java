package com.ryu.goodchoose.activity.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ryu.goodchoose.activity.mapper.CouponInfoMapper;
import com.ryu.goodchoose.activity.mapper.CouponRangeMapper;
import com.ryu.goodchoose.activity.mapper.CouponUseMapper;
import com.ryu.goodchoose.activity.service.CouponInfoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ryu.goodchoose.client.product.ProductFeignClient;
import com.ryu.goodchoose.enums.CouponRangeType;
import com.ryu.goodchoose.enums.CouponStatus;
import com.ryu.goodchoose.model.activity.ActivityInfo;
import com.ryu.goodchoose.model.activity.CouponInfo;
import com.ryu.goodchoose.model.activity.CouponRange;
import com.ryu.goodchoose.model.activity.CouponUse;
import com.ryu.goodchoose.model.order.CartInfo;
import com.ryu.goodchoose.model.product.Category;
import com.ryu.goodchoose.model.product.SkuInfo;
import com.ryu.goodchoose.vo.activity.CouponRuleVo;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

/**
 * <p>
 * 优惠券信息 服务实现类
 * </p>
 *
 * @author ryu
 * @since 2023-10-11
 */
@Service
public class CouponInfoServiceImpl extends ServiceImpl<CouponInfoMapper, CouponInfo> implements CouponInfoService {

    @Autowired
    private CouponRangeMapper couponRangeMapper;

    @Autowired
    private CouponUseMapper couponUseMapper;

    @Autowired
    private ProductFeignClient productFeignClient;

    //计算优惠券总金额
    private BigDecimal computeTotalAmount(List<CartInfo> cartInfoList) {
        BigDecimal total = new BigDecimal("0");
        for (CartInfo cartInfo : cartInfoList) {
            //是否选中
            if(cartInfo.getIsChecked().intValue() == 1) {
                BigDecimal itemTotal = cartInfo.getCartPrice().multiply(new BigDecimal(cartInfo.getSkuNum()));
                total = total.add(itemTotal);
            }
        }
        return total;
    }

    @Override
    public IPage<CouponInfo> selectPageCouponInfo(Long page,Long limit) {
        Page<CouponInfo> pageParam = new Page<>(page,limit);
        IPage<CouponInfo> couponInfoIPage =
                baseMapper.selectPage(pageParam,null);
        //从对象中获取数据
        List<CouponInfo> couponInfoList = couponInfoIPage.getRecords();
        //遍历数据，对每一个对象封装活动类型
        couponInfoList.stream().forEach(item ->{
            item.setCouponTypeString(item.getCouponType().getComment());
            if(item.getRangeType() != null){
                item.setRangeTypeString(item.getRangeType().getComment());
            }
        });
        return couponInfoIPage;
    }

    @Override
    public CouponInfo getCouponInfo(Long id) {
        CouponInfo item = baseMapper.selectById(id);
        item.setCouponTypeString(item.getCouponType().getComment());
        if(item.getRangeType() != null){
            item.setRangeTypeString(item.getRangeType().getComment());
        }
        return item;
    }

    @Override
    public Map<String, Object> findCouponRuleList(Long id) {
        //根据优惠券id获取优惠券信息
        CouponInfo couponInfo = baseMapper.selectById(id);
        //根据优惠券id查询Range表，得到rangeId的值
        List<CouponRange> couponRangeList = couponRangeMapper.selectList(
                new LambdaQueryWrapper<CouponRange>().eq(CouponRange::getCouponId, id));
        if(couponRangeList.size()==0){
            return null;
        }
        //如果规则类型是SKU rangeId为skuId的值
        //如果规则类型是Category rangeId的值为CategoryId的值
        List<Long> rangeIdList = couponRangeList.stream().map(CouponRange::getRangeId).collect(Collectors.toList());
        Map<String, Object> result = new HashMap<>();
        if (!CollectionUtils.isEmpty(rangeIdList)){
            if(couponInfo.getRangeType() == CouponRangeType.SKU){
                //封装数据-1sku 远程调用获取sku信息
                List<SkuInfo> skuInfoList = productFeignClient.findSkuInfoList(rangeIdList);
                result.put("skuInfoList",skuInfoList);
            } else if(couponInfo.getRangeType() == CouponRangeType.CATEGORY){
                //-2category 远程调用获取category信息
                List<Category> categoryList = productFeignClient.findCategoryList(rangeIdList);
                result.put("categoryList",categoryList);
            }
            return result;
        }
        return null;
    }

    @Override
    public void saveCouponRule(CouponRuleVo couponRuleVo) {
        //根据优惠价id删除先前数据
        couponRangeMapper.delete(
                new LambdaQueryWrapper<CouponRange>().eq(CouponRange::getCouponId,couponRuleVo.getCouponId()));
        //更新优惠价信息
        CouponInfo couponInfo = baseMapper.selectById(couponRuleVo.getCouponId());
        couponInfo.setRangeType(couponRuleVo.getRangeType());
        couponInfo.setConditionAmount(couponRuleVo.getConditionAmount());
        couponInfo.setAmount(couponRuleVo.getAmount());
        couponInfo.setConditionAmount(couponRuleVo.getConditionAmount());
        couponInfo.setRangeDesc(couponRuleVo.getRangeDesc());
        baseMapper.updateById(couponInfo);
        //添加优惠券规则
        List<CouponRange> couponRangeList = couponRuleVo.getCouponRangeList();
        for (CouponRange couponRange:couponRangeList){
            //设置id值
            couponRange.setCouponId(couponRuleVo.getCouponId());
            couponRangeMapper.insert(couponRange);
        }
    }

    @Override
    public void deleteRule(Long id) {
        couponRangeMapper.delete(
                new LambdaQueryWrapper<CouponRange>().eq(CouponRange::getCouponId,id));
    }

    @Override
    public List<CouponInfo> findCouponInfoList(Long skuId, Long userId) {
        //根据skuId获取skuInfo
        SkuInfo skuInfo = productFeignClient.getSku(skuId);
        List<CouponInfo> couponInfoList = baseMapper.selectCouponInfoList(skuInfo.getId(),skuInfo.getCategoryId(),userId);
        return couponInfoList;
    }

    @Override
    public List<CouponInfo> findCartCouponInfo(List<CartInfo> cartInfoList, Long userId) {
        //获取用户的全部优惠券
        List<CouponInfo> userAllCouponInfoList = baseMapper.selectCartCouponInfoList(userId);
        if (CollectionUtils.isEmpty(userAllCouponInfoList)){
            return new ArrayList<CouponInfo>();
        }
        //获取全部的优惠券id
        List<Long> couponIdList = userAllCouponInfoList.stream().
                map(couponInfo -> couponInfo.getId()).collect(Collectors.toList());
        //优惠券的使用范围
        LambdaQueryWrapper<CouponRange> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(CouponRange::getCouponId,couponIdList);
        List<CouponRange> couponRangeList = couponRangeMapper.selectList(wrapper);
        //获取优惠券id对应的skuIdList
        Map<Long, List<Long>> couponIdToSkuIdMap= this.findCouponIdToSkuIdMap(cartInfoList,couponRangeList);
        //遍历优惠券集合，根据不同的优惠券类型做不同的处理 -通用 -类别 -特定商品
        BigDecimal reduceAmount = new BigDecimal(0);
        CouponInfo optimalCouponInfo = null;
        for (CouponInfo couponInfo:userAllCouponInfoList){
            if (couponInfo.getRangeType() == CouponRangeType.ALL){
                //-通用
                //判断是否满足优惠使用门槛
                //计算购物车商品的总价
                BigDecimal totalAmount = computeTotalAmount(cartInfoList);
                if(totalAmount.subtract(couponInfo.getAmount()).doubleValue() >= couponInfo.getConditionAmount().doubleValue()){
                    couponInfo.setIsSelect(1);//使用后金额必须大于0才能使用
                }
            } else {
                //需要skuId的优惠券使用
                //优惠券id获取对应的skuId列表
                List<Long> skuIdList = couponIdToSkuIdMap.get(couponInfo.getId());
                //满足使用范围购物项
                List<CartInfo> currentCartInfoList = cartInfoList.stream().filter(cartInfo ->
                        skuIdList.contains(cartInfo.getSkuId())).collect(Collectors.toList());
                BigDecimal totalAmount = computeTotalAmount(currentCartInfoList);
                if(totalAmount.subtract(couponInfo.getAmount()).doubleValue() >= couponInfo.getConditionAmount().doubleValue()){
                    couponInfo.setIsSelect(1);
                }
            }
            if (couponInfo.getIsSelect().intValue() == 1
                    && couponInfo.getAmount().subtract(reduceAmount).doubleValue() > couponInfo.getConditionAmount().doubleValue()) {
                reduceAmount = couponInfo.getAmount();
                optimalCouponInfo = couponInfo;
            }
        }
        if(null != optimalCouponInfo) {
            optimalCouponInfo.setIsOptimal(1);
        }
        return userAllCouponInfoList;
    }

    private Map<Long, List<Long>> findCouponIdToSkuIdMap(List<CartInfo> cartInfoList, List<CouponRange> couponRangeList) {
        Map<Long, List<Long>> couponIdToSkuIdMap = new HashMap<>();
        Map<Long, List<CouponRange>> couponRangeToRangeListMap = couponRangeList.stream()
                        .collect(Collectors.groupingBy(couponRange -> couponRange.getCouponId()));
        //遍历map集合
        Iterator<Map.Entry<Long, List<CouponRange>>> iterator = couponRangeToRangeListMap.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry<Long, List<CouponRange>> entry = iterator.next();
            Long couponId = entry.getKey();
            List<CouponRange> rangeList = entry.getValue();
            //创建集合set
            Set<Long> skuIdSet = new HashSet<>();
            for(CartInfo cartInfo:cartInfoList){
                for(CouponRange couponRange:couponRangeList){
                    if(couponRange.getRangeType() == CouponRangeType.SKU
                    && couponRange.getRangeId().longValue() == cartInfo.getSkuId().longValue()){
                        skuIdSet.add(cartInfo.getSkuId());
                    } else if (couponRange.getRangeType() == CouponRangeType.CATEGORY
                    && couponRange.getRangeId().longValue() == cartInfo.getCategoryId().longValue()){
                        skuIdSet.add(cartInfo.getSkuId());
                    }
                }
            }
            couponIdToSkuIdMap.put(couponId,new ArrayList<>(skuIdSet));
        }

        return couponIdToSkuIdMap;
    }

    @Override
    public CouponInfo findRangeSkuIdList(List<CartInfo> cartInfoList, Long couponId) {
        CouponInfo couponInfo = baseMapper.selectById(couponId);
        if (couponInfo == null){
            return null;
        }
        //根据couponId查询对应couponRange数据
        List<CouponRange> couponRangeList = couponRangeMapper.selectList(
                new LambdaQueryWrapper<CouponRange>().eq(CouponRange::getCouponId, couponId)
        );
        Map<Long, List<Long>> couponIdToSkuIdMap = this.findCouponIdToSkuIdMap(cartInfoList, couponRangeList);
        List<Long> skuIdList = couponIdToSkuIdMap.entrySet().iterator().next().getValue();
        couponInfo.setSkuIdList(skuIdList);
        return couponInfo;
    }

    @Override
    public Boolean updateCouponInfoUseStatus(Long couponId, Long userId, Long orderId) {
        CouponUse couponUse = couponUseMapper.selectOne(new LambdaQueryWrapper<CouponUse>()
                .eq(CouponUse::getCouponId, couponId)
                .eq(CouponUse::getUserId, userId)
                .eq(CouponUse::getOrderId, orderId));
        if (couponUse != null){
            couponUse.setCouponStatus(CouponStatus.USED);
            couponUse.setUsedTime(new Date());
            couponUseMapper.updateById(couponUse);
            return true;
        }
        return false;
    }
}
