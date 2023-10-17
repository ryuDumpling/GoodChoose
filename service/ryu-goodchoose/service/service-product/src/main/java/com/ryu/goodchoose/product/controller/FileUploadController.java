package com.ryu.goodchoose.product.controller;

import com.ryu.goodchoose.common.result.Result;
import com.ryu.goodchoose.product.service.FileUploadService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author ryuDumpling
 * @version 2023/10/6 0:44
 */
@Api(tags = "文件上传接口")
@RestController
@RequestMapping("admin/product")
//@CrossOrigin //跨域请求
public class FileUploadController {

    @Autowired
    private FileUploadService fileUploadService;

    //文件上传
    @ApiOperation("图片上传")
    @PostMapping("fileUpload")
    public Result fileUpload(MultipartFile file) throws Exception{
        return Result.ok(fileUploadService.fileUpload(file));
    }
}
