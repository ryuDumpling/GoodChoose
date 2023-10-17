package com.ryu.goodchoose.sys.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.model.acl.Role;
import com.ryu.goodchoose.model.sys.RegionWare;
import com.ryu.goodchoose.sys.service.RegionWareService;
import com.ryu.goodchoose.vo.sys.RegionWareQueryVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 城市仓库关联表 前端控制器
 * </p>
 *
 * @author ryu
 * @since 2023-10-03
 */
@Api(tags = "开通区域")
@RestController
@RequestMapping("/admin/sys/regionWare")
//@CrossOrigin
public class RegionWareController {

    @Autowired
    private RegionWareService regionWareService;

    //开通区域列表
    @ApiOperation("开通区域列表")
    @GetMapping("/{page}/{limit}")
    public Result list(@PathVariable Long page,
                       @PathVariable Long limit,
                       RegionWareQueryVo regionWareQueryVo){
        //page:当前页 limit：每页显示数据量
        Page<RegionWare> pageParam = new Page<>(page,limit);
        //调用service方法实现分页查询，返回分页对象
        IPage<RegionWare> pageModel= regionWareService.selectPageRegionWare(pageParam,regionWareQueryVo);
        return Result.ok(pageModel);
    }

    //添加开通区域
    @ApiOperation("添加开通区域")
    @PostMapping("/save")
    public Result addRegionWare(@RequestBody RegionWare regionWare){
        regionWareService.saveRegionWare(regionWare);
        return Result.ok(null);
    }

    //删除开通区域-id
    @ApiOperation("删除开通区域id")
    @DeleteMapping("/remove/{id}")
    public Result remove(@PathVariable("id")Long id){
        regionWareService.removeById(id);
        return Result.ok(null);
    }

    //取消开通区域
    @ApiOperation("取消开通区域")
    @PostMapping("/updateStatus/{id}/{status}")
    public Result updateStatus(@PathVariable("id")Long id, @PathVariable("status") Integer status){
        regionWareService.updateStatus(id,status);
        return Result.ok(null);
    }
}

