package com.ryu.goodchoose.home.controller;

import com.ryu.goodchoose.client.user.UserFeignClient;
import com.ryu.goodchoose.common.auth.AuthContextHolder;
import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.home.service.HomeService;
import com.ryu.goodchoose.vo.search.SkuEsQueryVo;
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
 * @version 2023/10/13 10:24
 */
@Api(tags = "首页接口")
@RestController
@RequestMapping("api/home")
public class HomeApiController {
    @Autowired
    private HomeService homeService;

    @ApiOperation("首页数据显示接口")
    @GetMapping("/index")
    public Result index(HttpServletRequest request){
        Long userId = AuthContextHolder.getUserId();
        Map<String, Object> map = homeService.homeData(userId);
        return Result.ok(map);
    }

}
