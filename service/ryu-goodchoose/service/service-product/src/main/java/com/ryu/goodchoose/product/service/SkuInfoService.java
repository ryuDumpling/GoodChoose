package com.ryu.goodchoose.product.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ryu.goodchoose.model.product.SkuInfo;
import com.ryu.goodchoose.vo.product.SkuInfoQueryVo;
import com.ryu.goodchoose.vo.product.SkuInfoVo;
import com.ryu.goodchoose.vo.product.SkuStockLockVo;

import java.util.List;

/**
 * <p>
 * sku信息 服务类
 * </p>
 *
 * @author ryu
 * @since 2023-10-04
 */
public interface SkuInfoService extends IService<SkuInfo> {

    IPage<SkuInfo> selectPageSkuInfo(Page<SkuInfo> pageParam, SkuInfoQueryVo skuInfoQueryVo);

    void saveSkuInfo(SkuInfoVo skuInfoVo);

    SkuInfoVo getSkuInfoById(Long id);

    void updateSkuInfo(SkuInfoVo skuInfoVo);

    //删除一个skuInfo及其所有信息
    void removeSkuInfoById(Long id);

    //根据id列表删除skuInfo所有信息
    void removeAllByIds(List<Long> idList);

    void check(Long skuId, Integer status);

    void publish(Long skuId, Integer status);

    void isNewPerson(Long skuId, Integer status);

    List<SkuInfo> findSkuInfoList(List<Long> skuIdList);

    List<SkuInfo> selectList(String keyword);

    List<SkuInfo> findNewPersonSkuInfoList();

    SkuInfoVo getSkuInfoVoById(Long skuId);

    Boolean checkAndLock(List<SkuStockLockVo> skuStockLockVoList, String orderNo);
}
