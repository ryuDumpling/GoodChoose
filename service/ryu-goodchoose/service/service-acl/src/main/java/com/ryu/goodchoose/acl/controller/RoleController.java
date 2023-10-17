package com.ryu.goodchoose.acl.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ryu.goodchoose.acl.service.PermissionService;
import com.ryu.goodchoose.acl.service.RoleService;
import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.model.acl.Permission;
import com.ryu.goodchoose.model.acl.Role;
import com.ryu.goodchoose.vo.acl.RoleQueryVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * @author ryuDumpling
 * @version 2023/10/3 13:38
 */
@Api(tags = "角色管理")
@RestController
@RequestMapping("/admin/acl/role")
//@CrossOrigin //跨域请求
public class RoleController {

    @Autowired
    private RoleService roleService;

    @Autowired
    private PermissionService permissionService;

    //角色列表（分页查询
    @ApiOperation("角色条件分页查询")
    @GetMapping("/{current}/{limit}")
    public Result pageList(@PathVariable("current") Long current, @PathVariable("limit") Long limit, RoleQueryVo roleQueryVo){
        //current:当前页 limit：每页显示数据量
        Page<Role> pageParam = new Page<>(current,limit);
        //调用service方法实现分页查询，返回分页对象
        IPage<Role> pageModel= roleService.selectRolePage(pageParam,roleQueryVo);
        return Result.ok(pageModel);
    }

    //根据id查询角色
    @ApiOperation("根据id查询角色")
    @GetMapping("/get/{id}")
    public Result pageList(@PathVariable("id") Long id){
       Role role = roleService.getById(id);
        return Result.ok(role);
    }
    //添加
    @ApiOperation("添加角色")
    @PostMapping("/save")
    public Result save(@RequestBody Role role){
        boolean succ = roleService.save(role);
        if(succ){
            return Result.ok(null);
        }
        return Result.fail(null);
    }
    //修改
    @ApiOperation("修改角色")
    @PutMapping("/update")
    public Result update(@RequestBody Role role){
        boolean succ = roleService.updateById(role);
        if(succ){
            return Result.ok(null);
        }
        return Result.fail(null);
    }
    //根据id删除
    @ApiOperation("根据id删除角色")
    @DeleteMapping("/remove/{id}")
    public Result remove(@PathVariable("id") Long id){
        boolean succ = roleService.removeById(id);
        if(succ){
            return Result.ok(null);
        }
        return Result.fail(null);
    }
    //批量删除
    @ApiOperation("批量删除角色")
    @DeleteMapping("/batchRemove")
    public Result batchRemove(@RequestBody List<Long> idList){
        boolean succ = roleService.removeByIds(idList);
        if(succ){
            return Result.ok(null);
        }
        return Result.fail(null);
    }

//    //获取所有菜单,根据角色id查询是否分配过菜单
//    @ApiOperation("获取角色的菜单&所有菜单")
//    @GetMapping("/toAssign/{roleId}")
//    public Result toAssign(@PathVariable Long roleId){
//        Map<String,Object> map = permissionService.getPermissionByRoleId(roleId);
//        return Result.ok(map);
//    }

}
