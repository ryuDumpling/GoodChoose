package com.ryu.goodchoose.acl.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ryu.goodchoose.model.acl.AdminRole;
import com.ryu.goodchoose.model.acl.RolePermission;
import org.springframework.stereotype.Repository;

@Repository
public interface RolePermissionMapper extends BaseMapper<RolePermission> {
}
