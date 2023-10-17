package com.ryu.goodchoose.search.repository;

import com.ryu.goodchoose.model.search.SkuEs;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import java.util.List;

public interface SkuRepository extends ElasticsearchRepository<SkuEs, Long> {
    Page<SkuEs> findByOrderByHotScoreDesc(Pageable pageable);

    Page<SkuEs> findByWareIdAndCategoryId(Long wareId, Long categoryId, Pageable pageable);

    Page<SkuEs> findByWareIdAndKeyword(Long wareId, String keyword, Pageable pageable);

    Page<SkuEs> findByCategoryIdAndWareId(Long categoryId, Long wareId, Pageable pageable);

    Page<SkuEs> findByKeywordAndWareId(String keyword, Long wareId, Pageable pageable);
}
