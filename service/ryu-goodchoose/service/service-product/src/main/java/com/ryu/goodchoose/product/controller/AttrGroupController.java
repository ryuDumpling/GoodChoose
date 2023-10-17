package com.ryu.goodchoose.product.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.model.product.AttrGroup;
import com.ryu.goodchoose.product.service.AttrGroupService;
import com.ryu.goodchoose.vo.product.AttrGroupQueryVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 属性分组 前端控制器
 * </p>
 *
 * @author ryu
 * @since 2023-10-04
 */
@Api(tags = "商品分组")
@RestController
@RequestMapping("/admin/product/attrGroup")
//@CrossOrigin //跨域请求
public class AttrGroupController {
    @Autowired
    private AttrGroupService attrGroupService;

    //分组列表
    @ApiOperation("分组列表")
    @GetMapping("/{page}/{limit}")
    public Result list(@PathVariable Long page,
                       @PathVariable Long limit,
                       AttrGroupQueryVo attrGroupQueryVo){
        //page:当前页 limit：每页显示数据量
        Page<AttrGroup> pageParam = new Page<>(page,limit);
        //调用service方法实现分页查询，返回分页对象
        IPage<AttrGroup> pageModel= attrGroupService.selectPageAttrGroup(pageParam,attrGroupQueryVo);
        return Result.ok(pageModel);
    }

    @ApiOperation(value = "获取分组信息")
    @GetMapping("/get/{id}")
    public Result get(@PathVariable Long id) {
        AttrGroup attrGroup = attrGroupService.getById(id);
        return Result.ok(attrGroup);
    }

    @ApiOperation(value = "新增分组")
    @PostMapping("/save")
    public Result save(@RequestBody AttrGroup attrGroup) {
        attrGroupService.save(attrGroup);
        return Result.ok(null);
    }

    @ApiOperation(value = "修改分组")
    @PutMapping("/update")
    public Result updateById(@RequestBody AttrGroup attrGroup) {
        attrGroupService.updateById(attrGroup);
        return Result.ok(null);
    }

    @ApiOperation(value = "删除分组")
    @DeleteMapping("/remove/{id}")
    public Result remove(@PathVariable Long id) {
        attrGroupService.removeById(id);
        return Result.ok(null);
    }

    @ApiOperation(value = "根据id列表删除分组")
    @DeleteMapping("/batchRemove")
    public Result batchRemove(@RequestBody List<Long> idList) {
        attrGroupService.removeByIds(idList);
        return Result.ok(null);
    }

    @ApiOperation(value = "获取全部分组")
    @GetMapping("/findAllList")
    public Result findAllList() {
        List<AttrGroup> list = attrGroupService.findAllList();
        return Result.ok(list);
    }
}

