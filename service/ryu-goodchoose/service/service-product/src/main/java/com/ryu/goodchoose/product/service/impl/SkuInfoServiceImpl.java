package com.ryu.goodchoose.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ryu.goodchoose.common.config.RedissonConfig;
import com.ryu.goodchoose.common.constant.RedisConst;
import com.ryu.goodchoose.common.exception.GcException;
import com.ryu.goodchoose.common.result.ResultCodeEnum;
import com.ryu.goodchoose.model.product.*;
import com.ryu.goodchoose.mq.constant.MqConst;
import com.ryu.goodchoose.mq.service.RabbitService;
import com.ryu.goodchoose.product.mapper.SkuAttrValueMapper;
import com.ryu.goodchoose.product.mapper.SkuImageMapper;
import com.ryu.goodchoose.product.mapper.SkuInfoMapper;
import com.ryu.goodchoose.product.mapper.SkuPosterMapper;
import com.ryu.goodchoose.product.service.SkuAttrValueService;
import com.ryu.goodchoose.product.service.SkuImageService;
import com.ryu.goodchoose.product.service.SkuInfoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ryu.goodchoose.product.service.SkuPosterService;
import com.ryu.goodchoose.vo.product.SkuInfoQueryVo;
import com.ryu.goodchoose.vo.product.SkuInfoVo;
import com.ryu.goodchoose.vo.product.SkuStockLockVo;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * sku信息 服务实现类
 * </p>
 *
 * @author ryu
 * @since 2023-10-04
 */
@Service
public class SkuInfoServiceImpl extends ServiceImpl<SkuInfoMapper, SkuInfo> implements SkuInfoService {

    @Autowired
    private SkuImageService skuImageService;
    @Autowired
    private SkuAttrValueService skuAttrValueService;
    @Autowired
    private SkuPosterService skuPosterService;
    @Autowired
    private SkuInfoMapper skuInfoMapper;

    @Autowired
    private RedissonClient redissonClient;

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private RabbitService rabbitService;
    @Override
    public IPage<SkuInfo> selectPageSkuInfo(Page<SkuInfo> pageParam, SkuInfoQueryVo skuInfoQueryVo) {
        Long categoryId = skuInfoQueryVo.getCategoryId();
        String keyword = skuInfoQueryVo.getKeyword();
        String skuType = skuInfoQueryVo.getSkuType();
        LambdaQueryWrapper<SkuInfo> wrapper = new LambdaQueryWrapper<>();
        if(!StringUtils.isEmpty(keyword)){
            wrapper.like(SkuInfo::getSkuName,keyword);
        }
        if(!StringUtils.isEmpty(skuType)){
            wrapper.like(SkuInfo::getSkuType,skuType);
        }
        if(categoryId!=null){
            wrapper.like(SkuInfo::getCategoryId,categoryId);
        }
        IPage<SkuInfo> skuInfoPage = baseMapper.selectPage(pageParam, wrapper);
        return skuInfoPage;
    }

    @Override
    public void saveSkuInfo(SkuInfoVo skuInfoVo) {
        //添加sku的基础信息
        SkuInfo skuInfo = new SkuInfo();
        //调用工具类，将skuInfoVo中与skuInfo名称相同的值复制过去
        BeanUtils.copyProperties(skuInfoVo,skuInfo);
        baseMapper.insert(skuInfo);
        //保存sku海报
        List<SkuPoster> skuPosterList = skuInfoVo.getSkuPosterList();
        if(!CollectionUtils.isEmpty(skuPosterList)){
            for(SkuPoster skuPoster:skuPosterList){
                //向每个skuPoster中注入skuId
                skuPoster.setSkuId(skuInfo.getId());
            }
            skuPosterService.saveBatch(skuPosterList);
        }
        //保存sku图片
        List<SkuImage> skuImagesList = skuInfoVo.getSkuImagesList();
        if(!CollectionUtils.isEmpty(skuImagesList)){
            for(SkuImage skuImage:skuImagesList){
                //向每个skuImage中注入skuId
                skuImage.setSkuId(skuInfo.getId());
            }
            skuImageService.saveBatch(skuImagesList);
        }
        //保存sku平台属性
        List<SkuAttrValue> skuAttrValueList = skuInfoVo.getSkuAttrValueList();
        if(!CollectionUtils.isEmpty(skuAttrValueList)){
            for(SkuAttrValue skuAttrValue:skuAttrValueList){
                skuAttrValue.setSkuId(skuInfo.getId());
            }
            skuAttrValueService.saveBatch(skuAttrValueList);
        }
    }

    @Override
    public SkuInfoVo getSkuInfoById(Long id) {
        SkuInfoVo skuInfoVo = new SkuInfoVo();
        //根据id查询Sku信息
        SkuInfo skuInfo = baseMapper.selectById(id);
        //根据id查询商品图片列表
        List<SkuImage> skuImages = skuImageService.getImageListBySkuId(id);
        //根据id查询商品海报列表
        List<SkuPoster> skuPosters = skuPosterService.getPostersBySkuId(id);
        //根据id查询属性信息
        List<SkuAttrValue> skuAttrValueList = skuAttrValueService.getSkuValueBySkuId(id);
        //封装数据返回
        BeanUtils.copyProperties(skuInfo,skuInfoVo);
        skuInfoVo.setSkuImagesList(skuImages);
        skuInfoVo.setSkuPosterList(skuPosters);
        skuInfoVo.setSkuAttrValueList(skuAttrValueList);
        return skuInfoVo;
    }

    @Override
    public void updateSkuInfo(SkuInfoVo skuInfoVo) {
        //添加sku的基础信息
        SkuInfo skuInfo = new SkuInfo();
        //调用工具类，将skuInfoVo中与skuInfo名称相同的值复制过去
        BeanUtils.copyProperties(skuInfoVo,skuInfo);
        baseMapper.updateById(skuInfo);
        //修改sku海报
        //先删除原有海报，再重新添加
        skuPosterService.removeBatchByIds(skuPosterService.getPostersBySkuId(skuInfoVo.getId()));
        List<SkuPoster> skuPosterList = skuInfoVo.getSkuPosterList();
        if(!CollectionUtils.isEmpty(skuPosterList)){
            for(SkuPoster skuPoster:skuPosterList){
                //向每个skuPoster中注入skuId
                skuPoster.setSkuId(skuInfo.getId());
                skuPoster.setId(null);
            }
            skuPosterService.saveBatch(skuPosterList);
        }
        //修改sku图片
        skuImageService.removeBatchByIds(skuImageService.getImageListBySkuId(skuInfoVo.getId()));
        List<SkuImage> skuImagesList = skuInfoVo.getSkuImagesList();
        if(!CollectionUtils.isEmpty(skuImagesList)){
            for(SkuImage skuImage:skuImagesList){
                //向每个skuImage中注入skuId
                skuImage.setSkuId(skuInfo.getId());
                skuImage.setId(null);
            }
            skuImageService.saveBatch(skuImagesList);
        }
        //修改sku平台属性
        skuAttrValueService.removeBatchByIds(skuAttrValueService.getSkuValueBySkuId(skuInfoVo.getId()));
        List<SkuAttrValue> skuAttrValueList = skuInfoVo.getSkuAttrValueList();
        if(!CollectionUtils.isEmpty(skuAttrValueList)){
            for(SkuAttrValue skuAttrValue:skuAttrValueList){
                skuAttrValue.setSkuId(skuInfo.getId());
                skuAttrValue.setId(null);
            }
            skuAttrValueService.saveBatch(skuAttrValueList);
        }
    }

    @Override
    public void removeSkuInfoById(Long id) {
        baseMapper.deleteById(id);
        skuPosterService.removeBatchByIds(skuPosterService.getPostersBySkuId(id));
        skuImageService.removeBatchByIds(skuImageService.getImageListBySkuId(id));
        skuAttrValueService.removeBatchByIds(skuAttrValueService.getSkuValueBySkuId(id));
    }

    @Override
    public void removeAllByIds(List<Long> idList) {
        baseMapper.deleteBatchIds(idList);
        for (Long id:idList) {
            skuPosterService.removeBatchByIds(skuPosterService.getPostersBySkuId(id));
            skuImageService.removeBatchByIds(skuImageService.getImageListBySkuId(id));
            skuAttrValueService.removeBatchByIds(skuAttrValueService.getSkuValueBySkuId(id));
        }
    }

    @Override
    public void check(Long skuId, Integer status) {
        SkuInfo skuInfo = baseMapper.selectById(skuId);
        skuInfo.setCheckStatus(status);
        baseMapper.updateById(skuInfo);
    }

    @Override
    public void publish(Long skuId, Integer status) {
        if (status == 1){
            //商品上架
            SkuInfo skuInfo = baseMapper.selectById(skuId);
            skuInfo.setPublishStatus(status);
            baseMapper.updateById(skuInfo);
            //整合mq把数据同步到es里
            rabbitService.sendMessage(MqConst.EXCHANGE_GOODS_DIRECT,
                    MqConst.ROUTING_GOODS_UPPER,
                    skuId);

        } else {
            //商品下架
            SkuInfo skuInfo = baseMapper.selectById(skuId);
            skuInfo.setPublishStatus(status);
            baseMapper.updateById(skuInfo);
            //整合mq把数据同步到es里
            rabbitService.sendMessage(MqConst.EXCHANGE_GOODS_DIRECT,
                    MqConst.ROUTING_GOODS_LOWER,
                    skuId);
        }
    }

    @Override
    public void isNewPerson(Long skuId, Integer status) {
        SkuInfo skuInfo = new SkuInfo();
        skuInfo.setId(skuId);
        skuInfo.setIsNewPerson(status);
        skuInfoMapper.updateById(skuInfo);
    }

    @Override
    public List<SkuInfo> findSkuInfoList(List<Long> skuIdList) {
        List<SkuInfo> skuInfoList = baseMapper.selectBatchIds(skuIdList);
        return skuInfoList;
    }

    @Override
    public List<SkuInfo> selectList(String keyword) {
        List<SkuInfo> skuInfoList = baseMapper.selectList(
                new LambdaQueryWrapper<SkuInfo>().like(SkuInfo::getSkuName, keyword)
        );
        return skuInfoList;
    }

    //新人专享-三个商品
    @Override
    public List<SkuInfo> findNewPersonSkuInfoList() {
        //is_new_person=1 是新人专享商品
        //publish_status=1 已经上架
        //只显示三个
        Page<SkuInfo> pageParam = new Page<>(1,3);
        LambdaQueryWrapper<SkuInfo> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SkuInfo::getIsNewPerson,1);
        wrapper.eq(SkuInfo::getPublishStatus,1);
        wrapper.orderByDesc(SkuInfo::getSort);
        IPage<SkuInfo> skuInfoPage = baseMapper.selectPage(pageParam, wrapper);
        List<SkuInfo> skuInfoList = skuInfoPage.getRecords();
        return skuInfoList;
    }

    //skuId->skuInfoVo

    @Override
    public SkuInfoVo getSkuInfoVoById(Long skuId) {
        SkuInfoVo skuInfoVo = new SkuInfoVo();
        //根据id查询Sku信息
        SkuInfo skuInfo = baseMapper.selectById(skuId);
        //根据id查询商品图片列表
        List<SkuImage> skuImages = skuImageService.getImageListBySkuId(skuId);
        //根据id查询商品海报列表
        List<SkuPoster> skuPosters = skuPosterService.getPostersBySkuId(skuId);
        //根据id查询属性信息
        List<SkuAttrValue> skuAttrValueList = skuAttrValueService.getSkuValueBySkuId(skuId);
        //封装数据返回
        BeanUtils.copyProperties(skuInfo,skuInfoVo);
        skuInfoVo.setSkuImagesList(skuImages);
        skuInfoVo.setSkuPosterList(skuPosters);
        skuInfoVo.setSkuAttrValueList(skuAttrValueList);
        return skuInfoVo;
    }

    //验证和锁定库存
    @Override
    public Boolean checkAndLock(List<SkuStockLockVo> skuStockLockVoList, String orderNo) {
        //1 判断集合是否为空
        if(CollectionUtils.isEmpty(skuStockLockVoList)){
            throw new GcException(ResultCodeEnum.DATA_ERROR);
        }
        //2 遍历集合得到每个商品-验证库存
        skuStockLockVoList.stream().forEach(skuStockLockVo -> {
            this.checkLock(skuStockLockVo);
        });

        //3 只要有一个商品锁定失败
        boolean flag = skuStockLockVoList.stream().anyMatch(skuStockLockVo -> !skuStockLockVo.getIsLock());
        if (flag){
            //所有锁定成功的商品都解锁
            skuStockLockVoList.stream().filter(SkuStockLockVo::getIsLock).forEach(skuStockLockVo -> {
                baseMapper.unlockStock(skuStockLockVo.getSkuId(),skuStockLockVo.getSkuNum());
            });
            //返回一个失败值
            return false;
        }

        //4 如果所有商品都锁定成功了，redis缓存相关数据，为了方便后面的解锁和减库存
        redisTemplate.opsForValue().set(RedisConst.SROCK_INFO+orderNo,skuStockLockVoList);
        return true;
    }

    private void checkLock(SkuStockLockVo skuStockLockVo) {
        //获取锁-公平锁-等待时间最长的最先得到
        RLock rLock = this.redissonClient.getFairLock(RedisConst.SKUKEY_PREFIX + skuStockLockVo.getSkuId());
        //加锁
        rLock.lock();
        try {
            //验库存
            SkuInfo skuInfo= baseMapper.checkStock(skuStockLockVo.getSkuId(),skuStockLockVo.getSkuNum());
            if (skuInfo == null){
                //说明没查到数据-库存不足
                skuStockLockVo.setIsLock(false);
                return;
            }
            //库存充足-锁定
            Integer rows=baseMapper.lockStock(skuStockLockVo.getSkuId(),skuStockLockVo.getSkuNum());
            if (rows == 1){
                skuStockLockVo.setIsLock(true);
            }
        } finally {
            //解锁
            rLock.unlock();
        }
    }
}
