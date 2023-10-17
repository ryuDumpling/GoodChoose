package com.ryu.goodchoose.search.service.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.ryu.goodchoose.activity.client.ActivityFeignClient;
import com.ryu.goodchoose.client.product.ProductFeignClient;
import com.ryu.goodchoose.common.auth.AuthContextHolder;
import com.ryu.goodchoose.enums.SkuType;
import com.ryu.goodchoose.model.product.Category;
import com.ryu.goodchoose.model.product.SkuInfo;
import com.ryu.goodchoose.model.search.SkuEs;
import com.ryu.goodchoose.search.repository.SkuRepository;
import com.ryu.goodchoose.search.service.SkuService;
import com.ryu.goodchoose.vo.search.SkuEsQueryVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * @author ryuDumpling
 * @version 2023/10/9 14:03
 */
@Service
public class SkuServiceImpl implements SkuService {
    @Autowired
    private SkuRepository skuRepository;
    @Autowired
    private ProductFeignClient productFeignClient;

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private ActivityFeignClient activityFeignClient;


    //上架
    @Override
    public void upperSku(Long skuId) {
        //通过远程调用获取sku相关信息
        SkuInfo sku = productFeignClient.getSku(skuId);
        if(sku==null){
            return;
        }
        Category category = productFeignClient.getCategory(sku.getCategoryId());
        //封装数据skuEs
        SkuEs skuEs = new SkuEs();
        if(category != null){
            skuEs.setCategoryId(category.getId());
            skuEs.setCategoryName(category.getName());
        }
        skuEs.setId(sku.getId());
        skuEs.setKeyword(sku.getSkuName()+","+skuEs.getCategoryName());
        skuEs.setWareId(sku.getWareId());
        skuEs.setIsNewPerson(sku.getIsNewPerson());
        skuEs.setImgUrl(sku.getImgUrl());
        skuEs.setTitle(sku.getSkuName());
        if(sku.getSkuType() == SkuType.COMMON.getCode()) {//先都按照普通商品封装
            skuEs.setSkuType(0);
            skuEs.setPrice(sku.getPrice().doubleValue());
            skuEs.setStock(sku.getStock());
            skuEs.setSale(sku.getSale());
            skuEs.setPerLimit(sku.getPerLimit());
        } else {
            //TODO 待完善-秒杀商品

        }

        //添加
        skuRepository.save(skuEs);
    }

    //下架
    @Override
    public void lowerSku(Long skuId) {
        skuRepository.deleteById(skuId);
    }

    //获取爆款商品
    @Override
    public List<SkuEs> findHotSkuList() {
        Pageable pageable = PageRequest.of(0,10);
        Page<SkuEs> pageModel = skuRepository.findByOrderByHotScoreDesc(pageable);
        List<SkuEs> content = pageModel.getContent();
        return content;
    }

    @Override
    public Page<SkuEs> search(Pageable pageable, SkuEsQueryVo skuEsQueryVo) {
        //1 设置一个条件，wareId，当前登录用户的仓库id
        skuEsQueryVo.setWareId(AuthContextHolder.getWareId());
        //2 调用SkuRepository方法条件查询
        Page<SkuEs> pageModel = null;
        String keyword = skuEsQueryVo.getKeyword();
        //3 判断keyword是否为空，如果空，则根据仓库id和分类id查询，如果不为空则加上keyword查询
//        if(!StringUtils.isEmpty(keyword)){
//            pageModel = skuRepository.findByWareIdAndCategoryId(
//                    skuEsQueryVo.getWareId(),skuEsQueryVo.getCategoryId(),pageable);
//        } else {
//            pageModel = skuRepository.findByWareIdAndKeyword(
//                    skuEsQueryVo.getWareId(),keyword,pageable);
//        }
        if(StringUtils.isEmpty(skuEsQueryVo.getKeyword())) {
            pageModel = skuRepository.findByCategoryIdAndWareId(skuEsQueryVo.getCategoryId(), skuEsQueryVo.getWareId(), pageable);
        } else {
            pageModel = skuRepository.findByKeywordAndWareId(skuEsQueryVo.getKeyword(), skuEsQueryVo.getWareId(), pageable);
        }
        //4 查询商品目前参加的优惠活动
        List<SkuEs> skuEsList = pageModel.getContent();
        if (!CollectionUtils.isEmpty(skuEsList)) {
            //遍历，得到所有id，查询优惠活动
            List<Long> skuIdList = skuEsList.stream().map(SkuEs::getId).collect(Collectors.toList());
            //根据skuId列表远程调用service-activity中的方法得到数据
            Map<Long,List<String>> skuIdToRuleListMap = activityFeignClient.findActivity(skuIdList);
            if (skuIdToRuleListMap != null){
                skuEsList.forEach(skuEs ->{
                    skuEs.setRuleList(skuIdToRuleListMap.get(skuEs.getId()));
                });
            }
        }
        //5 返回数据
        return pageModel;
    }

    //更新热度
    @Override
    public void incrHotScore(Long skuId) {
        //es储存是用io操作效率很低，可以用redis实现
        String key = "hotScore";
        Double hotScore = redisTemplate.opsForZSet().incrementScore(key, "skuId" + skuId, 1);
        //更新规则
        if(hotScore%10==0){
            Optional<SkuEs> optional = skuRepository.findById(skuId);
            SkuEs skuEs = optional.get();
            skuEs.setHotScore(Math.round(hotScore));
            skuRepository.save(skuEs);
        }
    }
}
