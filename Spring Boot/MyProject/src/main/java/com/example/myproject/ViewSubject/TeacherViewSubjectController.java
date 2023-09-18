package com.example.myproject.ViewSubject;

import com.example.myproject.Subject.Subject;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@AllArgsConstructor
public class TeacherViewSubjectController {
    private final TeacherViewSubjectService teacherViewSubjectService;
    @GetMapping(path = "teacherhome/viewclass/viewsubject")
    public String viewSubject(@RequestParam(name = "classid") long classId, HttpSession session, Model model){
        List<Subject> subjects = teacherViewSubjectService.viewListSubject(classId);
        model.addAttribute("subjects", subjects);
        return "viewsubjectforteacher";
    }
}
