package com.example.demo.student;

import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class StudentServices {
    private final StudentRepository studentrepository;

    public StudentServices(StudentRepository studentrepository) {
        this.studentrepository = studentrepository;
    }

    public List<Student> getStudent(){
        return studentrepository.findAll();
    }

    public void addNewStudent(Student student) {
        Optional<Student> studentByEmail = studentrepository.findStudentByEmail(student.getEmail());
        if(studentByEmail.isPresent()){
            System.out.println("Email is dupplicate");
        }
        else studentrepository.save(student);
    }

    public void deleteStudent(int id) {
        if(studentrepository.existsById(id)){
            studentrepository.deleteById(id);
            System.out.println("Delete Successful!");
        } else {
            System.out.println("Cannot find by ID");
        }
    }

    @Transactional
    public void updateStudent(int id, String name, String email) {
       Student student = studentrepository.findById(id).orElseThrow(() -> new IllegalStateException("Student with id " + id + " is not exist"));
        if(name != null && name.length() > 0 && !Objects.equals(student.getName(), name)){
            student.setName(name);
        }
        if(email != null && email.length() > 0 && !Objects.equals(student.getEmail(), email)){
           Optional<Student> studentByEmail = studentrepository.findStudentByEmail(email);
           if(studentByEmail.isPresent()) throw  new IllegalStateException("Email is dupplicate");
           else student.setEmail(email);
        }
    }
}
