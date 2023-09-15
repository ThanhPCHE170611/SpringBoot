package com.example.myproject.ViewSubject;

import com.example.myproject.Class.Class;
import com.example.myproject.Student.Student;
import com.example.myproject.Subject.Subject;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@AllArgsConstructor
public class ViewSubjectController {

    private final ViewSubjectService viewSubjectService;

    @GetMapping(path = "/studenthome/viewsubject")
    public String viewSubject(HttpSession session, Model model){
        Student student = (Student) session.getAttribute("user");
        Class studentClass = student.getStudentClass();
        List<Subject> subjects = viewSubjectService.viewListSubject(studentClass.getId());
        model.addAttribute("subjects", subjects);
        return "viewsubject";
    }
}
