package com.example.myproject.Admin;

import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;
import java.util.Optional;

@Service
@AllArgsConstructor
public class AdminService {
    private AdminRepository adminRepository;
    private PasswordEncoder passwordEncoder;
    public Admin login(String username, String password, Model model, HttpSession session) {
        Optional<Admin> admin = adminRepository.findAdminByUsername(username);
        if(!admin.isPresent()) model.addAttribute("error", "1");
        else {
            if(!passwordEncoder.matches(password, admin.get().getPassword()) && !admin.get().getPassword().equals(password))
                model.addAttribute("error", "1");
            else {
                session.setAttribute("user", admin.get());
                return admin.get();
            }
        }
        return null;
    }
}
