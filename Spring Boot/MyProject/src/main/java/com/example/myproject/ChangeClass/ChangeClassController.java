package com.example.myproject.ChangeClass;

import com.example.myproject.Class.Class;
import com.example.myproject.Student.Student;
import com.example.myproject.Subject.Subject;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@AllArgsConstructor
public class ChangeClassController {
    private final ChangeClassService classService;
    @GetMapping(path = "/studenthome/changeclass")
    public String ViewPage(HttpSession session, Model model){
        List<Class> classesSpecific = new ArrayList<>();
        //check if there are any request privious:
        Student student = (Student) session.getAttribute("user");
        if(classService.hasRequest(student.getId())){
            model.addAttribute("error", "Student must wait previous response!");
        } else {
            //check class specific:
            //1. <= 49 student
            List<Class> classes = classService.listClassEnoughSlot(student.getStudentClass());
            if(classes.isEmpty()){
                model.addAttribute("error", "Full of slot! at all class");
            } else {
                //2. subject like previous subject
                //Check in the list of class that the class include subject similar
                Class oldClass = student.getStudentClass();
                List<Subject> oldClassSubject = classService.getListOfSubjectInClass(oldClass.getId());
                boolean found = false;
                for (Class checkNewClass : classes){
                        List<Subject> newClassSubject = classService.getListOfSubjectInClass(checkNewClass.getId());
                        if(newClassSubject.size() == oldClassSubject.size()){
                            List<Subject> commonSubjects = oldClassSubject.stream()
                                    .filter(subject -> newClassSubject.stream().anyMatch(s -> s.getId() == subject.getId()))
                                    .collect(Collectors.toList());
                            if(commonSubjects.size() == oldClassSubject.size()){
                                classesSpecific.add(checkNewClass);
                                found = true;
                            }
                        }
                }
                if(!found){
                    model.addAttribute("error", "No Class Specific found!");
                }
                else {
                    model.addAttribute("classes", classesSpecific);
                    model.addAttribute("oldclass", oldClass.getClassname());
                }

            }
        }
        return "changeclass";
    }

    @PostMapping(path = "/studenthome/changeclass")
    public String sendRequest(@RequestParam String studentid, @RequestParam String classname, HttpSession session, Model model){
            Long studentidL = Long.parseLong(studentid);
            Long newclassidL = Long.parseLong(classname);
            Student student = (Student) session.getAttribute("user");
            Long oldclassid = student.getStudentClass().getId();
            classService.AddNewRequest(studentidL, oldclassid, newclassidL);
            model.addAttribute("error", "Request has been sent!");
        return "studenthome";
    }

}
