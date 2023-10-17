package com.ryu.goodchoose.user.controller;

import com.alibaba.fastjson.JSONObject;
import com.ryu.goodchoose.common.auth.AuthContextHolder;
import com.ryu.goodchoose.common.config.RedisConfig;
import com.ryu.goodchoose.common.constant.RedisConst;
import com.ryu.goodchoose.common.exception.GcException;
import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.common.result.ResultCodeEnum;
import com.ryu.goodchoose.common.util.JwtHelper;
import com.ryu.goodchoose.enums.UserType;
import com.ryu.goodchoose.model.user.Leader;
import com.ryu.goodchoose.model.user.LeaderAccount;
import com.ryu.goodchoose.model.user.User;
import com.ryu.goodchoose.user.service.UserService;
import com.ryu.goodchoose.user.utils.ConstantPropertiesUtil;
import com.ryu.goodchoose.user.utils.HttpClientUtils;
import com.ryu.goodchoose.vo.user.LeaderAddressVo;
import com.ryu.goodchoose.vo.user.UserLoginVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * @author ryuDumpling
 * 微信服务
 * @version 2023/10/12 14:09
 */
@Api(tags = "微信服务")
@RestController
@RequestMapping("/api/user/weixin")
public class WeixinApiController {

    @Autowired
    private UserService userService;

    @Autowired
    private RedisTemplate redisTemplate;

    //用户微信授权登录
    @ApiOperation(value = "微信登录获取openid(小程序)")
    @GetMapping("/wxLogin/{code}")
    public Result loginWx(@PathVariable String code){
        //1 得到微信返回的code临时票据
        //2 code+appId+小程序密钥 请求微信接口服务
        String wxOpenAppId = ConstantPropertiesUtil.WX_OPEN_APP_ID;
        String wxOpenAppSecret = ConstantPropertiesUtil.WX_OPEN_APP_SECRET;
        //get请求 拼接请求地址+参数
        StringBuffer url = new StringBuffer()
                .append("https://api.weixin.qq.com/sns/jscode2session")
                .append("?appid=%s")
                .append("&secret=%s")
                .append("&js_code=%s")
                .append("&grant_type=authorization_code");
        String tokenUrl = String.format(url.toString(),
                                            wxOpenAppId,
                                            wxOpenAppSecret,
                                            code);
        ///使用HttpClient工具请求
        String result = null;
        try{
            result = HttpClientUtils.get(tokenUrl);
        } catch (Exception e){
            throw new GcException(ResultCodeEnum.FETCH_ACCESSTOKEN_FAILD);
        }

        //3 请求微信接口，返回两个值 session_key & openId
        ///openId为微信的唯一表示
        JSONObject jsonObject = JSONObject.parseObject(result);
        String session_key = jsonObject.getString("session_key");
        String openid = jsonObject.getString("openid");

        //4 判断用户是否为首次登录-将用户数据加入数据库中-user表 -根据userId查询
        User user = userService.getUserByOpenId(openid);
        if (user == null){
            //说明用户没有登录过，加入数据库
            user = new User();
            user.setOpenId(openid);
            user.setNickName(openid);//昵称默认为openId
            user.setPhotoUrl("");
            user.setUserType(UserType.USER);
            user.setIsNew(0);
            userService.save(user);
        }

        //5 根据userId查询用户提货点和团长信息-delivery表
        ///提货点：在哪提货
        ///团长：社区团购的负责人-leader表
        LeaderAddressVo leaderAddressVo=userService.getLeaderAndAddressByUserId(user.getId());

        //6 使用JWT工具根据userId和username生成token
        String token = JwtHelper.createToken(user.getId(), user.getNickName());

        //7 获取当前登录用户信息，放入redis中，设置有效时间
        UserLoginVo userLoginVo = userService.getUserLoginVo(user.getId());
        redisTemplate.opsForValue().set(RedisConst.USER_LOGIN_KEY_PREFIX+user.getId(),
                userLoginVo,
                RedisConst.USERKEY_TIMEOUT,
                TimeUnit.DAYS);
        //8 将需要的数据封装入map中返回
        Map<String,Object> map = new HashMap<>();
        map.put("user",user);
        map.put("token",token);
        map.put("leaderAddressVo",leaderAddressVo);

        return Result.ok(map);
    }

    @PostMapping("/auth/updateUser")
    @ApiOperation(value = "更新用户昵称与头像")
    public Result updateUser(@RequestBody User user) {
        //获取当前登录用户
        Long userId = AuthContextHolder.getUserId();
        User user1 = userService.getById(userId);
        //把昵称更新为微信用户
        user1.setNickName(user.getNickName().replaceAll("[ue000-uefff]", "*"));
        user1.setPhotoUrl(user.getPhotoUrl());
        userService.updateById(user1);
        return Result.ok(null);
    }



}
