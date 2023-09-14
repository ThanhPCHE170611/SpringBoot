package com.example.myproject.Class;

import com.example.myproject.Student.StudentRepository;
import com.example.myproject.Student.StudentService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
@Service
@AllArgsConstructor
public class ClassService {
    private ClassRepository classRepository;
    private StudentRepository studentRepository;
    @Transactional
    public Class getClassById(){
        long totalClass = (long) classRepository.findAll().size();
       for (long i = 1; i<= totalClass; i++){
           int studentInClass = studentRepository.findAllByStudentClassId(i).size();
           System.out.println(studentInClass);
           if(studentInClass < 50){
               return classRepository.findById(i).get();
           }
       }
       Class newClass = new Class("Class " + Character.toString('A') + totalClass);
       classRepository.save(newClass);
       return newClass;
    }
}
