package com.example.myproject.Register;

import com.example.myproject.Class.Class;
import com.example.myproject.Class.ClassService;
import com.example.myproject.Student.Student;
import com.example.myproject.Student.StudentRepository;
import com.example.myproject.Student.StudentService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@AllArgsConstructor
@Transactional
public class RegisterService {
    private ClassService classService;
    private StudentService studentService;

    public void register(String name, String username, String password, String gender){
        boolean boolGender;
        if(gender.equals("male")){
            boolGender = true;
        } else boolGender = false;
        Student student = new Student(name, username, password, boolGender, classService.getClassById());
        studentService.register(student);
    }

}
