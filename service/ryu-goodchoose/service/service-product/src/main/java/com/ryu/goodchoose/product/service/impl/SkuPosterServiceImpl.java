package com.ryu.goodchoose.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.ryu.goodchoose.model.product.SkuImage;
import com.ryu.goodchoose.model.product.SkuPoster;
import com.ryu.goodchoose.product.mapper.SkuPosterMapper;
import com.ryu.goodchoose.product.service.SkuPosterService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 商品海报表 服务实现类
 * </p>
 *
 * @author ryu
 * @since 2023-10-04
 */
@Service
public class SkuPosterServiceImpl extends ServiceImpl<SkuPosterMapper, SkuPoster> implements SkuPosterService {

    @Override
    public List<SkuPoster> getPostersBySkuId(Long id) {
        LambdaQueryWrapper<SkuPoster> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SkuPoster::getSkuId,id);
        List<SkuPoster> skuPosters = baseMapper.selectList(wrapper);
        return skuPosters;
    }
}
