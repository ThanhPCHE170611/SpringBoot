package com.example.schoolmanagement.Controller.SuperAdmin;

import com.example.schoolmanagement.Model.Ethnic;
import com.example.schoolmanagement.Model.Subject;
import com.example.schoolmanagement.Repository.EthnicRepository;
import com.example.schoolmanagement.Repository.SubjectRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping(path = "/superadmin/reportmanagement")
@AllArgsConstructor
public class SuperAdminReportController {

    private final SubjectRepository subjectRepository;
    private final EthnicRepository ethnicRepository;

    @GetMapping()
    public String viewPage(HttpSession session, Model model){
        // check if user is logged in
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }
        else {
            List<Subject> subjects = subjectRepository.findAllByStatus("active");
            List<Ethnic> ethnics = ethnicRepository.findAll();
            model.addAttribute("ethnics", ethnics);
            model.addAttribute("subjects", subjects);
            return "superadminreportmanagement";
        }
    }

}
