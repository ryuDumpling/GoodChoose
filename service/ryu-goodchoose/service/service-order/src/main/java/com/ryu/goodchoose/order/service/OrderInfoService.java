package com.ryu.goodchoose.order.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ryu.goodchoose.model.order.OrderInfo;
import com.ryu.goodchoose.vo.order.OrderConfirmVo;
import com.ryu.goodchoose.vo.order.OrderSubmitVo;
import com.ryu.goodchoose.vo.order.OrderUserQueryVo;

/**
 * <p>
 * 订单 服务类
 * </p>
 *
 * @author ryu
 * @since 2023-10-15
 */
public interface OrderInfoService extends IService<OrderInfo> {


    OrderConfirmVo confirmOrder();

    Long submitOrder(OrderSubmitVo orderParamVo);

    OrderInfo getOrderInfoById(Long orderId);

    OrderInfo getOrderInfo(String orderNo);

    IPage<OrderInfo> findUserOrderPage(Page<OrderInfo> pageParam, OrderUserQueryVo orderUserQueryVo);
}
