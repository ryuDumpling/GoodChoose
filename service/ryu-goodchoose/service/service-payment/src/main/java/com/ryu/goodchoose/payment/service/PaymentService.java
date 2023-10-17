package com.ryu.goodchoose.payment.service;

import com.ryu.goodchoose.enums.PaymentType;
import com.ryu.goodchoose.model.order.PaymentInfo;

import java.util.Map;

public interface PaymentService {
    PaymentInfo getPaymentByOrderNo(String orderNo);

    PaymentInfo savePaymentInfo(String orderNo);

    void paySuccess(String orderNo, PaymentType weixin, Map<String, String> resultMap);
}
