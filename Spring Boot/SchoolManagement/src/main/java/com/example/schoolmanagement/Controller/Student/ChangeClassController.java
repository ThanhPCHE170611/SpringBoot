package com.example.schoolmanagement.Controller.Student;

import com.example.schoolmanagement.Model.*;
import com.example.schoolmanagement.Model.Class;
import com.example.schoolmanagement.Repository.*;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@AllArgsConstructor

public class ChangeClassController {

    private final ChangeClassRepository changeClassRepository;
    private final OrganizationRepository organizationRepository;
    private final UserRepository userRepository;
    private final ClassRepository classRepository;
    private final SemesterRepository semesterRepository;

    @GetMapping(path = "/student/changeclass")
    public String viewPage(HttpSession session, Model model){
        Users user = (Users) session.getAttribute("user");
        boolean sent = false;
        boolean hasReject = false;
        List<Semester> semesterList = new ArrayList<>();
        // check if exist request but not response yet
        //if the request has been reject then student can't sent more in that semester
        List<ChangeClass> requests = changeClassRepository.findAllByStudent(user);
        for (ChangeClass request : requests){
            if(request.getStatus().equals("process")){
                sent = true;
            } else if(request.getStatus().equals("reject")){
                semesterList.add(request.getSemester());
            }
        }
        Semester currentSemester = semesterRepository.findFirstByOrderByIdDesc();
        System.out.println("current semester: " + currentSemester.getSemester() + currentSemester.getYear());
        for (Semester semester : semesterList){
            if(semester.getId() == currentSemester.getId()){
                model.addAttribute("error", "You must sent 1 request per 1 semester!");
                return "studentchangeclass";
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
            List<Organization> allClass = organizationRepository.findAllByschoolcode(schoolCode);
            List<Organization> classes = new ArrayList<>();
            //Get Other Class confirm
            //Check the amount of student in class (<50 accept ! not show)
            //not display the old class of student
            for (Organization aClass : allClass){
                if(userRepository.findAllBystudentclass(aClass.getClassorganization().getAClass()).size() < 50
                && currentClass.getId() != aClass.getClassorganization().getAClass().getId() && aClass.getClassorganization().getStatus().equals("active")){
                    classes.add(aClass);
                }
            }
            model.addAttribute("oldclass", currentClass);
            model.addAttribute("classes", classes);
        }
        return "studentchangeclass";
    }

    @PostMapping(path = "/student/changeclass")
    public String sendRequest(@RequestParam(required = false) String classname, HttpSession session, Model model){
        if(classname != null){
            Users user = (Users) session.getAttribute("user");
            Class olcClass = user.getStudentclass();
            Class newClass = organizationRepository.findById(Long.parseLong(classname)).get().getClassorganization().getAClass();
            ChangeClass newRequest = new ChangeClass(user, olcClass, newClass);
            changeClassRepository.save(newRequest);
            model.addAttribute("error", "Your request has been sent. Go request history to view result!");
            return "studentchangeclass";
        } else {
            return "redirect:/student/changeclass";
        }
    }

    @GetMapping(path = "/student/classchangehistory")
    public String viewHistory(HttpSession session, Model model){
        Users student = (Users) session.getAttribute("user");
        List<ChangeClass> requests = changeClassRepository.findTop10ByStudentOrderByIdDesc(student);
        model.addAttribute("requests", requests);
        return "studentchangeclasshistory";
    }
}
