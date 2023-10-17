package com.ryu.goodchoose.home.service.impl;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ryu.goodchoose.activity.client.ActivityFeignClient;
import com.ryu.goodchoose.client.product.ProductFeignClient;
import com.ryu.goodchoose.client.search.SkuFeignClient;
import com.ryu.goodchoose.client.user.UserFeignClient;
import com.ryu.goodchoose.home.config.ThreadPoolConfig;
import com.ryu.goodchoose.home.service.ItemService;
import com.ryu.goodchoose.vo.product.SkuInfoVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ThreadPoolExecutor;

/**
 * @author ryuDumpling
 * @version 2023/10/13 19:08
 */
@Service
public class ItemServiceImpl implements ItemService {
    //自定义的线程池
    @Resource
    private ThreadPoolExecutor threadPoolExecutor;

    @Autowired
    private ActivityFeignClient activityFeignClient;

    @Autowired
    private UserFeignClient userFeignClient;

    @Autowired
    private ProductFeignClient productFeignClient;

    @Autowired
    private SkuFeignClient skuFeignClient;

    @Override
    public Map<String, Object> item(Long skuId, Long userId) {
        Map<String, Object> result = new HashMap<>();
        //skuID查询
        CompletableFuture<SkuInfoVo> skuInfoCompletable = CompletableFuture.supplyAsync(() -> {
            //远程调用得到信息
            SkuInfoVo skuInfoVo = productFeignClient.getSkuInfoVo(skuId);
            result.put("skuInfoVo", skuInfoVo);
            return skuInfoVo;
        },threadPoolExecutor);
        //sku得到活动信息
        CompletableFuture<Void> activityCompletable = CompletableFuture.runAsync(() -> {
            //远程调用得到活动信息
            Map<String, Object> activityMap = activityFeignClient.findActivityAndCoupon(skuId,userId);
            result.putAll(activityMap);
        },threadPoolExecutor);
        //更新商品热度
        CompletableFuture<Void> hotCompletable = CompletableFuture.runAsync(() -> {
            skuFeignClient.incrHotScore(skuId);
        },threadPoolExecutor);
        //任务组合
        CompletableFuture.allOf(skuInfoCompletable,activityCompletable,hotCompletable).join();
        return result;
    }
}
