package com.example.schoolmanagement.Utilities;

import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.UserRepository;
import com.sun.net.httpserver.Authenticator;
import lombok.AllArgsConstructor;
import org.apache.catalina.User;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
@AllArgsConstructor
@RequestMapping(path = "/otpvalidate")
public class OTPHandle {
    private final OTPService otpService;
    private final UserRepository userRepository;
    private final SendEmailService sendEmailService;
    @GetMapping("")
    public String sendOTPAndLoadPage(Authentication authentication, HttpSession session, Model model){
        String usernameCheckLogin = authentication.getName();
        String email = userRepository.findEmailByUsername(usernameCheckLogin);
        // generate OTP
        int otp = otpService.generateOTP(usernameCheckLogin);
        // send OTP to email
        sendEmailService.sendEmail(email, "OTP - School Management System", "Your OTP is: " + otp + ". Please do not share this OTP with anyone!");
        // load page
        model.addAttribute("email", email);
        return "otp";
    }

    @GetMapping("/validate")
    public @ResponseBody String validateOTP(@RequestParam("otp") String otp, Authentication authentication, HttpSession session, Model model){
        String usernameCheckLogin = authentication.getName();
        int cacheOTP = otpService.getOTP(usernameCheckLogin);
        String cacheOTPStr = String.valueOf(cacheOTP);
        if(otp.equalsIgnoreCase(cacheOTPStr)){
            otpService.clearOTP(usernameCheckLogin);
            return ("Entered Otp is valid");
        } else {
            return ("Entered Otp is NOT valid. Please Retry!");
        }
    }

    @GetMapping("/resend")
    public @ResponseBody String resendOTP(Authentication authentication, HttpSession session, Model model){
        String usernameCheckLogin = authentication.getName();
        String email = userRepository.findEmailByUsername(usernameCheckLogin);
        // generate OTP
        int otp = otpService.generateOTP(usernameCheckLogin);
        // send OTP to email
        sendEmailService.sendEmail(email, "OTP - School Management System", "Your OTP is: " + otp + ". Please do not share this OTP with anyone!");
        return "Resend OTP successfully!";
    }


}
