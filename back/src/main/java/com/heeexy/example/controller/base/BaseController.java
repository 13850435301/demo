package com.heeexy.example.controller.base;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class BaseController {
    @Value("${shiro.salt}")
    public String salt;
}
