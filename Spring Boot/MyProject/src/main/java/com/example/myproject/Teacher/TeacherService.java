package com.example.myproject.Teacher;

import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;
import java.util.Optional;

@Service
@AllArgsConstructor
public class TeacherService {
    private TeacherRepository teacherRepository;
    private PasswordEncoder passwordEncoder;
    public Teacher login(String username, String password, Model model, HttpSession session) {
        Optional<Teacher> teacher = teacherRepository.findTeacherByUsername(username);
        if(!teacher.isPresent()) model.addAttribute("error", "1");
        else {
            if(!passwordEncoder.matches(password, teacher.get().getPassword()) && !teacher.get().getPassword().equals(password))
                model.addAttribute("error", "1");
            else {
                session.setAttribute("user", teacher.get());
                return teacher.get();
            }
        }
        return null;
    }
}
