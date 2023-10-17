package com.ryu.goodchoose.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ryu.goodchoose.model.product.AttrGroup;
import com.ryu.goodchoose.model.product.Category;
import com.ryu.goodchoose.product.mapper.AttrGroupMapper;
import com.ryu.goodchoose.product.service.AttrGroupService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ryu.goodchoose.vo.product.AttrGroupQueryVo;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 属性分组 服务实现类
 * </p>
 *
 * @author ryu
 * @since 2023-10-04
 */
@Service
public class AttrGroupServiceImpl extends ServiceImpl<AttrGroupMapper, AttrGroup> implements AttrGroupService {

    //平台属性分组方法
    @Override
    public IPage<AttrGroup> selectPageAttrGroup(Page<AttrGroup> pageParam, AttrGroupQueryVo attrGroupQueryVo) {
        String name = attrGroupQueryVo.getName();
        LambdaQueryWrapper<AttrGroup> wrapper = new LambdaQueryWrapper<>();
        if(!StringUtils.isEmpty(name)){
            wrapper.like(AttrGroup::getName,name);
        }
        IPage<AttrGroup> attrGroupPage = baseMapper.selectPage(pageParam, wrapper);
        return attrGroupPage;
    }

    @Override
    public List<AttrGroup> findAllList() {
//        LambdaQueryWrapper<AttrGroup> wrapper = new LambdaQueryWrapper<>();
//        //降序排列
//        wrapper.orderByDesc(AttrGroup::getId);
        QueryWrapper<AttrGroup> queryWrapper = new QueryWrapper<>();
        //根据id降序排列
        queryWrapper.orderByDesc("id");
        List<AttrGroup> list = baseMapper.selectList(queryWrapper);
        return list;
    }
}
