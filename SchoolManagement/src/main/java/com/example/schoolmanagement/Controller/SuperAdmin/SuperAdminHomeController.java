package com.example.schoolmanagement.Controller.SuperAdmin;

import com.example.schoolmanagement.Model.Users;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
@AllArgsConstructor
public class SuperAdminHomeController {
    @GetMapping(path = "/superadmin/homepage")
    public String viewHomePage(HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        }
        else {
            Users user =(Users) session.getAttribute("user");
            model.addAttribute("error", "Welcome back, Super Admin " + user.getFullname());
            return "superadminhome";
        }
    }
}
