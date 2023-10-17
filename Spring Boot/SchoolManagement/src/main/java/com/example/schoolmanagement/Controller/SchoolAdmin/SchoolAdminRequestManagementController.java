package com.example.schoolmanagement.Controller.SchoolAdmin;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
@AllArgsConstructor

public class SchoolAdminRequestManagementController {

    @GetMapping
    public String viewAllRequest(HttpSession session, Model model){

    }

}
