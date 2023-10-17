package com.ryu.goodchoose.acl.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ryu.goodchoose.model.acl.Permission;

import java.util.List;
import java.util.Map;

public interface PermissionService extends IService<Permission> {
    List<Permission> queryAllPermission();

    void removeChileById(Long id);


    void saveRolePermission(Long roleId, Long[] permissionId);

    Map<String, Object> getPermissionByRoleId(Long roleId);
}
