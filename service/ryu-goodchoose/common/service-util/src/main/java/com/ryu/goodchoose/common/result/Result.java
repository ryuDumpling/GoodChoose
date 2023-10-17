package com.ryu.goodchoose.common.result;

import lombok.Data;

/**
 * @author ryuDumpling
 * 统一返回结果类
 * @version 2023/10/3 10:02
 */

@Data
public class Result<T> {

    //状态码
    private Integer code;

    //信息
    private String message;

    //数据
    private T data;

    //构造私有化
    private  Result(){
    }

    //设置数据
    public static<T> Result<T> build(T data,ResultCodeEnum resultCodeEnum){
        //创建Result对象，设置值，返回对象
        Result<T> result = new Result<>();
        //判断是否需要返回值
        if(data!=null){
            result.setData(data);
        }
        result.setCode(resultCodeEnum.getCode());
        result.setMessage(resultCodeEnum.getMessage());
        return result;
    }

    //自定义返回值
    public static<T> Result<T> build(T data,Integer code,String message){
        //创建Result对象，设置值，返回对象
        Result<T> result = new Result<>();
        //判断是否需要返回值
        if(data!=null){
            result.setData(data);
        }
        result.setCode(code);
        result.setMessage(message);
        return result;
    }

    //成功的方法
    public static<T> Result<T> ok(T data){
        Result<T> result = build(data,ResultCodeEnum.SUCCESS);
        return result;
    }

    //失败的方法
    public static<T> Result<T> fail(T data){
        Result<T> result = build(data,ResultCodeEnum.FAIL);
        return result;
    }
}
