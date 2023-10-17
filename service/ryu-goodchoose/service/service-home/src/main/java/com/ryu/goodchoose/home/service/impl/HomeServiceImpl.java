package com.ryu.goodchoose.home.service.impl;

import com.ryu.goodchoose.client.product.ProductFeignClient;
import com.ryu.goodchoose.client.search.SkuFeignClient;
import com.ryu.goodchoose.client.user.UserFeignClient;
import com.ryu.goodchoose.home.service.HomeService;
import com.ryu.goodchoose.model.product.Category;
import com.ryu.goodchoose.model.product.SkuInfo;
import com.ryu.goodchoose.model.search.SkuEs;
import com.ryu.goodchoose.vo.user.LeaderAddressVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author ryuDumpling
 * @version 2023/10/13 10:25
 */
@Service
public class HomeServiceImpl implements HomeService {

    @Autowired
    private UserFeignClient userFeignClient;

    @Autowired
    private ProductFeignClient productFeignClient;

    @Autowired
    private SkuFeignClient skuFeignClient;
    //显示首页数据
    @Override
    public Map<String, Object> homeData(Long userId) {
        Map<String, Object> result = new HashMap<>();
        //根据userId获取提货信息-远程调用service-user中的接口
        LeaderAddressVo userAddressByUserId = userFeignClient.getUserAddressByUserId(userId);
        result.put("leaderAddressVo",userAddressByUserId);
        //获取所有分类信息-远程调用service-product中的接口
        List<Category> allCategoryList = productFeignClient.findAllCategoryList();
        result.put("categoryList",allCategoryList);
        //获取新人专享商品
        List<SkuInfo> newPersonSkuInfoList = productFeignClient.findNewPersonSkuInfoList();
        result.put("newPersonSkuInfoList",newPersonSkuInfoList);
        //获取爆款产品-远程调用service-search接口 -根据HotScore属性降序排列
        List<SkuEs> hotSkuList = skuFeignClient.findHotSkuList();
        result.put("hotSkuList",hotSkuList);
        //封装数据返回
        return result;
    }
}
