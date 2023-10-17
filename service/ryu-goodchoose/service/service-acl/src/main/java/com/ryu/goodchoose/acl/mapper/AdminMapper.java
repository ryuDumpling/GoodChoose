package com.ryu.goodchoose.acl.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ryu.goodchoose.model.acl.Admin;
import com.ryu.goodchoose.model.acl.Role;
import org.springframework.stereotype.Repository;

@Repository
public interface AdminMapper extends BaseMapper<Admin> {
}
