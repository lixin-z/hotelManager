package cn.java.controller;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = {"cn.java.controller", "cn.java.service.impl"})
@MapperScan(basePackages = {"cn.java.mapper"})
public class StartApplication {
    // 程序开始的地方
    public static void main(String[] args) {
        SpringApplication.run(StartApplication.class, args);
    }
}