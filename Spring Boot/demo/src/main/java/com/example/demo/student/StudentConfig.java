package com.example.demo.student;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.LocalDate;
import java.time.Month;
import java.util.List;

@Configuration
public class StudentConfig {
    @Bean
    CommandLineRunner commandLineRunner(StudentRepository repository){
        return args ->  {
            Student student1 = new Student("student1",  LocalDate.of(2020, Month.NOVEMBER, 9), "student1@gmail.com");
            Student student2 = new Student("student2",  LocalDate.of(2020, Month.NOVEMBER, 9), "student2@gmail.com");
            repository.saveAll(List.of(student1, student2));
        };
    }
}
