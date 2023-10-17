package com.ryu.goodchoose.cart.receiver;

import com.rabbitmq.client.Channel;
import com.ryu.goodchoose.cart.service.CartInfoService;
import com.ryu.goodchoose.mq.constant.MqConst;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.Exchange;
import org.springframework.amqp.rabbit.annotation.Queue;
import org.springframework.amqp.rabbit.annotation.QueueBinding;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * @author ryuDumpling
 * @version 2023/10/16 10:27
 */
@Component
public class CartReceiver {

    @Autowired
    private CartInfoService cartInfoService;

    /**
     * 删除购物车选项
     * @throws IOException
     */
    @RabbitListener(bindings = @QueueBinding(
            value = @Queue(value = MqConst.QUEUE_DELETE_CART, durable = "true"),
            exchange = @Exchange(value = MqConst.EXCHANGE_ORDER_DIRECT),
            key = {MqConst.ROUTING_DELETE_CART}
    ))
    public void deleteCart(Long userId, Message message, Channel channel) throws IOException {
        if (null != userId){
            // 获取用户id和skuIdList
            cartInfoService.deleteCartCheck(userId);
        }
        channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);//手动确认
    }
}