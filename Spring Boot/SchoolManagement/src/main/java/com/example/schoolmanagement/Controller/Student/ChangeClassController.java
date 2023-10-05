package com.example.schoolmanagement.Controller.Student;

import com.example.schoolmanagement.Model.ChangeClass;
import com.example.schoolmanagement.Model.Class;
import com.example.schoolmanagement.Model.Organization;
import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.ChangeClassRepository;
import com.example.schoolmanagement.Repository.OrganizationRepository;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@AllArgsConstructor

public class ChangeClassController {

    private final ChangeClassRepository changeClassRepository;
    private final OrganizationRepository organizationRepository;

    @GetMapping(path = "/student/changeclass")
    public String viewPage(HttpSession session, Model model){
        Users user = (Users) session.getAttribute("user");
        boolean sent = false;
        // check if exist request but not response yet
        List<ChangeClass> requests = changeClassRepository.findAllByStudent(user);
        for (ChangeClass request : requests){
            if(request.getStatus().equals("process")){
                sent = true;
            }
        }
        if(sent){
            model.addAttribute("error", "Your request has been sent. Go request history to view result!");
        } else {
            //show menu to select new class
            Class currentClass = user.getStudentclass();
            Organization classOrganizations = organizationRepository.findOrganizationByaClass(currentClass).get();
            //get the school code
            Organization schoolOrganization = organizationRepository.findOrganizationByclassorganization(classOrganizations).get();
            String schoolCode = schoolOrganization.getSchoolcode();
            List<Organization> classes = organizationRepository.findAllByschoolcode(schoolCode);
            //Get Other Class confirm
            for (Organization aClass : classes){
                System.out.println(aClass.getClassorganization().getAClass().getClassname());
            }
        }
        return "";
    }
}
