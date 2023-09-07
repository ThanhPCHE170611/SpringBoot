package com.example.thymeleafproject.Register;

import com.example.thymeleafproject.appuser.AppUser;
import com.example.thymeleafproject.appuser.AppUserService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@AllArgsConstructor
public class RegisterController {
    private final AppUserService appUserService;

    @GetMapping(path = "/register")
    public String register(){
        return "register";
    }
    @PostMapping(path = "/register")
    public String register(@RequestParam String name, @RequestParam String username, @RequestParam String password,
                           @RequestParam String repassword, Model model){
        AppUser appUser = appUserService.register(name,username, password, repassword, model);
        if(appUser == null){
            return "register";
        }
        return "login";
    }
}
