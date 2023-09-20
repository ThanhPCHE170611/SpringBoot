package com.example.myproject.AcountSetting;

import com.example.myproject.Admin.Admin;
import com.example.myproject.Admin.AdminRepository;
import com.example.myproject.Student.Student;
import com.example.myproject.Student.StudentRepository;
import com.example.myproject.Teacher.Teacher;
import com.example.myproject.Teacher.TeacherRepository;
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
    private final TeacherRepository teacherRepository;
    private final AdminRepository adminRepository;
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
    @Transactional
    public void updateTeacher(String name, String password, String gender, HttpSession session){
        Teacher teacher = (Teacher) session.getAttribute("user");
        Teacher teacherInDB = teacherRepository.findById(teacher.getId()).get();
        teacherInDB.setName(name);
        String encodePassword = passwordEncoder.encode(password);
        teacherInDB.setPassword(encodePassword);
        boolean bGender;
        if(gender.equals("male")) bGender = true; else bGender = false;
        teacherInDB.setGender(bGender);
        session.setAttribute("user", teacherInDB);
    }

    @Transactional
    public void updateAdmin(String name, String password, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        Admin adminInDB = adminRepository.findById(admin.getId()).get();
        adminInDB.setName(name);
        String encodePassword = passwordEncoder.encode(password);
        adminInDB.setPassword(encodePassword);
        session.setAttribute("user", adminInDB);
    }
}
