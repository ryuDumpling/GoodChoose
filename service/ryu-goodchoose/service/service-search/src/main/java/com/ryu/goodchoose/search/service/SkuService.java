package com.ryu.goodchoose.search.service;

import com.ryu.goodchoose.model.search.SkuEs;
import com.ryu.goodchoose.vo.search.SkuEsQueryVo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface SkuService {
    //上架
    void upperSku(Long skuId);

    //下架
    void lowerSku(Long skuId);

    List<SkuEs> findHotSkuList();

    Page<SkuEs> search(Pageable pageable, SkuEsQueryVo skuEsQueryVo);

    void incrHotScore(Long skuId);
}
