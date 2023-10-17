package com.ryu.goodchoose.product.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.model.product.SkuInfo;
import com.ryu.goodchoose.product.service.SkuInfoService;
import com.ryu.goodchoose.vo.product.SkuInfoQueryVo;
import com.ryu.goodchoose.vo.product.SkuInfoVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * sku信息 前端控制器
 * </p>
 *
 * @author ryu
 * @since 2023-10-04
 */
@Api(tags = "sku")
@RestController
@RequestMapping("/admin/product/skuInfo")
//@CrossOrigin //跨域请求
public class SkuInfoController {

    @Autowired
    private SkuInfoService skuInfoService;

    //sku列表
    @ApiOperation("sku列表")
    @GetMapping("/{page}/{limit}")
    public Result list(@PathVariable Long page,
                       @PathVariable Long limit,
                       SkuInfoQueryVo skuInfoQueryVo){
        //page:当前页 limit：每页显示数据量
        Page<SkuInfo> pageParam = new Page<>(page,limit);
        //调用service方法实现分页查询，返回分页对象
        IPage<SkuInfo> pageModel= skuInfoService.selectPageSkuInfo(pageParam,skuInfoQueryVo);
        return Result.ok(pageModel);
    }

    @ApiOperation(value = "获取sku信息")
    @GetMapping("/get/{id}")
    public Result get(@PathVariable Long id) {
        SkuInfoVo skuInfoVo = skuInfoService.getSkuInfoById(id);
        return Result.ok(skuInfoVo);
    }

    //添加商品的sku
    @ApiOperation(value = "新增sku")
    @PostMapping("/save")
    public Result save(@RequestBody SkuInfoVo skuInfoVo) {
        skuInfoService.saveSkuInfo(skuInfoVo);
        return Result.ok(null);
    }

    @ApiOperation(value = "修改sku")
    @PutMapping("/update")
    public Result updateById(@RequestBody SkuInfoVo skuInfoVo) {
        skuInfoService.updateSkuInfo(skuInfoVo);
        return Result.ok(null);
    }

    @ApiOperation(value = "删除")
    @DeleteMapping("remove/{id}")
    public Result remove(@PathVariable Long id) {
        skuInfoService.removeSkuInfoById(id);
        return Result.ok(null);
    }

    @ApiOperation(value = "根据id列表删除")
    @DeleteMapping("batchRemove")
    public Result batchRemove(@RequestBody List<Long> idList) {
        skuInfoService.removeAllByIds(idList);
        return Result.ok(null);
    }

    @ApiOperation(value = "获取全部sku")
    @GetMapping("/findAllList")
    public Result findAllList() {
        return Result.ok(skuInfoService.list());
    }

    @ApiOperation("商品审核")
    @GetMapping("/check/{skuId}/{status}")
    public Result check(@PathVariable Long skuId,@PathVariable Integer status){
        skuInfoService.check(skuId,status);
        return Result.ok(null);
    }

    @ApiOperation("商品上下架")
    @GetMapping("/publish/{skuId}/{status}")
    public Result publish(@PathVariable Long skuId,@PathVariable Integer status){
        skuInfoService.publish(skuId,status);
        return Result.ok(null);
    }

    @ApiOperation("新人专享")
    @GetMapping("/isNewPerson/{skuId}/{status}")
    public Result isNewPerson(@PathVariable Long skuId,@PathVariable Integer status){
        skuInfoService.isNewPerson(skuId,status);
        return Result.ok(null);
    }
}

