package com.ryu.goodchoose;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

/**
 * @author ryuDumpling
 * @version 2023/10/3 20:39
 */
@SpringBootApplication
@EnableDiscoveryClient
@EnableFeignClients//远程调用
public class ServiceSysApplication {
    public static void main(String[] args) {
        SpringApplication.run(ServiceSysApplication.class, args);
    }
}
