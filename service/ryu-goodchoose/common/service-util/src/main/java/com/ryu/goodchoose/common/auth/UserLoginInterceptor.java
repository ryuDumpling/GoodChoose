package com.ryu.goodchoose.common.auth;

import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.ryu.goodchoose.common.constant.RedisConst;
import com.ryu.goodchoose.common.util.JwtHelper;
import com.ryu.goodchoose.vo.user.UserLoginVo;
import jdk.nashorn.api.scripting.ScriptUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author ryuDumpling
 * @version 2023/10/13 8:58
 */
public class UserLoginInterceptor implements HandlerInterceptor {
    private RedisTemplate redisTemplate;

    public UserLoginInterceptor(RedisTemplate redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {
        this.getUserLoginVo(request);
        return true;
    }

    private void getUserLoginVo(HttpServletRequest request) {
        //从请求头中获得token
        String token = request.getHeader("token");
        //token不为空
        if (!StringUtils.isEmpty(token)){
            //从token中获取userId
            Long userId = JwtHelper.getUserId(token);
            //根据userId获取redis中的数据
            UserLoginVo userLoginVo = (UserLoginVo) redisTemplate.opsForValue()
                    .get(RedisConst.USER_LOGIN_KEY_PREFIX + userId);
            //将数据放入ThreadLocal中
            if(userLoginVo != null){
                AuthContextHolder.setUserId(userLoginVo.getUserId());
                AuthContextHolder.setWareId(userLoginVo.getWareId());
                AuthContextHolder.setUserLoginVo(userLoginVo);
            }
        }
    }


}
