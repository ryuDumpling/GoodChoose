package com.ryu.goodchoose.acl.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ryu.goodchoose.acl.mapper.PermissionMapper;
import com.ryu.goodchoose.acl.service.PermissionService;
import com.ryu.goodchoose.acl.service.RolePermissionService;
import com.ryu.goodchoose.acl.util.PermissionHelper;
import com.ryu.goodchoose.model.acl.AdminRole;
import com.ryu.goodchoose.model.acl.Permission;
import com.ryu.goodchoose.model.acl.Role;
import com.ryu.goodchoose.model.acl.RolePermission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author ryuDumpling
 * @version 2023/10/3 16:43
 */
@Service
public class PermissionServiceImpl extends ServiceImpl<PermissionMapper, Permission> implements PermissionService {
    @Autowired
    private RolePermissionService rolePermissionService;
    @Override
    public List<Permission> queryAllPermission() {
        //查询所有菜单
        List<Permission> allPermissionList = baseMapper.selectList(null);
        //将菜单分级存储
        List<Permission> result = PermissionHelper.buildPermission(allPermissionList);
        return result;
    }

    @Override
    public void removeChileById(Long id) {
        List<Long> idList = new ArrayList<>();
        this.getAllPermissionId(id,idList);
        //把当前菜单id加入idList中
        idList.add(id);
        baseMapper.deleteBatchIds(idList);
    }

    //为角色分配权限
    @Override
    public void saveRolePermission(Long roleId, Long[] permissionId) {
        //删除角色已经分配的权限
        LambdaQueryWrapper<RolePermission> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RolePermission::getRoleId,roleId);
        rolePermissionService.remove(wrapper);
        //重新分配
        List<RolePermission> list = new ArrayList<>();
        for (Long pid:permissionId){
            RolePermission rolePermission = new RolePermission();
            rolePermission.setRoleId(roleId);
            rolePermission.setPermissionId(pid);
            list.add(rolePermission);
        }
        //批量存储
        rolePermissionService.saveBatch(list);
    }

    //获取所有权限以及角色拥有的权限
    @Override
    public Map<String, Object> getPermissionByRoleId(Long roleId) {
        //查询所有权限
        List<Permission> allPermissionList = baseMapper.selectList(null);
        //查询角色分配的权限
        //获取权限id对应的权限list
        LambdaQueryWrapper<RolePermission> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RolePermission::getRoleId,roleId);
        List<RolePermission> rolePermissionList = rolePermissionService.list(wrapper);
        //从RolePermission对象中提取permission id 并储存到一个list中
        List<Long> permissionIdList = rolePermissionList.stream().map((item -> item.getPermissionId())).collect(Collectors.toList());
        //判断所有权限里是否包含已分配权限id，将其select属性改为true
        for(Permission permission:allPermissionList){
            if(permissionIdList.contains(permission.getId())){
                permission.setSelect(true);
            }
        }
        //将重构的菜单分级存储
        List<Permission> resultPermissions = PermissionHelper.buildPermission(allPermissionList);
        Map<String,Object> result = new HashMap<>();
        //所有权限和被选中的权限
        result.put("allPermissions",resultPermissions);
        return result;
//        //查询所有菜单
//        List<Permission> allPermissionList = baseMapper.selectList(null);
//        //将菜单分级存储
//        List<Permission> resultList = PermissionHelper.buildPermission(allPermissionList);
//        Map<String,Object> result = new HashMap<>();
//        result.put("allPermissions",resultList);
//        return result;
    }

    //递归获得菜单和它的所有子菜单
    private void getAllPermissionId(Long id, List<Long> idList) {
        //获得所需删除菜单的所有子菜单 递归
        LambdaQueryWrapper<Permission> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Permission::getPid,id);
        List<Permission> childList = baseMapper.selectList(wrapper);
        childList.stream().forEach(item->{
            idList.add(item.getId());
            //递归调用
            this.getAllPermissionId(item.getId(),idList);
        });
    }
}
