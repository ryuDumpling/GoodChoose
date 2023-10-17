package com.ryu.goodchoose.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ryu.goodchoose.model.sys.RegionWare;
import com.ryu.goodchoose.model.sys.Ware;
import com.ryu.goodchoose.sys.mapper.WareMapper;
import com.ryu.goodchoose.sys.service.WareService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ryu.goodchoose.vo.product.WareQueryVo;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 仓库表 服务实现类
 * </p>
 *
 * @author ryu
 * @since 2023-10-03
 */
@Service
public class WareServiceImpl extends ServiceImpl<WareMapper, Ware> implements WareService {

    //查询仓库分页列表
    @Override
    public IPage<Ware> selectPageWare(Page<Ware> pageParam, WareQueryVo wareQueryVo) {
        //获取条件查询值
        String name = wareQueryVo.getName();
        LambdaQueryWrapper<Ware> wrapper = new LambdaQueryWrapper<>();
        //判断值是否存在
        if(!StringUtils.isEmpty(name)){
            //根据区域名称或者仓库名称查询
            wrapper.like(Ware::getName,name);
        }
        //封装结果
        IPage<Ware> warePage = baseMapper.selectPage(pageParam, wrapper);
        //返回结果
        return warePage;
    }
}
