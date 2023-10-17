package com.ryu.goodchoose.sys.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ryu.goodchoose.model.sys.Ware;
import com.ryu.goodchoose.vo.product.WareQueryVo;

/**
 * <p>
 * 仓库表 服务类
 * </p>
 *
 * @author ryu
 * @since 2023-10-03
 */
public interface WareService extends IService<Ware> {

    IPage<Ware> selectPageWare(Page<Ware> pageParam, WareQueryVo wareQueryVo);
}
