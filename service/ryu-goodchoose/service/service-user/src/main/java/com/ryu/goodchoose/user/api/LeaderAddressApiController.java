package com.ryu.goodchoose.user.api;

import com.ryu.goodchoose.user.service.UserService;
import com.ryu.goodchoose.vo.user.LeaderAddressVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author ryuDumpling
 * @version 2023/10/13 10:57
 */
@Api(tags = "团长接口")
@RestController
@RequestMapping("/api/user/leader")
public class LeaderAddressApiController {
    @Autowired
    private UserService userService;

    @ApiOperation("根据userId查询提货点和团长信息")
    @GetMapping("/inner/getUserAddressByUserId/{userId}")
    public LeaderAddressVo getUserAddressByUserId(@PathVariable Long userId){
        LeaderAddressVo leaderAndAddressByUserId = userService.getLeaderAndAddressByUserId(userId);
        return leaderAndAddressByUserId;
    }
}
