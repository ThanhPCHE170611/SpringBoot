package com.example.myproject.AcountSetting;

import com.example.myproject.Student.Student;
import com.example.myproject.Student.StudentRepository;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;

@Service
@AllArgsConstructor
public class AccountSettingService {
    private final StudentRepository studentRepository;
    private final PasswordEncoder passwordEncoder;
    @Transactional
    public void updateStudent(String name, String password, String gender, HttpSession session) {
        Student student = (Student) session.getAttribute("user");
        Student studentInDB = studentRepository.findById(student.getId()).get();
        studentInDB.setName(name);
        String encodePassword = passwordEncoder.encode(password);
        studentInDB.setPassword(encodePassword);
        boolean bGender;
        if(gender.equals("male")) bGender = true; else bGender = false;
        studentInDB.setGender(bGender);
        session.setAttribute("user", studentInDB);
    }
}
