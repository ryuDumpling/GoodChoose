package com.ryu.goodchoose.activity.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ryu.goodchoose.model.activity.ActivityInfo;
import com.ryu.goodchoose.model.activity.ActivityRule;
import com.ryu.goodchoose.model.activity.ActivitySku;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>
 * 活动表 Mapper 接口
 * </p>
 *
 * @author ryu
 * @since 2023-10-11
 */
@Repository
public interface ActivityInfoMapper extends BaseMapper<ActivityInfo> {

    List<Long> selectSkuIdListExist(@Param("skuIdList") List<Long> skuIdList);

    List<ActivityRule> findActivityRule(@Param("skuId")Long skuId);

    List<ActivitySku> selectCartActivity(@Param("skuIdList") List<Long> skuIdList);
}
