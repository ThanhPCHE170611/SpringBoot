package com.example.myproject.StudentHome;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class StudentHomeController {

    @GetMapping(path = "/studenthome")
    public String viewHomePage(HttpSession session){
        return "studenthome";
    }

    @GetMapping(path = "/logout")
    public String logOut(HttpSession session){
        session.invalidate();
        return "redirect:/login";
    }
}
