package com.example.schoolmanagement.Controller.SchoolAdmin;

import com.example.schoolmanagement.Model.Ethnic;
import com.example.schoolmanagement.Model.Organization;
import com.example.schoolmanagement.Model.Subject;
import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.EthnicRepository;
import com.example.schoolmanagement.Repository.SubjectRepository;
import com.example.schoolmanagement.Repository.UserRepository;
import lombok.AllArgsConstructor;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFClientAnchor;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

@Controller
@AllArgsConstructor
@RequestMapping("/schooladmin/reportmanagement")
public class SchoolAdminReportManagementController {

    private final UserRepository userRepository;
    private final SubjectRepository subjectRepository;
    private final EthnicRepository ethnicRepository;

    @GetMapping()
    public String viewAllReportLink(HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        }
        else {
            Users schoolAdmin = (Users) session.getAttribute("user");
            Organization schoolOrganization = schoolAdmin.getSchoolOrganization();
            List<Subject> subjects = subjectRepository.findAllByStatusAndOrOrganizations("active", schoolOrganization);
            List<Ethnic> ethnics = ethnicRepository.findAll();
            model.addAttribute("ethnics", ethnics);
            model.addAttribute("subjects", subjects);
            return "schooladminreportmanagement";
        }
    }




}
