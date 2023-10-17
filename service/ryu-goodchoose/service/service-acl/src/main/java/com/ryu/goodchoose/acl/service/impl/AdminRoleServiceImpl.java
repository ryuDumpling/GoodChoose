package com.ryu.goodchoose.acl.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ryu.goodchoose.acl.mapper.AdminMapper;
import com.ryu.goodchoose.acl.mapper.AdminRoleMapper;
import com.ryu.goodchoose.acl.service.AdminRoleService;
import com.ryu.goodchoose.acl.service.AdminService;
import com.ryu.goodchoose.model.acl.Admin;
import com.ryu.goodchoose.model.acl.AdminRole;
import com.ryu.goodchoose.vo.acl.AdminQueryVo;
import org.springframework.stereotype.Service;

/**
 * @author ryuDumpling
 * @version 2023/10/3 13:43
 */
@Service
public class AdminRoleServiceImpl extends ServiceImpl<AdminRoleMapper, AdminRole> implements AdminRoleService {

}
