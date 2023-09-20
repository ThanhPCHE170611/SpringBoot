package com.example.myproject.TeacherManager;

import com.example.myproject.Class.Class;
import com.example.myproject.Subject.Subject;
import com.example.myproject.SubjectClass.SubjectClass;
import com.example.myproject.Teacher.Teacher;
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
public class TeacherManagerController {
    private final TeacherManagerService teacherManagerService;
    @GetMapping(path = "/adminhome/assignteacher")
    public String viewListTeacher(HttpSession session, Model model){
        List<Teacher> teachers = teacherManagerService.viewListTeacher();
        model.addAttribute("teachers", teachers);
        return "teachermanager";
    }
    @GetMapping(path = "/adminhome/assignteacher/choosesubject")
    public String viewListSubject(@RequestParam long teacherid, HttpSession session, Model model){
        List<Subject> subjects = teacherManagerService.viewListSubject(teacherid);
        model.addAttribute("subjects", subjects);
        model.addAttribute("teacherid", teacherid);
        return "choosesubject";
    }
    @GetMapping(path = "/adminhome/assignteacher/chooseclass")
    public String viewListClass(@RequestParam long teacherid, @RequestParam long subjectid, HttpSession session, Model model){
        List<Class> classes = new ArrayList<>();
        List<SubjectClass> scList = teacherManagerService.findBySubjectId(subjectid);
        List<Class> temp = teacherManagerService.findAllClass();
        for (Class aClass : temp){
            boolean check = true;
            for (int i = 0; i < scList.size(); i++){
                if(aClass.getId() == scList.get(i).getClassEntity().getId()){
                    check = false;
                }
            }
            if(check){
                classes.add(aClass);
            }
        }
        model.addAttribute("teacherid", teacherid);
        model.addAttribute("subjectid", subjectid);
        model.addAttribute("classes", classes);
        return "chooseclass";
    }
    @GetMapping(path = "/adminhome/assignteacher/assign")
    public String assignTeacherToClass(@RequestParam long teacherid, @RequestParam long subjectid, @RequestParam long classid,HttpSession session, Model model){
        teacherManagerService.createNewTeacherSubject(teacherid, subjectid);
        //create new subjectclass condition: the class don't have full 11 subjets teacher
        //and dont have any teacher had teach that subject
        teacherManagerService.createNewSubjectClass(subjectid, classid);
        model.addAttribute("error", "Assign teacher successful!");
        return "adminhome";
    }

    @GetMapping(path = "/adminhome/assignteacher/addteacher")
    public String createTeacher(){
        return "addteacher";
    }

    @PostMapping(path = "/adminhome/assginteacher/addteacher")
    public String addTeacher(@RequestParam String name, @RequestParam String username ,@RequestParam String password, @RequestParam String confirmpassword, @RequestParam String gender, Model model){
        String error = teacherManagerService.teacherValidateData(name,username, password, confirmpassword, gender, model);
        if(error != null){
            model.addAttribute("error", error);
            return "addteacher";
        } else {
            System.out.println("no error");
            boolean bGender;
            if(gender.equals("male")) bGender = true; else bGender= false;
            Teacher teacher = new Teacher(name, username,password, bGender);
            teacherManagerService.saveTeacher(teacher);
            model.addAttribute("error", "Add Teacher successful!");
            return "adminhome";
        }
    }
}
