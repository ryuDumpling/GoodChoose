package com.ryu.goodchoose.acl.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ryu.goodchoose.acl.mapper.RoleMapper;
import com.ryu.goodchoose.acl.service.AdminRoleService;
import com.ryu.goodchoose.acl.service.RoleService;
import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.model.acl.AdminRole;
import com.ryu.goodchoose.model.acl.Role;
import com.ryu.goodchoose.vo.acl.RoleQueryVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author ryuDumpling
 * @version 2023/10/3 13:43
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {
    @Autowired
    private AdminRoleService adminRoleService;
    @Override
    public IPage<Role> selectRolePage(Page<Role> pageParam, RoleQueryVo roleQueryVo) {
        //获取条件值
        String roleName = roleQueryVo.getRoleName();
        //创建mp条件对象
        LambdaQueryWrapper<Role> wrapper = new LambdaQueryWrapper<>();
        //判断值是否为空
        if(!StringUtils.isEmpty(roleName)){
            wrapper.like(Role::getRoleName,roleName);
        }
        //实现条件查询
        IPage<Role> pageModel = baseMapper.selectPage(pageParam, wrapper);
        //返回对象
        return pageModel;
    }

    //获取所有角色以及用户拥有的角色
    @Override
    public Map<String, Object> getRoleByAdminId(Long adminId) {
        //查询所有角色
        List<Role> allRoleList = baseMapper.selectList(null);

        //查询用户分配的角色
        //获取用户id对应的角色list
        LambdaQueryWrapper<AdminRole> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AdminRole::getAdminId,adminId);
        List<AdminRole> adminRoleList = adminRoleService.list(wrapper);
        //从adminRole对象中提取role id 并储存到一个list中
        List<Long> roleIdList = adminRoleList.stream().map((item -> item.getRoleId())).collect(Collectors.toList());
        //判断所有角色里是否包含已分配角色id，封装到新的list中
        List<Role> assignRolesList = new ArrayList<>();
        for(Role role:allRoleList){
            if(roleIdList.contains(role.getId())){
                assignRolesList.add(role);
            }
        }
        Map<String,Object> result = new HashMap<>();
        //所有角色
        result.put("allRolesList",allRoleList);
        //用户已经分配的角色
        result.put("assignRoles",assignRolesList);
        return result;
    }

    //为用户分配角色
    @Override
    public void saveAdminRole(Long adminId, Long[] roleIds) {
        //删除用户已经分配的角色
        //根据用户id删除adminRole表中的数据
        LambdaQueryWrapper<AdminRole> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AdminRole::getAdminId,adminId);
        adminRoleService.remove(wrapper);
        //重新分配
        //遍历多个角色id，得到每个角色id，然后在表中创建数据
        List<AdminRole> list = new ArrayList<>();
        for (Long roleId:roleIds){
            AdminRole adminRole = new AdminRole();
            adminRole.setAdminId(adminId);
            adminRole.setRoleId(roleId);
            list.add(adminRole);
        }
        //批量储存
        adminRoleService.saveBatch(list);
    }
}
