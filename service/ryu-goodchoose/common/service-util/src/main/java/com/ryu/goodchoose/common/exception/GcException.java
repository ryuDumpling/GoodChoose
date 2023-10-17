package com.ryu.goodchoose.common.exception;

import com.ryu.goodchoose.common.result.ResultCodeEnum;
import lombok.Data;

/**
 * @author ryuDumpling
 * 自定义异常处理
 * @version 2023/10/3 10:19
 */

@Data
public class GcException extends RuntimeException{
    //异常状态码
    private Integer code;

    /**
     * 通过状态码和错误消息创建异常对象
     * @param message
     * @param code
     */
    public GcException(String message, Integer code) {
        super(message);
        this.code = code;
    }

    /**
     * 接收枚举类型对象
     * @param resultCodeEnum
     */
    public GcException(ResultCodeEnum resultCodeEnum) {
        super(resultCodeEnum.getMessage());
        this.code = resultCodeEnum.getCode();
    }

    @Override
    public String toString() {
        return "GuliException{" +
                "code=" + code +
                ", message=" + this.getMessage() +
                '}';
    }
}
