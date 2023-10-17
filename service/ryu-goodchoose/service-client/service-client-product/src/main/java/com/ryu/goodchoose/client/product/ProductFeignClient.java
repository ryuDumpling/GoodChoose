package com.ryu.goodchoose.client.product;

import com.ryu.goodchoose.model.product.Category;
import com.ryu.goodchoose.model.product.SkuInfo;
import com.ryu.goodchoose.vo.product.SkuInfoVo;
import com.ryu.goodchoose.vo.product.SkuStockLockVo;
import io.swagger.annotations.ApiOperation;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@FeignClient(value = "service-product")
public interface ProductFeignClient {
    //根据分类Id获取分类信息
    @GetMapping("/api/product/inner/gerCategory/{categoryId}")
    Category getCategory(@PathVariable("categoryId") Long categoryId);
    //根据skuId获取sku信息
    @GetMapping("/api/product/inner/getSkuInfo/{skuId}")
    SkuInfo getSku(@PathVariable("skuId")Long skuId);
    //根据skuIdList获取商品信息
    @PostMapping("/api/product/inner/findSkuInfoList")
    List<SkuInfo> findSkuInfoList(@RequestBody List<Long> skuIdList);

    @GetMapping("/api/product/inner/findSkuInfoByKeyword/{keyword}")
    List<SkuInfo> findSkuInfoByKeyword(@PathVariable("keyword") String keyword);

    @PostMapping("/api/product/inner/findCategoryList")
    List<Category> findCategoryList(@RequestBody List<Long> rangeIdList);

    @GetMapping("/api/product/inner/findAllCategoryList")
    public List<Category> findAllCategoryList();

    @GetMapping("/api/product/inner/findNewPersonSkuInfoList")
    public List<SkuInfo> findNewPersonSkuInfoList();

    //根据skuId获取sku信息
    @GetMapping("/api/product/inner/getSkuInfoVo/{skuId}")
    public SkuInfoVo getSkuInfoVo(@PathVariable Long skuId);

    //验证&锁定库存
    @PostMapping("/api/product/inner/checkAndLock/{orderNo}")
    public Boolean checkAndLock(@RequestBody List<SkuStockLockVo> skuStockLockVoList, @PathVariable String orderNo);
}
