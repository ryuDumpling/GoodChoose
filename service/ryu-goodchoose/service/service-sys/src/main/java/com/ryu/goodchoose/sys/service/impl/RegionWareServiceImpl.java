package com.ryu.goodchoose.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ryu.goodchoose.common.exception.GcException;
import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.common.result.ResultCodeEnum;
import com.ryu.goodchoose.model.sys.RegionWare;
import com.ryu.goodchoose.sys.mapper.RegionWareMapper;
import com.ryu.goodchoose.sys.service.RegionWareService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ryu.goodchoose.vo.sys.RegionWareQueryVo;
import io.swagger.annotations.ApiOperation;
import io.swagger.models.auth.In;
import jodd.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

/**
 * <p>
 * 城市仓库关联表 服务实现类
 * </p>
 *
 * @author ryu
 * @since 2023-10-03
 */
@Service
public class RegionWareServiceImpl extends ServiceImpl<RegionWareMapper, RegionWare> implements RegionWareService {

    //开通区域列表
    @Override
    public IPage<RegionWare> selectPageRegionWare(Page<RegionWare> pageParam, RegionWareQueryVo regionWareQueryVo) {
        //获取条件查询值
        String keyword = regionWareQueryVo.getKeyword();
        LambdaQueryWrapper<RegionWare> wrapper = new LambdaQueryWrapper<>();
        //判断值是否存在
        if(!StringUtils.isEmpty(keyword)){
            //根据区域名称或者仓库名称查询
            wrapper.like(RegionWare::getRegionName,keyword)
                    .or().like(RegionWare::getWareName,keyword);

        }
        //封装结果
        IPage<RegionWare> regionWarePage = baseMapper.selectPage(pageParam, wrapper);
        //返回结果
        return regionWarePage;
    }

    //添加开通区域
    @Override
    public void saveRegionWare(RegionWare regionWare) {
        //判断区域是否已经开通
        LambdaQueryWrapper<RegionWare> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RegionWare::getRegionId,regionWare.getRegionId());
        Long count = baseMapper.selectCount(wrapper);
        if(count>0){
            //说明已经开通过
            //抛出异常
            throw new GcException(ResultCodeEnum.REGION_OPEN);
        }
        baseMapper.insert(regionWare);
    }

    @Override
    public void updateStatus(Long id, Integer status) {
        RegionWare regionWare = baseMapper.selectById(id);
        regionWare.setStatus(status);
        baseMapper.updateById(regionWare);
    }


}
