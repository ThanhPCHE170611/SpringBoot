package com.example.demo.student;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path="api/v1/student")
public class StudentController {

    private final StudentServices studentservices;

    @Autowired
    public StudentController(StudentServices studentservices) {
        this.studentservices = studentservices;
    }

    @GetMapping
    public List<Student> getStudent(){
        return studentservices.getStudent();
    }
    @PostMapping
    public void registerNewStudent(@RequestBody Student student){
        studentservices.addNewStudent(student);
    }
    @DeleteMapping(path = "{studentId}")
    public void deleteStudent(@PathVariable("studentId") int id){
        studentservices.deleteStudent(id);
    }
    @PutMapping(path = "{studentId}")
    public void updateStudent(@PathVariable("studentId") int id,
                              @RequestParam(required = false) String name,
                              @RequestParam(required = false) String email){
        studentservices.updateStudent(id, name, email);
    }
}
