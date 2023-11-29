package com.example.schoolmanagement.Controller.SchoolAdmin;

import com.example.schoolmanagement.Model.Organization;
import com.example.schoolmanagement.Model.Subject;
import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.SubjectRepository;
import com.example.schoolmanagement.Service.SchoolAdminSubjectManagementService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@AllArgsConstructor
public class SchoolAdminSubjectManagementController {

    private final SubjectRepository subjectRepository;
    private final SchoolAdminSubjectManagementService schoolAdminSubjectManagementService;

    @GetMapping(path = "/schooladmin/subjectmanagement")
    public String viewAllSubject(HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        }
        else {
            Users schoolAdmin = (Users) session.getAttribute("user");
            Organization schoolOrganization = schoolAdmin.getSchoolOrganization();
            List<Subject> subjects = subjectRepository.findAllByorganizations(schoolOrganization);
            model.addAttribute("subjects", subjects);
            return "schooladminsubjectmanagement";
        }
    }

    @GetMapping(path = "/schooladmin/subjectmanagement/addsubject")
    public String viewFormAddSubject(HttpSession session, Model model){
        Users schoolAdmin = (Users) session.getAttribute("user");
        Organization schoolOrganization = schoolAdmin.getSchoolOrganization();
        return "schooladminaddsubject";
    }

    @PostMapping(path = "/schooladmin/subjectmanagement/addsubject")
    public String addSubject(HttpSession session, Model model, @RequestParam String subjectcode, @RequestParam String subjectname){
        if(isValidSubjectCode(subjectcode)){
            if(isValidSubjectName(subjectname)){
                Users schoolAdmin = (Users) session.getAttribute("user");
                Organization schoolOrganization = schoolAdmin.getSchoolOrganization();
                List<Subject> subjects = subjectRepository.findAllByorganizations(schoolOrganization);
                if(isDupplicateSubjectCode(subjectcode, subjects)){
                    model.addAttribute("error", "Subject Code dupplicate!");
                    return viewFormAddSubject(session, model);
                } else {
                    Subject newSubject = new Subject(subjectcode, subjectname, schoolOrganization);
                    schoolAdminSubjectManagementService.addSubject(newSubject);
                    model.addAttribute("error", "Add Subject successful!!");
                    return viewAllSubject(session, model);
                }
            } else {
                model.addAttribute("error", "Subject Name invalid!");
                return viewFormAddSubject(session, model);
            }
        } else {
            model.addAttribute("error", "Subject Code invalid!");
            return viewFormAddSubject(session, model);
        }
    }

    private boolean isValidSubjectCode(String subjectcode) {
        return subjectcode.matches("^[A-Za-z0-9]+$");
    }

    private boolean isValidSubjectName(String subjectname) {
        return subjectname.matches("^[\\p{L}\\s]+$");
    }
    private boolean isDupplicateSubjectCode(String subjectcode, List<Subject> subjects){
        for (Subject subject : subjects){
            if(subject.getSubjectcode().equalsIgnoreCase(subjectcode)){
                return true;
            }
        }
        return false;
    }

}
