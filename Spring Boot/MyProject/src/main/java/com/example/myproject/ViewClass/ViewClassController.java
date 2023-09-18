package com.example.myproject.ViewClass;

import com.example.myproject.Class.Class;
import com.example.myproject.Teacher.Teacher;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@AllArgsConstructor
public class ViewClassController {
    private final ViewClassService viewClassService;
    @GetMapping(path = "teacherhome/viewclass")
    public String viewClass(HttpSession session, Model model){
        Teacher teacher = (Teacher) session.getAttribute("user");
        List<Class> classes = viewClassService.viewListClass(teacher.getId());
        model.addAttribute("classes", classes);
        return "viewclass";
    }
}
