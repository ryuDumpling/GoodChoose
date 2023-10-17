package com.ryu.goodchoose.activity.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ryu.goodchoose.model.activity.ActivityInfo;
import com.ryu.goodchoose.model.activity.ActivityRule;
import com.ryu.goodchoose.model.order.CartInfo;
import com.ryu.goodchoose.model.product.SkuInfo;
import com.ryu.goodchoose.vo.activity.ActivityRuleVo;
import com.ryu.goodchoose.vo.order.CartInfoVo;
import com.ryu.goodchoose.vo.order.OrderConfirmVo;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 活动表 服务类
 * </p>
 *
 * @author ryu
 * @since 2023-10-11
 */
public interface ActivityInfoService extends IService<ActivityInfo> {

    IPage<ActivityInfo> selectPage(Page<ActivityInfo> pageParam);

    Map<String, Object> findActivityRuleList(Long id);

    void saveActivityRule(ActivityRuleVo activityRuleVo);

    List<SkuInfo> findSkuInfoByKeyword(String keyword);

    void deleteRuleAndSku(Long id);

    Map<Long, List<String>> findActivity(List<Long> skuIdList);

    Map<String, Object> findActivityAndCoupon(Long skuId, Long userId);

    //根据skuId获取当前商品的营销活动
    List<ActivityRule> findActivityListBySkuId(Long skuId);

    OrderConfirmVo findCartActivityAndCoupon(List<CartInfo> cartInfoList, Long userId);

    //获取购物项对应的规则数据
    List<CartInfoVo> findCartActivityList(List<CartInfo> cartInfoList);
}
