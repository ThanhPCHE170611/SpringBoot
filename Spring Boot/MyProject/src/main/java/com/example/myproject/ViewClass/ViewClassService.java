package com.example.myproject.ViewClass;

import com.example.myproject.Class.Class;
import com.example.myproject.Class.ClassRepository;
import com.example.myproject.Student.StudentRepository;
import com.example.myproject.Subject.Subject;
import com.example.myproject.Teacher.TeacherRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

@Service
@AllArgsConstructor
public class ViewClassService {
    private final ClassRepository classRepository;
    private final TeacherRepository teacherRepository;
    private final StudentRepository studentRepository;

    public List<Class> viewListClass(Long teacherid) {
        List<Object[]> objects = classRepository.findAllClassForTeacher(teacherid);
        List<Class> classes = new ArrayList<>();
        for (Object[] row : objects){
            BigInteger bigint = (BigInteger) row[0];
            Class aClass = new Class(bigint.longValue(), (String) row[1]);
            classes.add(aClass);
        }
        return classes;
    }
}
