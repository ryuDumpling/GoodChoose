package com.ryu.goodchoose.sys.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.common.util.MD5;
import com.ryu.goodchoose.model.acl.Admin;
import com.ryu.goodchoose.model.sys.RegionWare;
import com.ryu.goodchoose.model.sys.Ware;
import com.ryu.goodchoose.sys.service.WareService;
import com.ryu.goodchoose.vo.product.WareQueryVo;
import com.ryu.goodchoose.vo.sys.RegionWareQueryVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 仓库表 前端控制器
 * </p>
 *
 * @author ryu
 * @since 2023-10-03
 */
@Api(tags = "仓库")
@RestController
@RequestMapping("/admin/sys/ware")
//@CrossOrigin
public class WareController {

    @Autowired
    private WareService wareService;

    //添加
    @ApiOperation("添加仓库")
    @PostMapping("/save")
    public Result save(@RequestBody Ware ware){
        boolean succ = wareService.save(ware);
        if(succ){
            return Result.ok(null);
        }
        return Result.fail(null);
    }
    //修改
    @ApiOperation("修改仓库")
    @PutMapping("/update")
    public Result update(@RequestBody Ware ware){
        ware.setUpdateTime(null);
        boolean succ = wareService.updateById(ware);
        if(succ){
            return Result.ok(null);
        }
        return Result.fail(null);
    }

    //根据id删除
    @ApiOperation("根据id删除仓库")
    @DeleteMapping("/remove/{id}")
    public Result remove(@PathVariable("id") Long id){
        boolean succ = wareService.removeById(id);
        if(succ){
            return Result.ok(null);
        }
        return Result.fail(null);
    }
    //批量删除
    @ApiOperation("批量删除仓库")
    @DeleteMapping("/batchRemove")
    public Result batchRemove(@RequestBody List<Ware> wareList){
        boolean succ = wareService.removeByIds(wareList);
        if(succ){
            return Result.ok(null);
        }
        return Result.fail(null);
    }


    //查询所有仓库
    @ApiOperation("查询所有仓库")
    @GetMapping("/findAllList")
    public Result findAllList(){
        List<Ware> list = wareService.list();
        return Result.ok(list);
    }


    //条件查询仓库
    @ApiOperation("仓库查询分页")
    @GetMapping("/{page}/{limit}")
    public Result list(@PathVariable Long page,
                       @PathVariable Long limit,
                       WareQueryVo wareQueryVo){
        //page:当前页 limit：每页显示数据量
        Page<Ware> pageParam = new Page<>(page,limit);
        //调用service方法实现分页查询，返回分页对象
        IPage<Ware> pageModel= wareService.selectPageWare(pageParam,wareQueryVo);
        return Result.ok(pageModel);
    }
}

