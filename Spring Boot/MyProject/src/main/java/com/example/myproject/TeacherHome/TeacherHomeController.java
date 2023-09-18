package com.example.myproject.TeacherHome;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class TeacherHomeController {

    @GetMapping(path = "/teacherhome")
    public String viewHomePage(HttpSession session){
        return "teacherhome";
    }
}
