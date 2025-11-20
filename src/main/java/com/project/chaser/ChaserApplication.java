package com.project.chaser;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.project.chaser.mapper")  // Mapper 패키지
public class ChaserApplication {

	public static void main(String[] args) {
		SpringApplication.run(ChaserApplication.class, args);
	}

}
// 접속시 localhost:8089/main