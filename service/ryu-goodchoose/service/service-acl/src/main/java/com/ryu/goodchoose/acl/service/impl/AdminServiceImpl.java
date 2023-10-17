package com.ryu.goodchoose.acl.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ryu.goodchoose.acl.mapper.AdminMapper;
import com.ryu.goodchoose.acl.service.AdminService;
import com.ryu.goodchoose.acl.service.AdminService;
import com.ryu.goodchoose.model.acl.Admin;
import com.ryu.goodchoose.model.acl.Admin;
import com.ryu.goodchoose.vo.acl.AdminQueryVo;
import jodd.util.StringUtil;
import org.springframework.stereotype.Service;

/**
 * @author ryuDumpling
 * @version 2023/10/3 13:43
 */
@Service
public class AdminServiceImpl extends ServiceImpl<AdminMapper, Admin> implements AdminService {
    @Override
    public IPage<Admin> selectAdminPage(Page<Admin> pageParam, AdminQueryVo adminQueryVo) {
        //获取条件值
        String name = adminQueryVo.getName();
        String username = adminQueryVo.getUsername();
        //创建mp条件对象
        LambdaQueryWrapper<Admin> wrapper = new LambdaQueryWrapper<>();
        //判断值是否为空
        if(!StringUtils.isEmpty(name)){
            wrapper.like(Admin::getName,name);
        }
        if(!StringUtils.isEmpty(username)){
            wrapper.like(Admin::getUsername,username);
        }
        //实现条件查询
        IPage<Admin> pageModel = baseMapper.selectPage(pageParam, wrapper);
        //返回对象
        return pageModel;
    }
}
