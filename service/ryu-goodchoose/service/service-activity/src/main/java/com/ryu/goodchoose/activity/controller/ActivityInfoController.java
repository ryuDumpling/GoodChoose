package com.ryu.goodchoose.activity.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ryu.goodchoose.activity.mapper.ActivityRuleMapper;
import com.ryu.goodchoose.activity.service.ActivityInfoService;
import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.model.acl.Admin;
import com.ryu.goodchoose.model.activity.ActivityInfo;
import com.ryu.goodchoose.model.activity.ActivityRule;
import com.ryu.goodchoose.model.product.SkuInfo;
import com.ryu.goodchoose.vo.activity.ActivityRuleVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 活动表 前端控制器
 * </p>
 *
 * @author ryu
 * @since 2023-10-11
 */
@Api(tags = "营销活动")
@RestController
@RequestMapping("/admin/activity/activityInfo")
//@CrossOrigin
public class ActivityInfoController {
    @Autowired
    private ActivityInfoService activityInfoService;

    @Autowired
    private ActivityRuleMapper activityRuleMapper;

    //营销规则相关接口
    //根据活动id获取活动规则列表
    //findActivityRuleList
    @ApiOperation("根据活动id获取活动规则列表")
    @GetMapping("/findActivityRuleList/{id}")
    public Result findActivityRuleList(@PathVariable("id") Long id){
        Map<String ,Object> activityRuleList = activityInfoService.findActivityRuleList(id);
        return Result.ok(activityRuleList);
    }

    //在活动里添加规则数据
    @ApiOperation("在活动里添加规则数据")
    @PostMapping("/saveActivityRule")
    public Result saveActivityRule(@RequestBody ActivityRuleVo activityRuleVo){
        activityInfoService.saveActivityRule(activityRuleVo);
        return Result.ok(null);
    }

    //根据关键字查询匹配的sku信息
    @ApiOperation("根据关键字查询匹配的sku信息")
    @GetMapping("/findSkuInfoByKeyword/{keyword}")
    public Result findSkuInfoByKeyword(@PathVariable("keyword") String keyword){
        List<SkuInfo> skuInfoList = activityInfoService.findSkuInfoByKeyword(keyword);
        return Result.ok(skuInfoList);
    }


    //营销活动相关接口
    //获取营销活动列表
    @ApiOperation("营销活动列表")
    @GetMapping("/{page}/{limit}")
    public Result list(@PathVariable Long page,
                       @PathVariable Long limit){
        Page<ActivityInfo> pageParam = new Page<>(page,limit);
        IPage<ActivityInfo> pageModel = activityInfoService.selectPage(pageParam);
        return Result.ok(pageModel);
    }

    @ApiOperation("添加活动")
    @PostMapping("/save")
    public Result save(@RequestBody ActivityInfo activityInfo){
        activityInfoService.save(activityInfo);
        return Result.ok(null);
    }

    //添加规则

    //修改
    @ApiOperation("修改营销活动")
    @PutMapping("/update")
    public Result update(@RequestBody ActivityInfo activityInfo){
        activityInfo.setUpdateTime(null);
        boolean succ = activityInfoService.updateById(activityInfo);
        if(succ){
            return Result.ok(null);
        }
        return Result.fail(null);
    }
    //根据id删除
    @ApiOperation("根据id删除营销活动")
    @DeleteMapping("/remove/{id}")
    public Result remove(@PathVariable("id") Long id){
        boolean succ = activityInfoService.removeById(id);
        if(succ){
            activityInfoService.deleteRuleAndSku(id);
            return Result.ok(null);
        }
        return Result.fail(null);
    }
    //批量删除
    @ApiOperation("批量删除营销活动")
    @DeleteMapping("/batchRemove")
    public Result batchRemove(@RequestBody List<Long> idList){
        boolean succ = activityInfoService.removeByIds(idList);
        if(succ){
            return Result.ok(null);
        }
        return Result.fail(null);
    }

    //获取活动的当前规则
    @ApiOperation("根据活动id获取活动信息")
    @GetMapping("/get/{id}")
    public Result get(@PathVariable("id") Long id){
        ActivityInfo activityInfo = activityInfoService.getById(id);
        activityInfo.setActivityTypeString(activityInfo.getActivityType().getComment());
        return Result.ok(activityInfo);
    }
}

