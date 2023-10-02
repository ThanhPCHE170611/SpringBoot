package com.example.schoolmanagement.Controller;

import com.example.schoolmanagement.DTO.LoginDTO;
//import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.RoleRepository;
//import com.example.schoolmanagement.Repository.UserRepository;
import com.example.schoolmanagement.Repository.UserRepository;
import com.example.schoolmanagement.Utilities.GoogleLoginHandle;
import lombok.AllArgsConstructor;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Optional;

@Controller
@AllArgsConstructor
public class Auth {
    private UserRepository userRepository;
    private GoogleLoginHandle googleLoginHandle;
    @GetMapping("/auth/login")
    public String login(@RequestParam(required = false) String error ,Model model){
        if(error!= null){
            model.addAttribute("error", "Wrong logging information!");
        }
        model.addAttribute("loginDTO", new LoginDTO());
        return "login";
    }

    @GetMapping("/user/welcome")
    public String roleAuthentication(Authentication authentication, Model model, HttpSession session){
        Collection<GrantedAuthority> roles = new ArrayList<>();
        //remove trash information
        for (GrantedAuthority grantedAuthority : authentication.getAuthorities()){
            if(grantedAuthority.toString().contains("ROLE")){
                roles.add(grantedAuthority);
            }
        }
        //handle for just one student role -> go student homepage
        if(roles.size() == 1 && roles.toString().contains("Role_Student")){
            session.setAttribute("user", authentication.getName());
            return "studenthome";
        }
        //handle for user role -> search email -> get user -> get role and accept homepage
        for (GrantedAuthority grantedAuthority : authentication.getAuthorities()){
            if(grantedAuthority.toString().contains("ROLE_USER")){
                String email = googleLoginHandle.getEmailFromOAuth2Authentication(authentication);
                System.out.println("Email: " + email);
                Optional<Users> user = userRepository.findUsersByEmail(email);
                if(user.isPresent() && user.get().getStatus().equals("active")){
                    System.out.println("user is found!");
                    roles.removeAll(roles);
                    roles = (Collection<GrantedAuthority>) user.get().getAuthorities();
                }
                else {
                    return "redirect:/auth/login?error=true";
                }
            }
        }
        session.setAttribute("user", authentication.getName());
        model.addAttribute("roles", roles);
        return "selectrole";
    }

}
