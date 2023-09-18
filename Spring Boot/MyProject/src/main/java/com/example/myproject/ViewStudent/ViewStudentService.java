package com.example.myproject.ViewStudent;

import com.example.myproject.Student.Student;
import com.example.myproject.Student.StudentRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class ViewStudentService {
    private final StudentRepository studentRepository;

    public List<Student> viewStudents(long classid){
        return studentRepository.findAllByStudentClassId(classid);
    }
}
