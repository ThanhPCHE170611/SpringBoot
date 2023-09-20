package com.example.myproject.AdminHome;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
@AllArgsConstructor
public class AdminHomeController {
    @GetMapping(path = "/adminhome")
    public String viewAdminHome(HttpSession session, Model model){
        model.addAttribute("error", null);
        return "adminhome";
    }
}
