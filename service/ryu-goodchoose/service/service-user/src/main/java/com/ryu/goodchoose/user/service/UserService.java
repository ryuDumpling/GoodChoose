package com.ryu.goodchoose.user.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ryu.goodchoose.model.user.User;
import com.ryu.goodchoose.vo.user.LeaderAddressVo;
import com.ryu.goodchoose.vo.user.UserLoginVo;

public interface UserService extends IService<User> {
    User getUserByOpenId(String openid);

    LeaderAddressVo getLeaderAndAddressByUserId(Long userId);

    UserLoginVo getUserLoginVo(Long id);
}
