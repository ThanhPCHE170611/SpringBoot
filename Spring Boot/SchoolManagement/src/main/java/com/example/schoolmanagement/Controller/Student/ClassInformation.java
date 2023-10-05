package com.example.schoolmanagement.Controller.Student;

import com.example.schoolmanagement.Model.Class;
import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@AllArgsConstructor
public class ClassInformation {

    private final UserRepository userRepository;

    @GetMapping(path = "/student/classinformation")
    public String viewInformation(HttpSession session, Model model){
        Users user = (Users) session.getAttribute("user");
        Class aClass = user.getStudentclass();
        model.addAttribute("class", aClass);
        List<Users> students = userRepository.findAllBystudentclass(aClass);
        model.addAttribute("students", students);
        return "classinformation";
    }
}
