package com.example.myproject.Login;

import com.example.myproject.Admin.AdminRepository;
import com.example.myproject.Student.Student;
import com.example.myproject.Student.StudentRepository;
import com.example.myproject.Teacher.Teacher;
import com.example.myproject.Teacher.TeacherRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Optional;

@Controller
@AllArgsConstructor
public class LoginController {
    private final LoginServices loginServices;
    @GetMapping(path = "/login")
    public String login(){
        return "login";
    }
    @PostMapping(path="/login")
    public String login(@RequestParam String username, @RequestParam String password, Model model, HttpSession session){
        String role = loginServices.login(username, password, model, session);
        if(role.equals("LoginFailed")){
            return "login";
        } else {
            if(role.equals("Admin")){
                return "adminhome";
            } else if(role.equals("Teacher")){
                return "teacherhome";
            } else if(role.equals("Student")){
                return "studenthome";
            }
        }
        return "login";
    }
}
