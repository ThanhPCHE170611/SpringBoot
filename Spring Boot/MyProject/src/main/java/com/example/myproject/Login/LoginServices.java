package com.example.myproject.Login;

import com.example.myproject.Admin.Admin;
import com.example.myproject.Admin.AdminService;
import com.example.myproject.Student.Student;
import com.example.myproject.Student.StudentService;
import com.example.myproject.Teacher.Teacher;
import com.example.myproject.Teacher.TeacherService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;
import java.util.Optional;

@Service
@AllArgsConstructor
public class LoginServices {
    private final AdminService adminService;
    private final StudentService studentService;
    private final TeacherService teacherService;
    public String login(String username, String password, Model model, HttpSession session) {
        Student student = studentService.login(username,password, model, session);
        if(student!= null){
            return "Student";
        } else {
            Teacher teacher = teacherService.login(username,password,model,session);
            if(teacher != null){
                return "Teacher";
            } else {
                Admin admin = adminService.login(username,password,model,session);
                if(admin != null){
                    return "Admin";
                }
            }
        }
        return "LoginFailed";
    }
}
