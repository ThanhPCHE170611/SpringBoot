package com.example.schoolmanagement.Controller.SchoolAdmin;

import com.example.schoolmanagement.Model.Class;
import com.example.schoolmanagement.Model.Organization;
import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.ClassRepository;
import com.example.schoolmanagement.Repository.UserRepository;
import com.example.schoolmanagement.Service.SchoolAdminClassManagementService;
import com.sun.net.httpserver.HttpsServer;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@AllArgsConstructor
public class SchoolAdminClassManagementController {

    private final UserRepository userRepository;
    private final ClassRepository classRepository;
    private final SchoolAdminClassManagementService schoolAdminClassManagementService;

    @GetMapping(path = "/schooladmin/classmanagement")
    public String viewAllClass(HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        }
        else {
            Users admin = (Users) session.getAttribute("user");
            Organization schoolOrganization = admin.getSchoolOrganization();
            System.out.println(schoolOrganization.getId());
            List<Class> classes = classRepository.findAllByclassOrganization(schoolOrganization);
            model.addAttribute("classes", classes);
            return "schooladminclassmanagement";
        }
    }
    @GetMapping(path = "/schooladmin/classmanagement/addclass")
    public String addClass(HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        }
        else {
            Users admin = (Users) session.getAttribute("user");
            Organization schoolOrganization = admin.getSchoolOrganization();
            model.addAttribute("school", schoolOrganization);
            return "schooladminaddclass";
        }
    }

    @PostMapping(path = "/schooladmin/classmanagement/addclass")
    public String addNewClass(@RequestParam String classname, HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        }
        else {
            if(!classname.matches("^[a-zA-Z0-9 ]*$")){
                model.addAttribute("error", "Class Name is not valid!");
                return addClass(session, model);
            }
            Users admin = (Users) session.getAttribute("user");
            Organization schoolOrganization = admin.getSchoolOrganization();
            //check if the classname is dupplicate:
            List<Class> classes = classRepository.findAllByclassOrganization(schoolOrganization);

            for(Class aClass : classes){
                if(aClass.getClassname().equalsIgnoreCase(classname)){
                    model.addAttribute("error", "Class Name is dupplicate!");
                    return addClass(session, model);
                }
            }
            Class newClass = new Class(classname, schoolOrganization);
            classRepository.save(newClass);
            model.addAttribute("error", "Add New Class Successful!");
            return "redirect:/schooladmin/classmanagement/";
        }
    }

    @GetMapping(path = "/schooladmin/classmanagement/updateclass/{classid}")
    public String getUpdateClassInfor(@PathVariable Long classid, HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        } else {
            Users admin = (Users) session.getAttribute("user");
            Organization schoolOrganization = admin.getSchoolOrganization();
            Class oldClass = classRepository.findById(classid).get();
            model.addAttribute("class", oldClass);
            model.addAttribute("school", schoolOrganization);
            return "schooladminupdateclass";
        }
    }

    @PostMapping(path = "/schooladmin/classmanagement/updateclass")
    public String updateClass(@RequestParam Long classid,  @RequestParam String classname, HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        } else {
            if(!classname.matches("^[a-zA-Z0-9 ]*$")){
                model.addAttribute("error", "Class Name is not valid!");
                return getUpdateClassInfor(classid, session, model);
            }
            // no modify
            if(classname.equalsIgnoreCase(classRepository.findById(classid).get().getClassname())){
                return viewAllClass(session, model);
            } else
            //check if dupplicate:
            {
                Users admin = (Users) session.getAttribute("user");
                Organization schoolOrganization = admin.getSchoolOrganization();
                List<Class> classes = classRepository.findAllByclassOrganization(schoolOrganization);
                for(Class aClass : classes){
                    if(aClass.getClassname().equalsIgnoreCase(classname)){
                        model.addAttribute("error", "Class Name is dupplicate!");
                        return getUpdateClassInfor(classid, session, model);
                    }
                }
                // no duplicate -> update:
                Class updateClass = new Class(classid, classname, schoolOrganization);
                schoolAdminClassManagementService.updateClass(updateClass);
                model.addAttribute("error", "Update Successful!");
                return viewAllClass(session, model);
            }

        }
    }

    @GetMapping(path = "/schooladmin/classmanagement/deleteclass/{classid}")
    public String deleteClass(@PathVariable Long classid, HttpSession session, Model model){
        schoolAdminClassManagementService.deleteClass(classid);
        return viewAllClass(session, model);
    }

}
