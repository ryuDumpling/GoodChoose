package com.ryu.goodchoose.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ryu.goodchoose.model.product.SkuImage;

import java.util.List;

/**
 * <p>
 * 商品图片 服务类
 * </p>
 *
 * @author ryu
 * @since 2023-10-04
 */
public interface SkuImageService extends IService<SkuImage> {

    List<SkuImage> getImageListBySkuId(Long id);
}
