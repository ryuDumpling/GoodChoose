package com.ryu.goodchoose.payment.controller;

import com.ryu.goodchoose.common.exception.GcException;
import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.common.result.ResultCodeEnum;
import com.ryu.goodchoose.enums.PaymentType;
import com.ryu.goodchoose.payment.service.PaymentService;
import com.ryu.goodchoose.payment.service.WeixinService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * @author ryuDumpling
 * TODO 支付功能未完成，appId与openId不一致，需要商家码
 * @version 2023/10/16 12:25
 */

@Api(tags = "微信支付接口")
@RestController
@RequestMapping("/api/payment/weixin")
public class WeixinController {
    @Autowired
    private WeixinService weixinPayService;

    @Autowired
    private PaymentService paymentService;

    @ApiOperation(value = "下单 小程序支付")
    @GetMapping("/createJsapi/{orderNo}")
    public Result createJsapi(@PathVariable("orderNo") String orderNo) {
        return Result.ok(weixinPayService.createJsapi(orderNo));
    }

    //查询订单的支付状态
    @GetMapping("/queryPayStatus/{orderNo}")
    public Result queryPayStatus(@PathVariable("orderNo") String orderNo) {
        Map<String,String> resultMap = weixinPayService.queryPayStatus(orderNo);
        if (resultMap==null){
            return Result.build(null, ResultCodeEnum.FAIL);
        }
        if ("SUCCESS".equals(resultMap.get("return_code"))) {//如果成功
            //更改订单状态，处理支付结果
            String out_trade_no = resultMap.get("order");
            paymentService.paySuccess(orderNo, PaymentType.WEIXIN, resultMap);
            return Result.ok("支付成功");
        }
        return Result.ok("支付中");
    }
}
