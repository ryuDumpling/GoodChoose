package com.ryu.goodchoose;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

/**
 * @author ryuDumpling
 * @version 2023/10/11 8:55
 */
@SpringBootApplication
@EnableDiscoveryClient//远程调用
@EnableFeignClients//远程调用
public class ServiceActivityApplication {

    public static void main(String[] args) {
        SpringApplication.run(ServiceActivityApplication.class, args);
    }
}
