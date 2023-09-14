package com.example.myproject.Student;

import com.example.myproject.Admin.Admin;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;
import java.util.Optional;

@Service
@AllArgsConstructor
public class StudentService {
    private StudentRepository studentRepository;
    private PasswordEncoder passwordEncoder;
    public Student login(String username, String password, Model model, HttpSession session) {
        Optional<Student> student = studentRepository.findStudentByUsername(username);
        if(!student.isPresent()) model.addAttribute("error", "1");
        else {
            if(!passwordEncoder.matches(password, student.get().getPassword()) && !student.get().getPassword().equals(password))
                model.addAttribute("error", "1");
            else {
                session.setAttribute("user", student.get());
                return student.get();
            }
        }
        return null;
    }
    @Transactional
    public void register(Student student){
        String encodePassword = passwordEncoder.encode(student.getPassword());
        student.setPassword(encodePassword);
        studentRepository.save(student);
    }
    public boolean isUsernameDupplicate(String username){
        return studentRepository.findStudentByUsername(username).isPresent();
    }
}
