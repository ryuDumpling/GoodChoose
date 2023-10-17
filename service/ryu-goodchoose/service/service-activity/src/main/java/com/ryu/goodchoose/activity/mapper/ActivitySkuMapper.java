package com.ryu.goodchoose.activity.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ryu.goodchoose.model.activity.ActivitySku;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * <p>
 * 活动参与商品 Mapper 接口
 * </p>
 *
 * @author ryu
 * @since 2023-10-11
 */
@Repository
public interface ActivitySkuMapper extends BaseMapper<ActivitySku> {

}
