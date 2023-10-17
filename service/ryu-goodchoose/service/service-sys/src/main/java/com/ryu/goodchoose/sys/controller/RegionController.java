package com.ryu.goodchoose.sys.controller;


import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.model.sys.Region;
import com.ryu.goodchoose.sys.service.RegionService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 地区表 前端控制器
 * </p>
 *
 * @author ryu
 * @since 2023-10-03
 */
@Api(tags = "区域")
@RestController
@RequestMapping("/admin/sys/region")
//@CrossOrigin
public class RegionController {

    @Autowired
    private RegionService regionService;

    @ApiOperation("根据关键字查询地区列表信息")
    @GetMapping("/findRegionByKeyword/{keyword}")
    public Result findRegionByKeyword(@PathVariable("keyword") String keyword){
        List<Region> regions = regionService.getRegionByKeyword(keyword);
        return Result.ok(regions);
    }
}

