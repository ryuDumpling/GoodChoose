package com.ryu.goodchoose.user.service.ipml;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ryu.goodchoose.model.user.Leader;
import com.ryu.goodchoose.model.user.User;
import com.ryu.goodchoose.model.user.UserDelivery;
import com.ryu.goodchoose.user.mapper.LeaderMapper;
import com.ryu.goodchoose.user.mapper.UserDeliveryMapper;
import com.ryu.goodchoose.user.mapper.UserMapper;
import com.ryu.goodchoose.user.service.UserService;
import com.ryu.goodchoose.vo.user.LeaderAddressVo;
import com.ryu.goodchoose.vo.user.UserLoginVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author ryuDumpling
 * @version 2023/10/12 14:36
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {
    @Autowired
    private LeaderMapper leaderMapper;

    @Autowired
    private UserDeliveryMapper userDeliveryMapper;

    //查询一条用户数据
    @Override
    public User getUserByOpenId(String openid) {
        User user = baseMapper.selectOne(
                new LambdaQueryWrapper<User>().eq(User::getOpenId, openid)
        );
        return user;
    }

    //根据userId查询提货点和团长信息
    @Override
    public LeaderAddressVo getLeaderAndAddressByUserId(Long userId) {
        LambdaQueryWrapper<UserDelivery> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserDelivery::getUserId, userId).eq(UserDelivery::getIsDefault, 1);
        UserDelivery userDelivery = userDeliveryMapper.selectOne(wrapper);
        if(userDelivery == null){
            return null;
        }
        //用团长id查询团长信息
        Leader leader = leaderMapper.selectById(userDelivery.getLeaderId());
        //封装
        LeaderAddressVo leaderAddressVo = new LeaderAddressVo();
        BeanUtils.copyProperties(leader, leaderAddressVo);
        leaderAddressVo.setUserId(userId);
        leaderAddressVo.setLeaderId(leader.getId());
        leaderAddressVo.setLeaderName(leader.getName());
        leaderAddressVo.setLeaderPhone(leader.getPhone());
        leaderAddressVo.setWareId(userDelivery.getWareId());
        leaderAddressVo.setStorePath(leader.getStorePath());
        return leaderAddressVo;
    }

    //获取当前登录用户信息

    @Override
    public UserLoginVo getUserLoginVo(Long id) {
        User user = baseMapper.selectById(id);
        UserLoginVo userLoginVo = new UserLoginVo();
        userLoginVo.setNickName(user.getNickName());
        userLoginVo.setUserId(id);
        userLoginVo.setPhotoUrl(user.getPhotoUrl());
        userLoginVo.setOpenId(user.getOpenId());
        userLoginVo.setIsNew(user.getIsNew());
        UserDelivery userDelivery = userDeliveryMapper.selectOne(
                new LambdaQueryWrapper<UserDelivery>().eq(UserDelivery::getUserId, id).
                        eq(UserDelivery::getIsDefault, 1)
        );
        if (userDelivery != null){
            userLoginVo.setLeaderId(userDelivery.getLeaderId());
            userLoginVo.setWareId(userDelivery.getWareId());
        } else {
            //给固定值
            userLoginVo.setLeaderId(1L);
            userLoginVo.setWareId(1L);
        }
        return userLoginVo;
    }
}
