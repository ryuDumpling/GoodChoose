package com.ryu.goodchoose.cart.client;

import com.ryu.goodchoose.model.order.CartInfo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@FeignClient("service-cart")
public interface CartFeignClient {
    //获取用户选中的购物车项
    @GetMapping("/api/cart/inner/gerCartCheckList/{userId}")
    public List<CartInfo> gerCartCheckList(@PathVariable("userId") Long userId);
}
