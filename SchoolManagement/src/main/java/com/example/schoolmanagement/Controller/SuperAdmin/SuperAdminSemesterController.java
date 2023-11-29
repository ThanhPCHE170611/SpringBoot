package com.example.schoolmanagement.Controller.SuperAdmin;

import com.example.schoolmanagement.Model.Semester;
import com.example.schoolmanagement.Repository.SemesterRepository;
import com.example.schoolmanagement.Service.SuperAdminSemesterService;
import com.example.schoolmanagement.Service.SuperAdminSubjectManagementService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/superadmin/semestermanagement")
@AllArgsConstructor
public class SuperAdminSemesterController {

    private final SemesterRepository semesterRepository;
    private final SuperAdminSemesterService superAdminSemesterService;

    @GetMapping()
    public String viewPage(HttpSession session, Model model, @RequestParam(value = "page", defaultValue = "0") int page,
                           @RequestParam(value = "size", defaultValue = "5") int pageSize){
        //validate session
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        } else {
            Page<Semester> semesters = semesterRepository.findAll(PageRequest.of(page, pageSize));
            model.addAttribute("semesters", semesters);
            return "superadminsemestermanagement";
        }
    }

    @GetMapping("/addsemester")
    public String addSemester(HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        } else {
            Date date = new Date();
            String year = "Năm " + (date.getYear() + 1900);
            List<Semester> allSemesterofYear = semesterRepository.findAllByyear(year);
            // not have any semester in this year yet
            if(allSemesterofYear == null){
                String semestername = "Học kỳ 1";
                Semester semester = new Semester(semestername, year);
                superAdminSemesterService.createSemester(semester);
                model.addAttribute("error", "Create semester successfully!");
                return viewPage(session, model, 0, 5);
            }
            // already have 1 semester in this year
            else if(allSemesterofYear.size() == 1){
                String semestername = "Học kỳ 2";
                Semester semester = new Semester(semestername, year);
                superAdminSemesterService.createSemester(semester);
                model.addAttribute("error", "Create semester successfully!");
                return viewPage(session, model, 0, 5);
            }
            // full 2 semester in this year
            else if(allSemesterofYear.size() == 2){
                model.addAttribute("error", "This year already have 2 semester!");
                return viewPage(session, model, 0, 5);
            }
        }
        return viewPage(session, model, 0, 5);
    }


}
