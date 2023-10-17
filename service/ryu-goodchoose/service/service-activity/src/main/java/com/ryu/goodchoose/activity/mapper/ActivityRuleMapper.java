package com.ryu.goodchoose.activity.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ryu.goodchoose.model.activity.ActivityRule;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * <p>
 * 优惠规则 Mapper 接口
 * </p>
 *
 * @author ryu
 * @since 2023-10-11
 */
@Repository
public interface ActivityRuleMapper extends BaseMapper<ActivityRule> {

}
