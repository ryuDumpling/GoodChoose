package com.ryu.goodchoose.activity.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ryu.goodchoose.activity.mapper.ActivityInfoMapper;
import com.ryu.goodchoose.activity.mapper.ActivityRuleMapper;
import com.ryu.goodchoose.activity.mapper.ActivitySkuMapper;
import com.ryu.goodchoose.activity.service.ActivityInfoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ryu.goodchoose.activity.service.CouponInfoService;
import com.ryu.goodchoose.client.product.ProductFeignClient;
import com.ryu.goodchoose.enums.ActivityType;
import com.ryu.goodchoose.model.activity.ActivityInfo;
import com.ryu.goodchoose.model.activity.ActivityRule;
import com.ryu.goodchoose.model.activity.ActivitySku;
import com.ryu.goodchoose.model.activity.CouponInfo;
import com.ryu.goodchoose.model.order.CartInfo;
import com.ryu.goodchoose.model.product.SkuInfo;
import com.ryu.goodchoose.vo.activity.ActivityRuleVo;
import com.ryu.goodchoose.vo.order.CartInfoVo;
import com.ryu.goodchoose.vo.order.OrderConfirmVo;
import org.apache.commons.lang.StringUtils;
import org.bouncycastle.asn1.cmp.CRLAnnContent;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

/**
 * <p>
 * 活动表 服务实现类
 * </p>
 *
 * @author ryu
 * @since 2023-10-11
 */
@Service
public class ActivityInfoServiceImpl extends ServiceImpl<ActivityInfoMapper, ActivityInfo> implements ActivityInfoService {
    @Autowired
    private ActivityRuleMapper activityRuleMapper;

    @Autowired
    private ActivitySkuMapper activitySkuMapper;

    @Autowired
    private ProductFeignClient productFeignClient;

    @Autowired
    private CouponInfoService couponInfoService;

    /**
     * 计算满量打折最优规则
     * @param totalNum
     * @param activityRuleList //该活动规则skuActivityRuleList数据，已经按照优惠折扣从大到小排序了
     */
    private ActivityRule computeFullDiscount(Integer totalNum, BigDecimal totalAmount, List<ActivityRule> activityRuleList) {
        ActivityRule optimalActivityRule = null;
        //该活动规则skuActivityRuleList数据，已经按照优惠金额从大到小排序了
        for (ActivityRule activityRule : activityRuleList) {
            //如果订单项购买个数大于等于满减件数，则优化打折
            if (totalNum.intValue() >= activityRule.getConditionNum()) {
                BigDecimal skuDiscountTotalAmount = totalAmount.multiply(activityRule.getBenefitDiscount().divide(new BigDecimal("10")));
                BigDecimal reduceAmount = totalAmount.subtract(skuDiscountTotalAmount);
                activityRule.setReduceAmount(reduceAmount);
                optimalActivityRule = activityRule;
                break;
            }
        }
        if(null == optimalActivityRule) {
            //如果没有满足条件的取最小满足条件的一项
            optimalActivityRule = activityRuleList.get(activityRuleList.size()-1);
            optimalActivityRule.setReduceAmount(new BigDecimal("0"));
            optimalActivityRule.setSelectType(1);

            StringBuffer ruleDesc = new StringBuffer()
                    .append("满")
                    .append(optimalActivityRule.getConditionNum())
                    .append("元打")
                    .append(optimalActivityRule.getBenefitDiscount())
                    .append("折，还差")
                    .append(totalNum-optimalActivityRule.getConditionNum())
                    .append("件");
            optimalActivityRule.setRuleDesc(ruleDesc.toString());
        } else {
            StringBuffer ruleDesc = new StringBuffer()
                    .append("满")
                    .append(optimalActivityRule.getConditionNum())
                    .append("元打")
                    .append(optimalActivityRule.getBenefitDiscount())
                    .append("折，已减")
                    .append(optimalActivityRule.getReduceAmount())
                    .append("元");
            optimalActivityRule.setRuleDesc(ruleDesc.toString());
            optimalActivityRule.setSelectType(2);
        }
        return optimalActivityRule;
    }

    /**
     * 计算满减最优规则
     * @param totalAmount
     * @param activityRuleList //该活动规则skuActivityRuleList数据，已经按照优惠金额从大到小排序了
     */
    private ActivityRule computeFullReduction(BigDecimal totalAmount, List<ActivityRule> activityRuleList) {
        ActivityRule optimalActivityRule = null;
        //该活动规则skuActivityRuleList数据，已经按照优惠金额从大到小排序了
        for (ActivityRule activityRule : activityRuleList) {
            //如果订单项金额大于等于满减金额，则优惠金额
            if (totalAmount.compareTo(activityRule.getConditionAmount()) > -1) {
                //优惠后减少金额
                activityRule.setReduceAmount(activityRule.getBenefitAmount());
                optimalActivityRule = activityRule;
                break;
            }
        }
        if(null == optimalActivityRule) {
            //如果没有满足条件的取最小满足条件的一项
            optimalActivityRule = activityRuleList.get(activityRuleList.size()-1);
            optimalActivityRule.setReduceAmount(new BigDecimal("0"));
            optimalActivityRule.setSelectType(1);

            StringBuffer ruleDesc = new StringBuffer()
                    .append("满")
                    .append(optimalActivityRule.getConditionAmount())
                    .append("元减")
                    .append(optimalActivityRule.getBenefitAmount())
                    .append("元，还差")
                    .append(totalAmount.subtract(optimalActivityRule.getConditionAmount()))
                    .append("元");
            optimalActivityRule.setRuleDesc(ruleDesc.toString());
        } else {
            StringBuffer ruleDesc = new StringBuffer()
                    .append("满")
                    .append(optimalActivityRule.getConditionAmount())
                    .append("元减")
                    .append(optimalActivityRule.getBenefitAmount())
                    .append("元，已减")
                    .append(optimalActivityRule.getReduceAmount())
                    .append("元");
            optimalActivityRule.setRuleDesc(ruleDesc.toString());
            optimalActivityRule.setSelectType(2);
        }
        return optimalActivityRule;
    }

    private BigDecimal computeTotalAmount(List<CartInfo> cartInfoList) {
        BigDecimal total = new BigDecimal("0");
        for (CartInfo cartInfo : cartInfoList) {
            //是否选中
            if(cartInfo.getIsChecked().intValue() == 1) {
                BigDecimal itemTotal = cartInfo.getCartPrice().multiply(new BigDecimal(cartInfo.getSkuNum()));
                total = total.add(itemTotal);
            }
        }
        return total;
    }

    private int computeCartNum(List<CartInfo> cartInfoList) {
        int total = 0;
        for (CartInfo cartInfo : cartInfoList) {
            //是否选中
            if(cartInfo.getIsChecked().intValue() == 1) {
                total += cartInfo.getSkuNum();
            }
        }
        return total;
    }

    //活动列表
    @Override
    public IPage<ActivityInfo> selectPage(Page<ActivityInfo> pageParam) {
        IPage<ActivityInfo> activityInfoIPage =
                baseMapper.selectPage(pageParam,null);
        //从对象中获取数据
        List<ActivityInfo> activityInfoList = activityInfoIPage.getRecords();
        //遍历数据，对每一个对象封装活动类型
        activityInfoList.stream().forEach(item ->{
            item.setActivityTypeString(item.getActivityType().getComment());
        });
        return activityInfoIPage;
    }

    @Override
    public Map<String, Object> findActivityRuleList(Long id) {
        Map<String, Object> result = new HashMap<>();
        //根据活动id查询规则列表
        LambdaQueryWrapper<ActivityRule> ruleQueryWrapper = new LambdaQueryWrapper<>();
        ruleQueryWrapper.eq(ActivityRule::getActivityId,id);
        List<ActivityRule> activityRules = activityRuleMapper.selectList(ruleQueryWrapper);
        result.put("activityRuleList",activityRules);
        //根据活动id查询使用商品的列表-远程调用service-product模块接口获得商品信息
        LambdaQueryWrapper<ActivitySku> skuLambdaQueryWrapper = new LambdaQueryWrapper<>();
        skuLambdaQueryWrapper.eq(ActivitySku::getActivityId,id);
        List<ActivitySku> activitySkuList = activitySkuMapper.selectList(skuLambdaQueryWrapper);
        if (activitySkuList.size()!=0){
            //获取所有的skuId
            List<Long> skuIdList = activitySkuList.stream().map(ActivitySku::getSkuId).collect(Collectors.toList());
            //根据skuId获得商品信息-远程调用
            List<SkuInfo> skuInfoList = productFeignClient.findSkuInfoList(skuIdList);
            result.put("skuInfoList",skuInfoList);
        } else {
            result.put("skuInfoList",null);
        }
        return result;
    }

    @Override
    public void saveActivityRule(ActivityRuleVo activityRuleVo) {
        //根据ActivityId删除原有的数据（activityRule&activitySku
        activityRuleMapper.delete(
                new LambdaQueryWrapper<ActivityRule>().eq(
                        ActivityRule::getActivityId,activityRuleVo.getActivityId()));
        activitySkuMapper.delete(
                new LambdaQueryWrapper<ActivitySku>().eq(
                        ActivitySku::getActivityId, activityRuleVo.getActivityId()));
//        this.deleteRuleAndSku(activityRuleVo.getActivityId());
        //获取活动规则数据并保存
        List<ActivityRule> activityRuleList = activityRuleVo.getActivityRuleList();
        for (ActivityRule activityRule:activityRuleList){
            activityRule.setId(null);
            activityRule.setActivityId(activityRuleVo.getActivityId());
            activityRule.setActivityType(baseMapper.selectById(activityRuleVo.getActivityId()).getActivityType());
            activityRuleMapper.insert(activityRule);
        }
        //获取活动商品数据并保存
        List<ActivitySku> activitySkuList = activityRuleVo.getActivitySkuList();
        for(ActivitySku activitySku:activitySkuList){
            activitySku.setActivityId(activityRuleVo.getActivityId());
            activitySkuMapper.insert(activitySku);
        }
    }

    //根据关键字获取商品信息
    @Override
    public List<SkuInfo> findSkuInfoByKeyword(String keyword) {
        //远程调用获取商品信息
        List<SkuInfo> skuInfoList = productFeignClient.findSkuInfoByKeyword(keyword);
        if(skuInfoList.size() == 0){
            return null;
        }
        //判断商品是否参加过活动，如果参加过且活动正在进行中，排除该商品（一个商品同一时间只能参加一个活动
        List<Long> skuIdList = skuInfoList.stream().map(SkuInfo::getId).collect(Collectors.toList());
        //在activitySku表中查询正在活动的idList
        List<Long> existSkuIdList = baseMapper.selectSkuIdListExist(skuIdList);
        //从activitySkuList中排除
        List<SkuInfo> findSkuList = new ArrayList<>();
        for (SkuInfo skuInfo:skuInfoList){
            if (!existSkuIdList.contains(skuInfo.getId())){
                findSkuList.add(skuInfo);
            }
        }
        return findSkuList;

//        List<SkuInfo> notExistSkuInfoList = new ArrayList<>();
//        List<Long> existSkuIdList = baseMapper.selectSkuIdListExist(skuIdList);
//        String existSkuIdString = "," + StringUtils.join(existSkuIdList.toArray(), ",") + ",";
//        for(SkuInfo skuInfo : skuInfoList) {
//            if(existSkuIdString.indexOf(","+skuInfo.getId()+",") == -1) {
//                notExistSkuInfoList.add(skuInfo);
//            }
//        }
//        return notExistSkuInfoList;
    }

    //删除规则和活动商品信息
    @Override
    public void deleteRuleAndSku(Long id) {
        //根据ActivityId删除activityRule&activitySku
        activityRuleMapper.delete(
                new LambdaQueryWrapper<ActivityRule>().eq(
                        ActivityRule::getActivityId,id));
        activitySkuMapper.delete(
                new LambdaQueryWrapper<ActivitySku>().eq(
                        ActivitySku::getActivityId, id));
    }

    //根据skuId列表获取促销信息
    @Override
    public Map<Long, List<String>> findActivity(List<Long> skuIdList) {
        Map<Long, List<String>> result = new HashMap<>();
        skuIdList.forEach(skuId ->{
            List<ActivityRule> activityRuleList = baseMapper.findActivityRule(skuId);
            if (!CollectionUtils.isEmpty(activityRuleList)){
                List<String> ruleList = new ArrayList<>();
                //自行处理规则
                for (ActivityRule rule:activityRuleList){
                    ruleList.add(this.getRuleDesc(rule));
                }
                result.put(skuId,ruleList);
            }
        });
        return result;
    }

    //构造规则名称的方法
    private String getRuleDesc(ActivityRule activityRule) {
        ActivityType activityType = activityRule.getActivityType();
        StringBuffer ruleDesc = new StringBuffer();
        if (activityType == ActivityType.FULL_REDUCTION) {
            ruleDesc
                    .append("满")
                    .append(activityRule.getConditionAmount())
                    .append("元减")
                    .append(activityRule.getBenefitAmount())
                    .append("元");
        } else {
            ruleDesc
                    .append("满")
                    .append(activityRule.getConditionNum())
                    .append("元打")
                    .append(activityRule.getBenefitDiscount())
                    .append("折");
        }
        return ruleDesc.toString();
    }

    @Override
    public Map<String, Object> findActivityAndCoupon(Long skuId, Long userId) {
        //根据skuid获取营销活动
        List<ActivityRule> activityListBySkuId = this.findActivityListBySkuId(skuId);
        //根据userId获取用户拥有的优惠券
        List<CouponInfo> couponInfoList = couponInfoService.findCouponInfoList(skuId,userId);
        Map<String, Object> map = new HashMap<>();
        map.put("couponInfoList",couponInfoList);
        map.put("activityRuleList",activityListBySkuId);
        return map;
    }

    @Override
    public List<ActivityRule> findActivityListBySkuId(Long skuId) {
        List<ActivityRule> activityRuleList = baseMapper.findActivityRule(skuId);
        for (ActivityRule activityRule:activityRuleList){
            activityRule.setRuleDesc(this.getRuleDesc(activityRule));
        }
        return activityRuleList;
    }

    //获取购物项对应的规则数据
    @Override
    public List<CartInfoVo> findCartActivityList(List<CartInfo> cartInfoList) {
        List<CartInfoVo> cartInfoVoList = new ArrayList<>();
        List<Long> skuIdList = cartInfoList.stream().map(CartInfo::getSkuId).collect(Collectors.toList());
        //根据所有skuId得到参与的活动id
        List<ActivitySku> activitySkuList = baseMapper.selectCartActivity(skuIdList);
        //对数据进行规范化（分组）处理，每个活动中有哪些skuId信息
        //map中是key分组字段 活动id value是每组sku列表数据，set集合（值不能重复）
        Map<Long, Set<Long>> activityIdToSkuIdListMap = activitySkuList.stream().collect(
                Collectors.groupingBy(
                        ActivitySku::getActivityId,
                        Collectors.mapping(ActivitySku::getSkuId, Collectors.toSet())
                )
        );
        //获取活动规则并封装
        Map<Long, List<ActivityRule>> activityIdToActivityRuleListMap = new HashMap<>();
        //获取所有活动id
        Set<Long> activityIdSet = activitySkuList.stream().map(ActivitySku::getActivityId).collect(Collectors.toSet());
        if(!CollectionUtils.isEmpty(activityIdSet)){
            LambdaQueryWrapper<ActivityRule> wrapper = new LambdaQueryWrapper<>();
            wrapper.orderByDesc(ActivityRule::getConditionAmount, ActivityRule::getConditionNum);
            wrapper.in(ActivityRule::getActivityId,activityIdSet);
            List<ActivityRule> activityRuleList = activityRuleMapper.selectList(wrapper);
            //根据活动id分组 -封装到activityIdToActivityRuleListMap中
            activityIdToActivityRuleListMap = activityRuleList.stream().collect(Collectors.groupingBy(activityRule ->
                    activityRule.getActivityId()));
        }
        //参加活动的购物项的skuId
        Set<Long> activitySkuIdSet = new HashSet<>();
        if (!CollectionUtils.isEmpty(activityIdToSkuIdListMap)){
            //遍历map集合 -迭代器
            Iterator<Map.Entry<Long, Set<Long>>> iterator = activityIdToSkuIdListMap.entrySet().iterator();
            while (iterator.hasNext()){
                Map.Entry<Long, Set<Long>> entry = iterator.next();
                //活动id
                Long activityId = entry.getKey();
                //每个活动对应的skuId列表
                Set<Long> currentActivitySkuIdSet = entry.getValue();
                //获取活动skuId对应的cartInfo信息
                List<CartInfo> currentActivityCartInfoList = cartInfoList.stream().filter(cartInfo ->
                        currentActivitySkuIdSet.contains(cartInfo.getSkuId())).collect(Collectors.toList());
                //计算活动商品的总金额和总数量
                BigDecimal activityTotalAmount = this.computeTotalAmount(currentActivityCartInfoList);
                int activityTotalNum = this.computeCartNum(currentActivityCartInfoList);
                //计算最优活动规则
                //根据活动id获取活动规则
                List<ActivityRule> currentActivityRuleList = activityIdToActivityRuleListMap.get(activityId);
                ActivityType activityType = currentActivityRuleList.get(0).getActivityType();
                //判断活动类型
                ActivityRule activityRule = null;
                if (activityType == ActivityType.FULL_REDUCTION){//满减
                    activityRule = this.computeFullReduction(activityTotalAmount, currentActivityRuleList);
                } else {//满量打折
                    activityRule = this.computeFullDiscount(activityTotalNum, activityTotalAmount, currentActivityRuleList);
                }
                CartInfoVo cartInfoVo = new CartInfoVo();
                cartInfoVo.setActivityRule(activityRule);
                cartInfoVo.setCartInfoList(currentActivityCartInfoList);
                cartInfoVoList.add(cartInfoVo);

                //记录哪些购物项参加了活动
                activitySkuIdSet.addAll(currentActivitySkuIdSet);
            }
        }
        //没有活动的skuId
        skuIdList.removeAll(activitySkuIdSet);
        //skuIdList.remove(activitySkuIdSet);//在所有skuIdList中移除参加了活动的skuId
        if(!CollectionUtils.isEmpty(skuIdList)){
            Map<Long, CartInfo> skuIdCartInfoMap = cartInfoList.stream().
                    collect(Collectors.toMap(CartInfo::getSkuId, CartInfo -> CartInfo));
            for (Long skuId:skuIdList){
                CartInfoVo cartInfoVo = new CartInfoVo();
                cartInfoVo.setActivityRule(null);
                List<CartInfo> cartInfos = new ArrayList<>();
                cartInfos.add(skuIdCartInfoMap.get(skuId));
                cartInfoVo.setCartInfoList(cartInfos);
                cartInfoVoList.add(cartInfoVo);
            }
        }
        return cartInfoVoList;
    }

    @Override
    public OrderConfirmVo findCartActivityAndCoupon(List<CartInfo> cartInfoList, Long userId) {
        //1 获取每个CartInfo的参与活动，按照活动进行分组（一个规则对应多个CartInfo） 没参与活动的一个组 -得到CartInfoVo类型数据
        List<CartInfoVo> cartInfoVoList = this.findCartActivityList(cartInfoList);
        //2 计算商品参与活动后的减免金额
        BigDecimal activityReduceAmount = cartInfoVoList.stream()
                .filter(cartInfoVo -> cartInfoVo.getActivityRule() != null)
                .map(cartInfoVo -> cartInfoVo.getActivityRule().getReduceAmount()).reduce(BigDecimal.ZERO, BigDecimal::add);
        //3 获取购物车中可用的优惠券列表
        List<CouponInfo> couponInfoList = couponInfoService.findCartCouponInfo(cartInfoList,userId);
        //4 计算商品使用了优惠券之后的金额，一次只能用一张优惠券
        BigDecimal couponReduceAmount = new BigDecimal(0);
        if (!CollectionUtils.isEmpty(couponInfoList)){
            couponReduceAmount = couponInfoList.stream().filter(couponInfo -> couponInfo.getIsOptimal().intValue() == 1)
                    .map(couponInfo -> couponInfo.getAmount())
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
        }
        //5 没参与活动与使用优惠券的原始金额
        BigDecimal originalTotalAmount = cartInfoList.stream().filter(cartInfo -> cartInfo.getIsChecked() == 1)
                .map(cartInfo -> cartInfo.getCartPrice().multiply(new BigDecimal(cartInfo.getSkuNum())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        //6 计算参与活动且使用优惠券的总金额
        BigDecimal totalAmount = originalTotalAmount.subtract(activityReduceAmount).subtract(couponReduceAmount);
        //7 封装数据返回结果 OrderConfirmVo
        OrderConfirmVo orderTradeVo = new OrderConfirmVo();
        orderTradeVo.setCarInfoVoList(cartInfoVoList);
        orderTradeVo.setActivityReduceAmount(activityReduceAmount);
        orderTradeVo.setCouponInfoList(couponInfoList);
        orderTradeVo.setCouponReduceAmount(couponReduceAmount);
        orderTradeVo.setOriginalTotalAmount(originalTotalAmount);
        orderTradeVo.setTotalAmount(totalAmount);
        return orderTradeVo;
    }
}
