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
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        }
        else {
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
                } else if(request.getStatus().equals("reject") || request.getStatus().equals("accept")){
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
                Organization schoolOrganization = currentClass.getClassOrganization();
                List<Class> allClass = classRepository.findAllByclassOrganization(schoolOrganization);
                List<Class> classes = new ArrayList<>();
                //Get Other Class confirm
                //Check the amount of student in class (<50 accept ! not show)
                //not display the old class of student
                for (Class aClass : allClass){
                    if(userRepository.findAllBystudentclass(aClass).size() < 50
                            && currentClass.getId() != aClass.getId()){
                        classes.add(aClass);
                    }
                }
                model.addAttribute("oldclass", currentClass);
                model.addAttribute("classes", classes);
            }
            return "studentchangeclass";
        }
    }

    @PostMapping(path = "/student/changeclass")
    public String sendRequest(@RequestParam(required = false) Long classname, HttpSession session, Model model){
        if(classname != null){
            Users user = (Users) session.getAttribute("user");
            Class olcClass = user.getStudentclass();
            Class newClass = classRepository.findById(classname).get();
            ChangeClass newRequest = new ChangeClass(user, olcClass, newClass, semesterRepository.findFirstByOrderByIdDesc());
            changeClassRepository.save(newRequest);
            model.addAttribute("error", "Your request has been sent. Go request history to view result!");
            return "studentchangeclass";
        } else {
            return "redirect:/student/changeclass";
        }
    }

    @GetMapping(path = "/student/classchangehistory")
    public String viewHistory(HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        }
        else {
            Users student = (Users) session.getAttribute("user");
            List<ChangeClass> requests = changeClassRepository.findTop10ByStudentOrderByIdDesc(student);
            model.addAttribute("requests", requests);
            return "studentchangeclasshistory";
        }
    }
}
