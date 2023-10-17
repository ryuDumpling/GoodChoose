package com.ryu.goodchoose.cart.controller;

import com.ryu.goodchoose.activity.client.ActivityFeignClient;
import com.ryu.goodchoose.cart.service.CartInfoService;
import com.ryu.goodchoose.client.product.ProductFeignClient;
import com.ryu.goodchoose.client.search.SkuFeignClient;
import com.ryu.goodchoose.client.user.UserFeignClient;
import com.ryu.goodchoose.common.auth.AuthContextHolder;
import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.model.order.CartInfo;
import com.ryu.goodchoose.vo.order.OrderConfirmVo;
import io.swagger.annotations.ApiOperation;
import org.apache.http.HttpServerConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author ryuDumpling
 * @version 2023/10/14 7:56
 */
@RestController
@RequestMapping("/api/cart")
public class CartApiController {
    @Autowired
    private CartInfoService cartInfoService;

    @Autowired
    private ActivityFeignClient activityFeignClient;

    @Autowired
    private UserFeignClient userFeignClient;

    @Autowired
    private ProductFeignClient productFeignClient;

    @Autowired
    private SkuFeignClient skuFeignClient;

    //商品加入购物车
    @GetMapping("/addToCart/{skuId}/{skuNum}")
    public Result addToCart(@PathVariable("skuId") Long skuId,
                            @PathVariable("skuNum") Integer skuNum){
        //当前用户id
        Long userId = AuthContextHolder.getUserId();
        cartInfoService.addToCart(userId,skuId,skuNum);
        return Result.ok(null);
    }

    //购物车列表
    @GetMapping("/cartList")
    public Result cartList(){
        //当前用户id
        Long userId = AuthContextHolder.getUserId();
        List<CartInfo> cartInfoList = cartInfoService.cartList(userId);
        return Result.ok(cartInfoList);
    }

    //切换购物车中商品的选中状态

    //删除购物车商品
    @DeleteMapping("/deleteCart/{skuId}")
    public Result deleteCart(@PathVariable("skuId") Long skuId){
        //当前用户id
        Long userId = AuthContextHolder.getUserId();
        cartInfoService.deleteCart(skuId,userId);
        return Result.ok(null);
    }

    //清空购物车
    @DeleteMapping("/deleteAllCart")
    public Result deleteAllCart(){
        //当前用户id
        Long userId = AuthContextHolder.getUserId();
        cartInfoService.deleteAllCart(userId);
        return Result.ok(null);
    }

    //批量删除购物车商品
    @PostMapping("/batchDeleteCart")
    public Result batchDeleteCart(@RequestBody List<Long> skuIdList){
        //当前用户id
        Long userId = AuthContextHolder.getUserId();
        cartInfoService.batchDeleteCart(skuIdList,userId);
        return Result.ok(null);
    }

    //带活动的购物车列表
    @GetMapping("/activityCartList")
    public Result activityCartList(HttpServletRequest request){
        //当前用户id
        Long userId = AuthContextHolder.getUserId();
        List<CartInfo> cartInfoList = cartInfoService.cartList(userId);

        OrderConfirmVo orderConfirmVo = activityFeignClient.findCartActivityAndCoupon(cartInfoList, userId);
        return Result.ok(orderConfirmVo);
    }

    //根据skuId选中
    @GetMapping("/checkCart/{skuId}/{isChecked}")
    public Result checkCart(@PathVariable Long skuId,@PathVariable Integer isChecked){
        //当前用户id
        Long userId = AuthContextHolder.getUserId();
        //调用方法
        cartInfoService.checkCart(userId,skuId,isChecked);
        return Result.ok(null);
    }
    //全选
    @GetMapping("/checkAllCart/{isChecked}")
    public Result checkAllCart(@PathVariable Integer isChecked){
        //当前用户id
        Long userId = AuthContextHolder.getUserId();
        //调用方法
        cartInfoService.checkAllCart(userId,isChecked);
        return Result.ok(null);
    }
    //批量选中
    @ApiOperation(value="批量选择购物车")
    @PostMapping("batchCheckCart/{isChecked}")
    public Result batchCheckCart(@RequestBody List<Long> skuIdList, @PathVariable(value = "isChecked") Integer isChecked, HttpServletRequest request){
        // 如何获取userId
        Long userId = AuthContextHolder.getUserId();
        cartInfoService.batchCheckCart(skuIdList, userId, isChecked);
        return Result.ok(null);
    }

    //获取用户选中的购物车项
    @GetMapping("/inner/gerCartCheckList/{userId}")
    public List<CartInfo> gerCartCheckList(@PathVariable("userId") Long userId){
        return cartInfoService.getCartCheckedList(userId);
    }

}
