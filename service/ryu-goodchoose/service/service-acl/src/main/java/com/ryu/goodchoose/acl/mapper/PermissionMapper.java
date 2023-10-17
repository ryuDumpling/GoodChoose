package com.ryu.goodchoose.acl.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ryu.goodchoose.model.acl.Permission;
import com.ryu.goodchoose.model.acl.Role;
import org.springframework.stereotype.Repository;

@Repository
public interface PermissionMapper extends BaseMapper<Permission> {
}
