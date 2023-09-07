package com.example.thymeleafproject.appuser;

import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;
import java.util.Optional;

@Service
@AllArgsConstructor
public class AppUserService {
    private AppUserRepository appUserRepository;
    private PasswordEncoder passwordEncoder;
    public AppUser login(String username, String password, Model model, HttpSession session) {
        Optional<AppUser> appUser = appUserRepository.findAppUserByUsername(username);
        if(!appUser.isPresent()) model.addAttribute("error", "1");
        else {
            if(!passwordEncoder.matches(password, appUser.get().getPassword()))
                model.addAttribute("error", "1");
            else {
                return appUser.get();
            }
        }
        return null;
    }

    @Transactional
    public AppUser register(String name, String username, String password, String repassword, Model model) {
        Optional<AppUser> appUser = appUserRepository.findAppUserByUsername(username);
        if(appUser.isPresent()) model.addAttribute("error", "Username is dupplicate!");
        else {
           if(!password.equals(repassword))  model.addAttribute("error", "Password and Confirm Password not match!");
            else {
                String passwordEncode = passwordEncoder.encode(password);
                AppUser appUserNew = new AppUser(name, username, passwordEncode);
                appUserRepository.save(appUserNew);
                return appUserNew;
           }
        }
        return null;
    }
}
