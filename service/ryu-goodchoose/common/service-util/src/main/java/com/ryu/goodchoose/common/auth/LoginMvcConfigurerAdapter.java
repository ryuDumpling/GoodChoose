package com.ryu.goodchoose.common.auth;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

import javax.annotation.Resource;

/**
 * @author ryuDumpling
 * 自定义配置类
 * @version 2023/10/13 9:08
 */
@Configuration
public class LoginMvcConfigurerAdapter extends WebMvcConfigurationSupport {
    @Resource
    private RedisTemplate redisTemplate;
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(
                new UserLoginInterceptor(redisTemplate))
                .addPathPatterns("/api/**")//需要拦截的路径
                .excludePathPatterns("/api/user/weixin/wxLogin/*");//不需要拦截的路径
        super.addInterceptors(registry);
    }
}
