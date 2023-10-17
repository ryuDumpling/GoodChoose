package com.ryu.goodchoose.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ryu.goodchoose.model.sys.Region;

import java.util.List;

/**
 * <p>
 * 地区表 服务类
 * </p>
 *
 * @author ryu
 * @since 2023-10-03
 */
public interface RegionService extends IService<Region> {

    List<Region> getRegionByKeyword(String keyword);
}
