package com.example.schoolmanagement.Controller.SchoolAdmin;

import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Service.SchoolAdminSubjectManagementService;
import com.example.schoolmanagement.Service.SchoolAdminUserManagementService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@AllArgsConstructor
public class SchoolAdminUserManagementController {
    private final SchoolAdminUserManagementService schoolAdminUserManagementService;


    @GetMapping(path = "/schooladmin/usermanagement")
    public String viewAllUsers(HttpSession session, Model model, @RequestParam(value = "page", defaultValue = "0") int page,
                               @RequestParam(value = "size", defaultValue = "25") int pageSize){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        }
        else {
            Users schoolAdmin = (Users) session.getAttribute("user");
            Page<Users> users = schoolAdminUserManagementService.getUsers(schoolAdmin, page, pageSize);
                    model.addAttribute("users", users);
            model.addAttribute("page", page);
            return "schooladminusermanagement";
        }
    }

    @GetMapping(path = "/schooladmin/usermanagement/adduser")
    public String viewFormAddUser(){
        return "";
    }
}
