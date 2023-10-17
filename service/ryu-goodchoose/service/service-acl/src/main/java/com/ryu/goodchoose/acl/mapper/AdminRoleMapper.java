package com.ryu.goodchoose.acl.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ryu.goodchoose.model.acl.Admin;
import com.ryu.goodchoose.model.acl.AdminRole;
import org.springframework.stereotype.Repository;

@Repository
public interface AdminRoleMapper extends BaseMapper<AdminRole> {
}
