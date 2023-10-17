package com.ryu.goodchoose.activity.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ryu.goodchoose.activity.service.CouponInfoService;
import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.model.activity.ActivityInfo;
import com.ryu.goodchoose.model.activity.CouponInfo;
import com.ryu.goodchoose.vo.activity.CouponRuleVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * <p>
 * 优惠券信息 前端控制器
 * </p>
 *
 * @author ryu
 * @since 2023-10-11
 */
@Api(tags = "优惠券活动")
@RestController
//@CrossOrigin
@RequestMapping("/admin/activity/couponInfo")
public class CouponInfoController {
    @Autowired
    private CouponInfoService couponInfoService;

    //优惠券分页查询
    @ApiOperation("优惠券分页查询")
    @GetMapping("/{page}/{limit}")
    public Result list(@PathVariable Long page,
                       @PathVariable Long limit){
        IPage<CouponInfo> pageModel = couponInfoService.selectPageCouponInfo(page,limit);
        return Result.ok(pageModel);
    }

    //添加优惠券
    @ApiOperation("添加优惠券")
    @PostMapping("/save")
    public Result save(@RequestBody CouponInfo couponInfo){
        couponInfoService.save(couponInfo);
        return Result.ok(null);
    }

    //根据id查询优惠券
    @ApiOperation("根据id查询优惠券")
    @GetMapping("/get/{id}")
    public Result get(@PathVariable Long id){
        CouponInfo couponInfo = couponInfoService.getCouponInfo(id);
        return Result.ok(couponInfo);
    }

    //根据优惠券查询对应规则
    @ApiOperation("根据优惠券查询对应规则")
    @GetMapping("/findCouponRuleList/{id}")
    public Result findCouponRuleList(@PathVariable Long id){
        Map<String, Object> map = couponInfoService.findCouponRuleList(id);
        return Result.ok(map);
    }

    //添加优惠券规则
    @ApiOperation("添加优惠券规则")
    @PostMapping("/saveCouponRule")
    public Result saveCouponRule(@RequestBody CouponRuleVo couponRuleVo){
        couponInfoService.saveCouponRule(couponRuleVo);
        return Result.ok(null);
    }

    //修改优惠券
    @ApiOperation("修改营销活动")
    @PutMapping("/update")
    public Result update(@RequestBody CouponInfo couponInfo){
        couponInfo.setUpdateTime(null);
        boolean succ = couponInfoService.updateById(couponInfo);
        if(succ){
            return Result.ok(null);
        }
        return Result.fail(null);
    }
    //根据id删除
    @ApiOperation("根据id删除营销活动")
    @DeleteMapping("/remove/{id}")
    public Result remove(@PathVariable("id") Long id){
        boolean succ = couponInfoService.removeById(id);
        if(succ){
            couponInfoService.deleteRule(id);
            return Result.ok(null);
        }
        return Result.fail(null);
    }
}

