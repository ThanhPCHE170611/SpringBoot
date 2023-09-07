package com.example.thymeleafproject.Login;

import com.example.thymeleafproject.appuser.AppUserService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

@Service
@AllArgsConstructor
public class LoginServices {
    private final AppUserService appUserService;

}
