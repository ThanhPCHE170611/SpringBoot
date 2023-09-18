package com.example.myproject.ViewStudent;

import com.example.myproject.Student.Student;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@AllArgsConstructor
public class ViewStudentController {
    private final ViewStudentService viewStudentService;
    @GetMapping(path = "/teacherhome/viewclass/viewstudent")
    public String viewStudent(@RequestParam(name = "classid") long classid, HttpSession session, Model model){
        List<Student> students = viewStudentService.viewStudents(classid);
        model.addAttribute("students", students);
        return "viewstudent";
    }
}
