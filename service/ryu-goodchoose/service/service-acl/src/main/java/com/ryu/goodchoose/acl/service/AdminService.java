package com.ryu.goodchoose.acl.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ryu.goodchoose.model.acl.Admin;
import com.ryu.goodchoose.model.acl.Role;
import com.ryu.goodchoose.vo.acl.AdminQueryVo;
import com.ryu.goodchoose.vo.acl.RoleQueryVo;

public interface AdminService extends IService<Admin> {
    IPage<Admin> selectAdminPage(Page<Admin> pageParam, AdminQueryVo adminQueryVo);
}
