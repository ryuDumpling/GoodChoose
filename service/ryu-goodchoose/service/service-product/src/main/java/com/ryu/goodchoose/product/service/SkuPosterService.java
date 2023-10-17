package com.ryu.goodchoose.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ryu.goodchoose.model.product.SkuPoster;

import java.util.List;

/**
 * <p>
 * 商品海报表 服务类
 * </p>
 *
 * @author ryu
 * @since 2023-10-04
 */
public interface SkuPosterService extends IService<SkuPoster> {

    List<SkuPoster> getPostersBySkuId(Long id);
}
