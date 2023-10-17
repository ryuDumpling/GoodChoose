package com.ryu.goodchoose.home.controller;

import com.ryu.goodchoose.common.auth.AuthContextHolder;
import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.home.service.ItemService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * @author ryuDumpling
 * @version 2023/10/13 19:07
 */
@Api(tags = "商品详情")
@RestController
@RequestMapping("/api/home")
public class ItemApiController {

    @Autowired
    private ItemService itemService;

    @ApiOperation(value = "获取sku详细信息")
    @GetMapping("/item/{id}")
    public Result index(@PathVariable Long id, HttpServletRequest request) {
        Long userId = AuthContextHolder.getUserId();
        Map<String, Object> result = itemService.item(id, userId);
        return Result.ok(result);
    }
}
