package com.example.thymeleafproject.Home;

import com.example.thymeleafproject.appuser.AppUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class HomeController {
    @GetMapping(path = "/home")
    public String loginCheck(HttpSession session){
        if(session.getAttribute("user") == null){
            return "login";
        } else {
            return "home";
        }
    }
    @GetMapping(path = "/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/login";
    }
}
