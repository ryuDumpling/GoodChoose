package com.ryu.goodchoose.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ryu.goodchoose.model.product.Attr;

import java.util.List;

/**
 * <p>
 * 商品属性 服务类
 * </p>
 *
 * @author ryu
 * @since 2023-10-04
 */
public interface AttrService extends IService<Attr> {

    List<Attr> getAttrListByGroupId(Long groupId);
}
