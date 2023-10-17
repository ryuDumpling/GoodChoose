package com.ryu.goodchoose.order.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ryu.goodchoose.model.order.OrderInfo;
import com.ryu.goodchoose.model.order.OrderItem;
import com.ryu.goodchoose.order.mapper.OrderInfoMapper;
import com.ryu.goodchoose.order.mapper.OrderItemMapper;
import com.ryu.goodchoose.order.service.OrderItemService;
import org.springframework.stereotype.Service;

/**
 * @author ryuDumpling
 * @version 2023/10/16 9:10
 */
@Service
public class OrderItemServiceImpl extends ServiceImpl<OrderItemMapper, OrderItem> implements OrderItemService {
}
