package com.example.schoolmanagement.Utilities;

import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.UserRepository;
import com.example.schoolmanagement.Service.AuthService;
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
    private final AuthService authService;
    @GetMapping("")
    public String sendOTPAndLoadPage(Authentication authentication, HttpSession session, Model model){
        if(authentication == null){
            return "redirect:/auth/login";
        } else {
            String usernameCheckLogin = authentication.getName();
            String email = userRepository.findEmailByUsername(usernameCheckLogin);
            // generate OTP
            int otp = otpService.generateOTP(usernameCheckLogin);
            // send OTP to email
            sendEmailService.sendEmail(email, "OTP - School Management System", "Your OTP is: " + otp + ". Please do not share this OTP with anyone!");
            // load page
            model.addAttribute("email", email);
            // create an count number:
            if(session.getAttribute("count") == null){
                session.setAttribute("count", 0);
            }
            return "otp";
        }
    }

    @GetMapping("/validate")
    public @ResponseBody String validateOTP(@RequestParam("otp") String otp, Authentication authentication, HttpSession session, Model model){
        if(authentication == null){
            return "redirect:/auth/login";
        } else {
            String usernameCheckLogin = authentication.getName();
            int cacheOTP = otpService.getOTP(usernameCheckLogin);
            int count = (int) session.getAttribute("count");
            String cacheOTPStr = String.valueOf(cacheOTP);
            System.out.println("Count Number:" + count);
            if(count < 5) {
                if (otp.equalsIgnoreCase(cacheOTPStr)) {
                    otpService.clearOTP(usernameCheckLogin);
                    session.setAttribute("count", 0);
                    return ("VALID");
                } else if (!otp.equalsIgnoreCase(cacheOTPStr)) {
                    count++;
                    session.setAttribute("count", count);
                    return ("INVALID");
                }
            } else {
                // update user status to block
                authService.updateUserStatus(usernameCheckLogin);
                session.invalidate();
                return "You have entered wrong OTP too many times, your account will be block for secure! Contact with your admin to unlock your account!";
            }
            return "";
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
