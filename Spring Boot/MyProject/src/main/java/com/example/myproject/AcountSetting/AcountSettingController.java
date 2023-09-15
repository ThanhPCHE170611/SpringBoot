package com.example.myproject.AcountSetting;

import com.example.myproject.Student.Student;
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
    @GetMapping(path = "/student/accountsetting")
    public String AccountSetting(HttpSession session, Model model){
        //Get the student in the session
        Student student = (Student) session.getAttribute("user");
        model.addAttribute("name", student.getName());
        if(student.isGender()) model.addAttribute("gender", "male");
        else model.addAttribute("gender", "female");
        return "accountsetting";
    }
    @PostMapping(path = "/student/accountsetting")
    public String UpdateInformation(@RequestParam String name, @RequestParam String oldpassword,
                                  @RequestParam String password, @RequestParam String gender, Model model, HttpSession session){
        String error = validateData(name, oldpassword, password,  gender, model, session);
        if(!error.isEmpty()){
            model.addAttribute("error", error);
            System.out.println("have error");
            return "accountsetting";
        } else {
            Student student = (Student) session.getAttribute("user");
            if(passwordEncoder.matches(password, student.getPassword())){
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
        if (!passwordEncoder.matches(oldpassword, student.getPassword())) {
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
}
