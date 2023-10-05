package com.example.schoolmanagement.Controller.Student;

import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
@AllArgsConstructor
public class StudentHomeController {

    private final UserRepository userRepository;

    @GetMapping(path = "/student/homepage")
    public String viewHomePage(HttpSession session, Model model){
       Users user =(Users) session.getAttribute("user");
        model.addAttribute("error", "Welcome back, student " + user.getFullname());
        return "studenthome";
    }
}
