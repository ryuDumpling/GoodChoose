package com.ryu.goodchoose.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ryu.goodchoose.model.product.SkuInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * <p>
 * sku信息 Mapper 接口
 * </p>
 *
 * @author ryu
 * @since 2023-10-04
 */
@Repository
public interface SkuInfoMapper extends BaseMapper<SkuInfo> {

    //验证库存
    SkuInfo checkStock(@Param("skuId") Long skuId,@Param("skuNum") Integer skuNum);

    //锁库存
    Integer lockStock(@Param("skuId") Long skuId,@Param("skuNum") Integer skuNum);

    //解锁库存
    void unlockStock(@Param("skuId") Long skuId,@Param("skuNum") Integer skuNum);
}
