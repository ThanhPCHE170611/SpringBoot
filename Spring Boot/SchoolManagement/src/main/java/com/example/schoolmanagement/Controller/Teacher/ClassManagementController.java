package com.example.schoolmanagement.Controller.Teacher;

import com.example.schoolmanagement.Model.Class;
import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@AllArgsConstructor
public class ClassManagementController {

    private final UserRepository userRepository;

    @GetMapping(path = "/teacher/classmanagement")
    public String getAllStudent(Model model, HttpSession session){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        }
        else {
            Users teacher = (Users) session.getAttribute("user");
            //Get the class that the teacher teach:
            Class currentClass = teacher.getTeacherclass();
            //Get List of all student in the class -> information:
            List<Users> allStudent = userRepository.findAllBystudentclass(currentClass);
            List<Users> students =  new ArrayList<>();
            for (Users student : allStudent){
                if(student.getStatus().equals("active"))
                    students.add(student);
            }
            model.addAttribute("students", students);
            model.addAttribute("aclass", currentClass);
            return "classmanagement";
        }
    }
}
