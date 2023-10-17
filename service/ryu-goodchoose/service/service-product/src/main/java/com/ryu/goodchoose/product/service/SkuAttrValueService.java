package com.ryu.goodchoose.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ryu.goodchoose.model.product.SkuAttrValue;

import java.util.List;

/**
 * <p>
 * spu属性值 服务类
 * </p>
 *
 * @author ryu
 * @since 2023-10-04
 */
public interface SkuAttrValueService extends IService<SkuAttrValue> {

    List<SkuAttrValue> getSkuValueBySkuId(Long id);
}
