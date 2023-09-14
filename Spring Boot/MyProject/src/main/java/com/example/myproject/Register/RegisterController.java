package com.example.myproject.Register;

import com.example.myproject.Class.Class;
import com.example.myproject.Student.Student;
import com.example.myproject.Student.StudentService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@AllArgsConstructor
public class RegisterController {
    private RegisterService registerService;
    private StudentService studentService;

    @GetMapping(path = "/register")
    public String register(Model model){
        return "register";
    }
    @PostMapping(path = "/register")
    public String register(@RequestParam String name, @RequestParam String username, @RequestParam String password, @RequestParam String re_password,@RequestParam(name = "gender", required = false) String gender, Model model){
       String error = validateData(name, username, password, re_password, gender, model);
       if(!error.isEmpty()){
           model.addAttribute("error", error);
           return "register";
       } else {
           registerService.register(name, username, password, gender);
           return "login";
       }
    }

    private String validateData(String name, String username, String password, String rePassword, String gender, Model model) {
        // Check name
        if (name == null || !name.matches("^[A-Z][a-zA-Z]{3,}$")) {
            model.addAttribute("name", name);
            model.addAttribute("username", username);
            model.addAttribute("password", password);
            model.addAttribute("rePassword", rePassword);
            model.addAttribute("gender", gender);
            return "Name must start with an uppercase letter and be at least 4 characters long and dont have any number and speical chars.";
        }

        // Check username
        if (username == null || !username.matches("^[a-zA-Z0-9]{4,}$")) {
            model.addAttribute("name", name);
            model.addAttribute("username", username);
            model.addAttribute("password", password);
            model.addAttribute("rePassword", rePassword);
            model.addAttribute("gender", gender);
            return "Username must be at least 4 characters long and contain only letters and numbers.";
        }
        if(studentService.isUsernameDupplicate(username)){
            model.addAttribute("name", name);
            model.addAttribute("username", username);
            model.addAttribute("password", password);
            model.addAttribute("rePassword", rePassword);
            model.addAttribute("gender", gender);
            return "Username is exist!";
        }

        // Check password and rePassword
        if (password == null || rePassword == null || !password.equals(rePassword)) {
            model.addAttribute("name", name);
            model.addAttribute("username", username);
            model.addAttribute("password", password);
            model.addAttribute("rePassword", rePassword);
            model.addAttribute("gender", gender);
            return "Password and Confirm Password must match.";
        }

        if (password.length() < 4) {
            model.addAttribute("name", name);
            model.addAttribute("username", username);
            model.addAttribute("password", password);
            model.addAttribute("rePassword", rePassword);
            model.addAttribute("gender", gender);
            return "Password must be at least 4 characters long.";
        }

        if (!password.matches("^[a-zA-Z0-9]+$")) {
            model.addAttribute("name", name);
            model.addAttribute("username", username);
            model.addAttribute("password", password);
            model.addAttribute("rePassword", rePassword);
            model.addAttribute("gender", gender);
            return "Password must contain only letters and numbers.";
        }

        // Check gender
        if (gender == null) {
            model.addAttribute("name", name);
            model.addAttribute("username", username);
            model.addAttribute("password", password);
            model.addAttribute("rePassword", rePassword);
            model.addAttribute("gender", gender);
            return "Please select a gender.";
        }
        return ""; // No validation errors
    }

}
