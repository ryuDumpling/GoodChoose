package com.ryu.goodchoose.payment.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ryu.goodchoose.model.order.PaymentInfo;
import org.springframework.stereotype.Repository;

@Repository
public interface PaymentMapper extends BaseMapper<PaymentInfo> {
}
