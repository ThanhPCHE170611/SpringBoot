package com.example.schoolmanagement.Controller.SchoolAdmin;

import com.example.schoolmanagement.Model.Users;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
@AllArgsConstructor
public class SchoolAdminHomeController {
    @GetMapping(path = "/schooladmin/homepage")
    public String viewHomePage(HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        }
        else {
            Users user =(Users) session.getAttribute("user");
            model.addAttribute("error", "Welcome back, school admin " + user.getFullname());
            return "schooladminhome";
        }
    }
}
