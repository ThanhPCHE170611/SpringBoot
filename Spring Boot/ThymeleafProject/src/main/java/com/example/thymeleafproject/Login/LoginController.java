package com.example.thymeleafproject.Login;

import com.example.thymeleafproject.appuser.AppUser;
import com.example.thymeleafproject.appuser.AppUserService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;

@Controller
@AllArgsConstructor
public class LoginController {
    private final AppUserService appUserService;
    @GetMapping(path = "/login")
    public String login(){
        return "login";
    }
    @PostMapping(path="/login")
    public String login(@RequestParam String username, @RequestParam String password, Model model, HttpSession session){
        AppUser appUser = appUserService.login(username, password, model, session);
        if(appUser == null){
            return "login";
        }
        else {
            session.setAttribute("user", appUser);
            return "redirect:/home";
        }
    }
}
