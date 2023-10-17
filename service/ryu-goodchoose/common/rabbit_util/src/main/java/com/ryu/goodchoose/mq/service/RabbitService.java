package com.ryu.goodchoose.mq.service;

import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author ryuDumpling
 * @version 2023/10/10 0:12
 */

@Service
public class RabbitService {

    @Autowired
    private RabbitTemplate rabbitTemplate;

    //发送消息
    //交换机exchange,路由Key routingKey, 发送的消息 message
    public boolean sendMessage(String exchange,String routingKey, Object message){
        rabbitTemplate.convertAndSend(exchange,routingKey,message);
        return true;
    }
}
