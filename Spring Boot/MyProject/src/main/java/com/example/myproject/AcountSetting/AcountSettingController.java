package com.example.myproject.AcountSetting;

import com.example.myproject.Admin.Admin;
import com.example.myproject.Student.Student;
import com.example.myproject.Teacher.Teacher;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@AllArgsConstructor
public class AcountSettingController {
    private final PasswordEncoder passwordEncoder;
    private AccountSettingService accountSettingService;
    @GetMapping(path = "/studenthome/accountsetting")
    public String AccountSetting(HttpSession session, Model model){
        //Get the student in the session
        Student student = (Student) session.getAttribute("user");
        model.addAttribute("name", student.getName());
        if(student.isGender()) model.addAttribute("gender", "male");
        else model.addAttribute("gender", "female");
        return "accountsetting";
    }
    @PostMapping(path = "/studenthome/accountsetting")
    public String UpdateInformation(@RequestParam String name, @RequestParam String oldpassword,
                                  @RequestParam String password, @RequestParam String gender, Model model, HttpSession session){
        String error = validateData(name, oldpassword, password,  gender, model, session);
        if(!error.isEmpty()){
            model.addAttribute("error", error);
            System.out.println("have error");
            return "accountsetting";
        } else {
            Student student = (Student) session.getAttribute("user");
            if(passwordEncoder.matches(password, student.getPassword()) || password.equals(student.getPassword())){
                accountSettingService.updateStudent(name, password, gender, session);
                model.addAttribute("error", "Update information successful!");
                return "studenthome";
            }
            else {
                accountSettingService.updateStudent(name, password, gender, session);
                return "login";
            }
        }
    }
    @GetMapping(path = "/teacherhome/accountsetting")
    public String teacherAccountSetting(HttpSession session, Model model){
        //Get the student in the session
        Teacher teacher = (Teacher) session.getAttribute("user");
        model.addAttribute("name", teacher.getName());
        if(teacher.isGender()) model.addAttribute("gender", "male");
        else model.addAttribute("gender", "female");
        return "teacheraccountsetting";
    }

    private String validateData(String name, String oldpassword, String password, String gender, Model model, HttpSession session) {
        Student student = (Student) session.getAttribute("user");
        // Check name
        if (name == null || !name.matches("^[A-Z][a-zA-Z]{3,}$")) {
            model.addAttribute("name", name);
            model.addAttribute("oldpassword", oldpassword);
            model.addAttribute("password", password);
            model.addAttribute("gender", gender);
            return "Name must start with an uppercase letter and be at least 4 characters long and dont have any number and speical chars.";
        }
        // Check oldpassword and newPassword
        if (!passwordEncoder.matches(oldpassword, student.getPassword()) && !oldpassword.equals(student.getPassword())) {
            model.addAttribute("name", name);
            model.addAttribute("oldpassword", oldpassword);
            model.addAttribute("password", password);
            model.addAttribute("gender", gender);
            return "Old Password isn't correct";
        }

        if (password.length() < 4) {
            model.addAttribute("name", name);
            model.addAttribute("oldpassword", oldpassword);
            model.addAttribute("password", password);
            model.addAttribute("gender", gender);
            return "New Password must be at least 4 characters long.";
        }

        if (!password.matches("^[a-zA-Z0-9]+$")) {
            model.addAttribute("name", name);
            model.addAttribute("oldpassword", oldpassword);
            model.addAttribute("password", password);
            model.addAttribute("gender", gender);
            return "New Password must contain only letters and numbers.";
        }
        return ""; // No validation errors
    }
    private String teacherValidateData(String name, String oldpassword, String password, String gender, Model model, HttpSession session) {
        Teacher teacher = (Teacher) session.getAttribute("user");
        // Check name
        if (name == null || !name.matches("^[A-Z][a-zA-Z]{3,}$")) {
            model.addAttribute("name", name);
            model.addAttribute("oldpassword", oldpassword);
            model.addAttribute("password", password);
            model.addAttribute("gender", gender);
            return "Name must start with an uppercase letter and be at least 4 characters long and dont have any number and speical chars.";
        }
        // Check oldpassword and newPassword
        if (!passwordEncoder.matches(oldpassword, teacher.getPassword()) && !oldpassword.equals(teacher.getPassword())) {
            model.addAttribute("name", name);
            model.addAttribute("oldpassword", oldpassword);
            model.addAttribute("password", password);
            model.addAttribute("gender", gender);
            return "Old Password isn't correct";
        }

        if (password.length() < 4) {
            model.addAttribute("name", name);
            model.addAttribute("oldpassword", oldpassword);
            model.addAttribute("password", password);
            model.addAttribute("gender", gender);
            return "New Password must be at least 4 characters long.";
        }

        if (!password.matches("^[a-zA-Z0-9]+$")) {
            model.addAttribute("name", name);
            model.addAttribute("oldpassword", oldpassword);
            model.addAttribute("password", password);
            model.addAttribute("gender", gender);
            return "New Password must contain only letters and numbers.";
        }
        return ""; // No validation errors
    }

    @PostMapping(path = "/teacherhome/accountsetting")
    public String teacherUpdateInformation(@RequestParam String name, @RequestParam String oldpassword,
                                    @RequestParam String password, @RequestParam String gender, Model model, HttpSession session) {
        String error = teacherValidateData(name, oldpassword, password, gender, model, session);
        if (!error.isEmpty()) {
            model.addAttribute("error", error);
            return "teacheraccountsetting";
        } else {
            Teacher teacher = (Teacher) session.getAttribute("user");
            if (passwordEncoder.matches(password, teacher.getPassword()) || password.equals(teacher.getPassword())) {
                accountSettingService.updateTeacher(name, password, gender, session);
                model.addAttribute("error", "Update information successful!");
                return "teacherhome";
            } else {
                accountSettingService.updateTeacher(name, password, gender, session);
                return "login";
            }
        }
    }
    @GetMapping(path = "/adminhome/accountsetting")
    public String adminAccountSetting(HttpSession session, Model model){
        //Get the student in the session
        Admin admin = (Admin) session.getAttribute("user");
        model.addAttribute("name", admin.getName());
        return "adminaccountsetting";
    }

    @PostMapping(path = "adminhome/accountsetting")
    public String adminUpdateInformation(@RequestParam String name, @RequestParam String oldpassword,
                                         @RequestParam String password, HttpSession session, Model model){
        String error = this.adminValidateData(name, oldpassword, password, model, session);
        if(!error.isEmpty()){
            model.addAttribute("error", error);
            return "adminaccountsetting";
        } else {
            Admin admin = (Admin) session.getAttribute("user");
            if (passwordEncoder.matches(password, admin.getPassword()) || password.equals(admin.getPassword())) {
                accountSettingService.updateAdmin(name, password, session);
                model.addAttribute("error", "Update information successful!");
                return "adminhome";
            } else {
                accountSettingService.updateAdmin(name, password,  session);
                return "login";
            }
        }
    }
    private String adminValidateData(String name, String oldpassword, String password, Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        // Check name
        if (name == null || !name.matches("^[A-Z][a-zA-Z]{3,}$")) {
            model.addAttribute("name", name);
            model.addAttribute("oldpassword", oldpassword);
            model.addAttribute("password", password);
            return "Name must start with an uppercase letter and be at least 4 characters long and dont have any number and speical chars.";
        }
        // Check oldpassword and newPassword
        if (!passwordEncoder.matches(oldpassword, admin.getPassword()) && !oldpassword.equals(admin.getPassword())) {
            model.addAttribute("name", name);
            model.addAttribute("oldpassword", oldpassword);
            model.addAttribute("password", password);
            return "Old Password isn't correct";
        }

        if (password.length() < 4) {
            model.addAttribute("name", name);
            model.addAttribute("oldpassword", oldpassword);
            model.addAttribute("password", password);
            return "New Password must be at least 4 characters long.";
        }

        if (!password.matches("^[a-zA-Z0-9]+$")) {
            model.addAttribute("name", name);
            model.addAttribute("oldpassword", oldpassword);
            model.addAttribute("password", password);
            return "New Password must contain only letters and numbers.";
        }
        return ""; // No validation errors
    }
}
