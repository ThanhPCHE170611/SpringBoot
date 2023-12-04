package com.example.schoolmanagement.Utilities;

import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.UserRepository;
import lombok.AllArgsConstructor;
import org.apache.catalina.User;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@AllArgsConstructor
@RequestMapping(path = "/otpvalidate")
public class OTPHandle {

    private final UserRepository userRepository;
    @GetMapping("")
    public String openPage(Authentication authentication, HttpSession session, Model model){
        String usernameCheckLogin = authentication.getName();
        String email = userRepository.findUsersByUsername(usernameCheckLogin).get().getEmail();
        model.addAttribute("email", email);
        return "otp";
    }


}
