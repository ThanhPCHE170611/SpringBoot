package com.example.demo.student;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface StudentRepository extends JpaRepository<Student, Integer> {
    //Select * from Student where email = 'email'
//    @Query("Select * from Student where email = ?1")
    Optional<Student> findStudentByEmail(String email);
}
