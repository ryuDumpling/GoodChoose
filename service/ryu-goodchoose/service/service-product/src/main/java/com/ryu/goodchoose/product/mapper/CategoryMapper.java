package com.ryu.goodchoose.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ryu.goodchoose.model.product.Category;
import org.springframework.stereotype.Repository;

/**
 * <p>
 * 商品三级分类 Mapper 接口
 * </p>
 *
 * @author ryu
 * @since 2023-10-04
 */
@Repository
public interface CategoryMapper extends BaseMapper<Category> {

}
