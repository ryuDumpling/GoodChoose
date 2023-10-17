package com.ryu.goodchoose.activity.api;

import com.ryu.goodchoose.activity.service.ActivityInfoService;
import com.ryu.goodchoose.activity.service.CouponInfoService;
import com.ryu.goodchoose.model.activity.CouponInfo;
import com.ryu.goodchoose.model.order.CartInfo;
import com.ryu.goodchoose.vo.order.CartInfoVo;
import com.ryu.goodchoose.vo.order.OrderConfirmVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * @author ryuDumpling
 * @version 2023/10/13 16:05
 */
@Api(tags = "促销与优惠券接口")
@RestController
@RequestMapping("/api/activity")
public class ActivityInfoApiController {
    @Autowired
    private ActivityInfoService activityInfoService;

    @Autowired
    private CouponInfoService couponInfoService;

    @ApiOperation(value = "根据skuId列表获取促销信息")
    @PostMapping("inner/findActivity")
    public Map<Long, List<String>> findActivity(@RequestBody List<Long> skuIdList) {
        return activityInfoService.findActivity(skuIdList);
    }

    //根据userId和skuId获取优惠券和活动信息
    @GetMapping("/inner/findActivityAndCoupon/{skuId}/{userId}")
    public Map<String, Object> findActivityAndCoupon(@PathVariable("skuId") Long skuId,
                                                     @PathVariable("userId") Long userId
    ){
        return activityInfoService.findActivityAndCoupon(skuId,userId);
    }

    //根据cartInfoList得到优惠券和活动信息
    @PostMapping("/inner/findCartActivityAndCoupon/{userId}")
    public OrderConfirmVo findCartActivityAndCoupon(@RequestBody List<CartInfo> cartInfoList,
                                                    @PathVariable("userId") Long userId
    ){
        return activityInfoService.findCartActivityAndCoupon(cartInfoList,userId);
    }

    //获取购物项对应的规则数据
    @PostMapping("/inner/findCartActivityList")
    public List<CartInfoVo> findCartActivityList(@RequestBody List<CartInfo> cartInfoList){
        return activityInfoService.findCartActivityList(cartInfoList);
    }

    //得到使用范围
    @PostMapping("/inner/findRangeSkuIdList/{couponId}")
    public CouponInfo findRangeSkuIdList(@RequestBody List<CartInfo> cartInfoList, @PathVariable Long couponId){
        return couponInfoService.findRangeSkuIdList(cartInfoList,couponId);
    }
    //更新
    @GetMapping("/inner/updateCouponInfoUseStatus/{couponId}/{userId}/{orderId}")
    public Boolean updateCouponInfoUseStatus(@PathVariable("couponId") Long couponId,
                                             @PathVariable("userId") Long userId,
                                             @PathVariable("orderId") Long orderId){
        return couponInfoService.updateCouponInfoUseStatus(couponId,userId,orderId);
    }
}
