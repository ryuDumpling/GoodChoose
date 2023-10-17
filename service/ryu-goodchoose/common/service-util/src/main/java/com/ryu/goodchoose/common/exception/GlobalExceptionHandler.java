package com.ryu.goodchoose.common.exception;

import com.ryu.goodchoose.common.result.Result;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author ryuDumpling
 * 全局异常处理
 * @version 2023/10/3 10:14
 */
//AOP 面向切面编程
@ControllerAdvice
public class GlobalExceptionHandler {

    //统一异常处理
    @ExceptionHandler(Exception.class)
    @ResponseBody//返回json数据
    public Result error(Exception e){
        e.printStackTrace();
        return Result.fail(null);
    }

    //自定义异常处理
    @ExceptionHandler(GcException.class)
    @ResponseBody
    public Result error(GcException exception){
        return Result.build(null,exception.getCode(),exception.getMessage());
    }
}
