package com.springboot.springfinal.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        //사용자 홈 디렉토리 밑에 'diary_uploads' 폴더를 이미지 저장소로 사용
        String path = "file:" + System.getProperty("user.home") + "/diary_uploads/";
        
        //uploads/파일명.jpg 로 접속하면 위 폴더에서 파일을 찾도록 연결
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations(path);
    }
}