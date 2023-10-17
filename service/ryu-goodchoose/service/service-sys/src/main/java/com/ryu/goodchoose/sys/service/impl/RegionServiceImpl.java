package com.ryu.goodchoose.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.ryu.goodchoose.model.sys.Region;
import com.ryu.goodchoose.model.sys.RegionWare;
import com.ryu.goodchoose.sys.mapper.RegionMapper;
import com.ryu.goodchoose.sys.service.RegionService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 地区表 服务实现类
 * </p>
 *
 * @author ryu
 * @since 2023-10-03
 */
@Service
public class RegionServiceImpl extends ServiceImpl<RegionMapper, Region> implements RegionService {

    //根据关键字查询所有区域
    @Override
    public List<Region> getRegionByKeyword(String keyword) {
        LambdaQueryWrapper<Region> wrapper = new LambdaQueryWrapper<>();
        //根据区域名称查询
        wrapper.like(Region::getName,keyword);
        //封装结果
        List<Region> regions = baseMapper.selectList(wrapper);
        //返回结果
        return regions;
    }
}
