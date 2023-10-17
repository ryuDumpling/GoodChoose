package com.ryu.goodchoose.acl.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ryu.goodchoose.acl.mapper.RolePermissionMapper;
import com.ryu.goodchoose.acl.service.RolePermissionService;
import com.ryu.goodchoose.model.acl.RolePermission;
import org.springframework.stereotype.Service;

/**
 * @author ryuDumpling
 * @version 2023/10/3 13:43
 */
@Service
public class RolePermissionServiceImpl extends ServiceImpl<RolePermissionMapper, RolePermission> implements RolePermissionService {

}
