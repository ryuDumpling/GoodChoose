package com.ryu.goodchoose.acl.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ryu.goodchoose.acl.service.AdminRoleService;
import com.ryu.goodchoose.acl.service.AdminService;
import com.ryu.goodchoose.acl.service.RoleService;
import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.common.util.MD5;
import com.ryu.goodchoose.model.acl.Admin;
import com.ryu.goodchoose.vo.acl.AdminQueryVo;
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
@Api(tags = "用户接口")
@RestController
@RequestMapping("/admin/acl/user")
//@CrossOrigin //跨域请求
public class AdminController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private AdminRoleService adminRoleService;

    @Autowired
    private RoleService roleService;

    //角色列表（分页查询
    @ApiOperation("用户条件分页查询")
    @GetMapping("/{current}/{limit}")
    public Result pageList(@PathVariable("current") Long current, @PathVariable("limit") Long limit, AdminQueryVo adminQueryVo){
        //current:当前页 limit：每页显示数据量
        Page<Admin> pageParam = new Page<>(current,limit);
        //调用service方法实现分页查询，返回分页对象
        IPage<Admin> pageModel= adminService.selectAdminPage(pageParam,adminQueryVo);
        return Result.ok(pageModel);
    }

    //根据id查询角色
    @ApiOperation("根据id查询用户")
    @GetMapping("/get/{id}")
    public Result pageList(@PathVariable("id") Long id){
       Admin admin = adminService.getById(id);
        return Result.ok(admin);
    }
    //添加
    @ApiOperation("添加用户")
    @PostMapping("/save")
    public Result save(@RequestBody Admin admin){
        //给密码加密
        String password = admin.getPassword();
        String passwordMD5 = MD5.encrypt(password);
        admin.setPassword(passwordMD5);
        boolean succ = adminService.save(admin);
        if(succ){
            return Result.ok(null);
        }
        return Result.fail(null);
    }
    //修改
    @ApiOperation("修改用户")
    @PutMapping("/update")
    public Result update(@RequestBody Admin admin){
        admin.setUpdateTime(null);
        boolean succ = adminService.updateById(admin);
        if(succ){
            return Result.ok(null);
        }
        return Result.fail(null);
    }
    //根据id删除
    @ApiOperation("根据id删除用户")
    @DeleteMapping("/remove/{id}")
    public Result remove(@PathVariable("id") Long id){
        boolean succ = adminService.removeById(id);
        if(succ){
            return Result.ok(null);
        }
        return Result.fail(null);
    }
    //批量删除
    @ApiOperation("批量删除用户")
    @DeleteMapping("/batchRemove")
    public Result batchRemove(@RequestBody List<Long> idList){
        boolean succ = adminService.removeByIds(idList);
        if(succ){
            return Result.ok(null);
        }
        return Result.fail(null);
    }

    //获取所有角色,根据用户id查询用户分配角色列表
    @ApiOperation("获取用户角色")
    @GetMapping("/toAssign/{adminId}")
    public Result toAssign(@PathVariable("adminId") Long adminId){
        Map<String,Object> map = roleService.getRoleByAdminId(adminId);
        return Result.ok(map);
    }

    //为用户进行最后的分配
    @ApiOperation("为用户进行角色分配")
    @PostMapping("/doAssign")
    public Result doAssign(@RequestParam Long adminId,@RequestParam Long[] roleId){
        roleService.saveAdminRole(adminId,roleId);
        return Result.ok(null);
    }
}
