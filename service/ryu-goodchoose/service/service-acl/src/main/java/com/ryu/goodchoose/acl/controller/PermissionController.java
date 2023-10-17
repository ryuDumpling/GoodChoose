package com.ryu.goodchoose.acl.controller;

import com.ryu.goodchoose.acl.service.PermissionService;
import com.ryu.goodchoose.acl.service.RoleService;
import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.model.acl.Permission;
import com.ryu.goodchoose.model.acl.Role;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * @author ryuDumpling
 * @version 2023/10/3 16:40
 */
@Api(tags = "菜单管理")
@RestController
@RequestMapping("/admin/acl/permission")
//@CrossOrigin //跨域请求
public class PermissionController {
    @Autowired
    private PermissionService permissionService;

    @Autowired
    private RoleService roleService;

    //查询所有菜单接口，并分级显示
    @ApiOperation("查询所有菜单")
    @GetMapping("")
    public Result list(){
        List<Permission> list = permissionService.queryAllPermission();
        return Result.ok(list);
    }
    //新增菜单
    @ApiOperation("添加菜单")
    @PostMapping("/save")
    public Result save(@RequestBody Permission permission){
        boolean succ = permissionService.save(permission);
        if(succ){
            return Result.ok(null);
        }
        return Result.fail(null);
    }
    //修改菜单
    @ApiOperation("修改菜单")
    @PutMapping("/update")
    public Result update(@RequestBody Permission permission){
        boolean succ = permissionService.updateById(permission);
        if(succ){
            return Result.ok(null);
        }
        return Result.fail(null);
    }
    //删除菜单-递归删除
    @ApiOperation("递归删除菜单")
    @DeleteMapping("/remove/{id}")
    public Result remove(@PathVariable("id") Long id){
        permissionService.removeChileById(id);
        return Result.ok(null);
    }

    //获取所有菜单,根据角色id查询是否分配过菜单
    @ApiOperation("获取角色的菜单&所有菜单")
    @GetMapping("/toAssign/{roleId}")
    public Result toAssign(@PathVariable("roleId") Long roleId){
        Map<String,Object> map = permissionService.getPermissionByRoleId(roleId);
        return Result.ok(map);
    }

    //为角色进行最后的分配
    @ApiOperation("为角色进行菜单分配")
    @PostMapping("/doAssign")
    public Result doAssign(@RequestParam Long roleId,@RequestParam Long[] permissionId){
        permissionService.saveRolePermission(roleId,permissionId);
        return Result.ok(null);
    }
}
