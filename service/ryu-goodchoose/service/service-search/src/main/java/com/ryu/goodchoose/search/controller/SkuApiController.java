package com.ryu.goodchoose.search.controller;

import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.model.search.SkuEs;
import com.ryu.goodchoose.search.service.SkuService;
import com.ryu.goodchoose.vo.search.SkuEsQueryVo;
import io.swagger.models.auth.In;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author ryuDumpling
 * @version 2023/10/9 14:01
 */
@RestController
@RequestMapping("api/search/sku")
public class SkuApiController {
    @Autowired
    private SkuService skuService;

    //商品上架
    @GetMapping("/inner/upperSku/{skuId}")
    public Result upperSku(@PathVariable("skuId")Long skuId){
        skuService.upperSku(skuId);
        return Result.ok(null);
    }
    //商品下架
    @GetMapping("/inner/lowerSku/{skuId}")
    public Result lowerSku(@PathVariable("skuId")Long skuId){
        skuService.lowerSku(skuId);
        return Result.ok(null);
    }
    //获取爆款商品
    @GetMapping("/inner/findHotSkuList")
    public List<SkuEs> findHotSkuList(){
        return skuService.findHotSkuList();
    }

    //查询分类商品
    @GetMapping("/{page}/{limit}")
    public Result listSku(@PathVariable Integer page, @PathVariable Integer limit, SkuEsQueryVo skuEsQueryVo){
        //pageable中page最小值为0，意为第一页
        Pageable pageable = PageRequest.of(page-1,limit);
        Page<SkuEs> pageModel = skuService.search(pageable,skuEsQueryVo);
        return Result.ok(pageModel);
    }

    //更新商品热度
    @GetMapping("/inner/incrHotScore/{skuId}")
    public Boolean incrHotScore(@PathVariable Long skuId){
        skuService.incrHotScore(skuId);
        return true;
    }

}
