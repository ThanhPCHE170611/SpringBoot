package com.example.schoolmanagement.Controller;

import com.example.schoolmanagement.DTO.LoginDTO;
import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.UserRepository;
import com.example.schoolmanagement.Service.AuthService;
import com.example.schoolmanagement.Utilities.GoogleLoginHandle;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.*;

@RestController
@AllArgsConstructor
@RequestMapping("/api/auth")
public class Auth {
    //private final GoogleLoginHandle googleLoginHandle;
    private final AuthService authService;
    //private final PasswordEncoder passwordEncoder;
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginDTO loginDTO) {
        String token = authService.login(loginDTO);

        return ResponseEntity.ok(
                Map.of(
                        "accessToken", token,
                        "tokenType", "Bearer"
                )
        );
    }

    @PostMapping("/selectrole")
    public ResponseEntity<?> selectRole(@RequestParam String role){
        authService.AddRoleToCurrentUser(role);
        return ResponseEntity.ok("Role selected: " + role);
    }

//    @GetMapping("/user/welcome")
//    public String roleAuthentication(Authentication authentication, Model model, HttpSession session){
//        String emailCheckLogin = googleLoginHandle.getEmailFromOAuth2Authentication(authentication);
//        String usernameCheckLogin = authentication.getName();
//        if(userRepository.findUsersByUsername(authentication.getName()).isPresent()){
//            Users user = userRepository.findUsersByUsername(usernameCheckLogin).get();
//            Calendar calendar = Calendar.getInstance();
//            calendar.setTime(user.getLastchangepassword());
//            calendar.add(Calendar.MONTH, 6);
//            Date sixMonthsAfterLastChange = calendar.getTime();
//            Date currentDate = new Date();
//            if(currentDate.after(sixMonthsAfterLastChange)){
//                model.addAttribute("user", user);
//                model.addAttribute("error", "Your password is expired, please change your password!");
//                return "userchangepassword";
//            }
//        } else if(userRepository.findUsersByEmail(emailCheckLogin).isPresent()){
//            Users user = userRepository.findUsersByEmail(emailCheckLogin).get();
//            Calendar calendar = Calendar.getInstance();
//            calendar.setTime(user.getLastchangepassword());
//            calendar.add(Calendar.MONTH, 6);
//            Date sixMonthsAfterLastChange = calendar.getTime();
//            Date currentDate = new Date();
//            if(currentDate.after(sixMonthsAfterLastChange)){
//                model.addAttribute("user", user);
//                model.addAttribute("error", "Your password is expired, please change your password!");
//                return "userchangepassword";
//            }
//        }
//        Collection<GrantedAuthority> roles = new ArrayList<>();
//        //remove trash information
//        for (GrantedAuthority grantedAuthority : authentication.getAuthorities()){
//            if(grantedAuthority.toString().contains("ROLE")){
//                roles.add(grantedAuthority);
//            }
//        }
//        //handle for just one student role -> go directly student homepage
//        if(roles.size() == 1 && roles.toString().contains("ROLE_STUDENT")){
//            if(authentication.getName() == null){
//                String email = googleLoginHandle.getEmailFromOAuth2Authentication(authentication);
//                session.setAttribute("user", userRepository.findUsersByEmail(email).get());
//            } else {
//                String username = authentication.getName();
//                session.setAttribute("user", userRepository.findUsersByUsername(username).get());
//            }
//            return "redirect:/student/homepage";
//        }
//        //handle for user role -> search email -> get user -> get role and accept homepage
//        for (GrantedAuthority grantedAuthority : authentication.getAuthorities()){
//            if(grantedAuthority.toString().contains("ROLE_USER")){
//                String email = googleLoginHandle.getEmailFromOAuth2Authentication(authentication);
//                System.out.println("Email: " + email);
//                Optional<Users> user = userRepository.findUsersByEmail(email);
//                if(user.isPresent() && user.get().getStatus().equals("active")){
//                    System.out.println("user is found!");
//                    roles.removeAll(roles);
//                    roles = (Collection<GrantedAuthority>) user.get().getAuthorities();
//                }
//                else {
//                    return "redirect:/auth/login?error=true";
//                }
//            }
//        }
//        if(authentication.getName() == null){
//            String email = googleLoginHandle.getEmailFromOAuth2Authentication(authentication);
//            session.setAttribute("user", userRepository.findUsersByEmail(email).get());
//        }
//        else if(authentication.getPrincipal().toString().contains("email")){
//            String email = googleLoginHandle.getEmailFromOAuth2Authentication(authentication);
//            session.setAttribute("user", userRepository.findUsersByEmail(email).get());
//        }
//        else {
//            String username = authentication.getName();
//            session.setAttribute("user", userRepository.findUsersByUsername(username).get());
//        }
//        model.addAttribute("roles", roles);
//        return "selectrole";
//    }
//    @GetMapping(path = "/logout")
//    public String logOut(HttpSession session){
//        session.invalidate();
//        return "redirect:/auth/login";
//    }
//
//    @PostMapping("/auth/resetpassword")
//    public String updatePassword(@RequestParam String password,
//                                 @RequestParam String username){
//        Users user = userRepository.findUsersByUsername(username).get();
//        user.setPassword(passwordEncoder.encode(password));
//        Date currentDate = new Date();
//        user.setLastchangepassword(currentDate);
//        authService.updatePassword(user);
//        return "redirect:/auth/login";
//    }

}
