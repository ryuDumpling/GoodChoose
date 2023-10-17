package com.ryu.goodchoose.payment.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ryu.goodchoose.client.order.OrderFeignClient;
import com.ryu.goodchoose.common.exception.GcException;
import com.ryu.goodchoose.common.result.ResultCodeEnum;
import com.ryu.goodchoose.enums.PaymentStatus;
import com.ryu.goodchoose.enums.PaymentType;
import com.ryu.goodchoose.model.order.OrderInfo;
import com.ryu.goodchoose.model.order.PaymentInfo;
import com.ryu.goodchoose.mq.constant.MqConst;
import com.ryu.goodchoose.mq.service.RabbitService;
import com.ryu.goodchoose.payment.mapper.PaymentMapper;
import com.ryu.goodchoose.payment.service.PaymentService;
import org.bouncycastle.pqc.jcajce.provider.qtesla.SignatureSpi;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Map;

/**
 * @author ryuDumpling
 * @version 2023/10/16 12:29
 */
@Service
public class PaymentServiceImpl extends ServiceImpl<PaymentMapper, PaymentInfo> implements PaymentService {

    @Autowired
    private OrderFeignClient orderFeignClient;

    @Autowired
    private RabbitService rabbitService;

    //查询记录
    @Override
    public PaymentInfo getPaymentByOrderNo(String orderNo) {
        PaymentInfo paymentInfo = baseMapper.selectOne(
                new LambdaQueryWrapper<PaymentInfo>().eq(PaymentInfo::getOrderNo, orderNo)
        );
        return paymentInfo;
    }

    //添加记录
    @Override
    public PaymentInfo savePaymentInfo(String orderNo) {
        OrderInfo orderInfo = orderFeignClient.getOrderInfo(orderNo);
        if (orderInfo == null){
            throw new GcException(ResultCodeEnum.DATA_ERROR);
        }
        // 保存交易记录
        PaymentInfo paymentInfo = new PaymentInfo();
        paymentInfo.setCreateTime(new Date());
        paymentInfo.setOrderId(orderInfo.getId());
        paymentInfo.setPaymentType(PaymentType.WEIXIN);
        paymentInfo.setUserId(orderInfo.getUserId());
        paymentInfo.setOrderNo(orderInfo.getOrderNo());
        paymentInfo.setPaymentStatus(PaymentStatus.PAID);
        String subject = "userId"+orderInfo.getUserId()+"下订单";
        paymentInfo.setSubject(subject);
        //TODO 为了测试统一0.01r
        //paymentInfo.setTotalAmount(order.getTotalAmount());
        paymentInfo.setTotalAmount(new BigDecimal("0.01"));
        baseMapper.insert(paymentInfo);
        return paymentInfo;
    }

    @Override
    public void paySuccess(String orderNo, PaymentType weixin, Map<String, String> resultMap) {
        //查看支付表中的支付状态
        PaymentInfo paymentInfo = baseMapper.selectOne(
                new LambdaQueryWrapper<PaymentInfo>().eq(PaymentInfo::getOrderNo, orderNo)
        );
        //如果已经支付
        if (paymentInfo.getPaymentStatus() != PaymentStatus.UNPAID){
            return;
        }
        //如果没支付,更新
        paymentInfo.setPaymentStatus(PaymentStatus.PAID);
        paymentInfo.setTradeNo(resultMap.get("transaction_id"));
        paymentInfo.setCallbackTime(new Date());
        paymentInfo.setCallbackContent(resultMap.toString());
        baseMapper.updateById(paymentInfo);
        // 表示交易成功！

        //发送消息
        rabbitService.sendMessage(MqConst.EXCHANGE_PAY_DIRECT, MqConst.ROUTING_PAY_SUCCESS, orderNo);
    }
}
