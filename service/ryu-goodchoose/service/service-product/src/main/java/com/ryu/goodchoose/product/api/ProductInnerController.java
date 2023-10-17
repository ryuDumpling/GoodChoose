package com.ryu.goodchoose.product.api;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.ryu.goodchoose.model.product.Category;
import com.ryu.goodchoose.model.product.SkuInfo;
import com.ryu.goodchoose.product.service.CategoryService;
import com.ryu.goodchoose.product.service.SkuInfoService;
import com.ryu.goodchoose.vo.product.SkuInfoVo;
import com.ryu.goodchoose.vo.product.SkuStockLockVo;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author ryuDumpling
 * 远程调用接口
 * @version 2023/10/9 15:06
 */
@RestController
@RequestMapping("/api/product")
public class ProductInnerController {
    @Autowired
    private CategoryService categoryService;

    @Autowired
    private SkuInfoService skuInfoService;

     //根据分类Id获取分类信息
    @GetMapping("/inner/gerCategory/{categoryId}")
    public Category getCategory(@PathVariable Long categoryId){
        return categoryService.getById(categoryId);
    }
    //根据skuId获取sku信息
    @GetMapping("/inner/getSkuInfo/{skuId}")
    public SkuInfo getSku(@PathVariable Long skuId){
        return skuInfoService.getById(skuId);
    }

    //根据skuIdList获取商品信息并返回
    @PostMapping("/inner/findSkuInfoList")
    public List<SkuInfo> findSkuInfoList(@RequestBody List<Long> skuIdList){
        return skuInfoService.findSkuInfoList(skuIdList);
    }

    //根据关键字获取商品信息
    @GetMapping("/inner/findSkuInfoByKeyword/{keyword}")
    public List<SkuInfo> findSkuInfoByKeyword(@PathVariable("keyword") String keyword){
        List<SkuInfo> skuInfoList = skuInfoService.selectList(keyword);
        return skuInfoList;
    }

    //根据id获取categoryList
    @PostMapping("/inner/findCategoryList")
    public List<Category> findCategoryList(@RequestBody List<Long> rangeIdList){
        List<Category> categoryList = categoryService.listByIds(rangeIdList);
        return categoryList;
    }

    //获取所有分类
    @GetMapping("/inner/findAllCategoryList")
    public List<Category> findAllCategoryList(){
        List<Category> list = categoryService.list();
        return list;
    }

    //获取新人专享商品
    @GetMapping("/inner/findNewPersonSkuInfoList")
    public List<SkuInfo> findNewPersonSkuInfoList(){
        List<SkuInfo> list = skuInfoService.findNewPersonSkuInfoList();
        return list;
    }

    //根据skuId获取sku信息
    @GetMapping("/inner/getSkuInfoVo/{skuId}")
    public SkuInfoVo getSkuInfoVo(@PathVariable Long skuId){
        return skuInfoService.getSkuInfoVoById(skuId);
    }

    //验证&锁定库存
    @ApiOperation(value = "锁定库存")
    @PostMapping("inner/checkAndLock/{orderNo}")
    public Boolean checkAndLock(@RequestBody List<SkuStockLockVo> skuStockLockVoList, @PathVariable String orderNo) {
        return skuInfoService.checkAndLock(skuStockLockVoList, orderNo);
    }
}
