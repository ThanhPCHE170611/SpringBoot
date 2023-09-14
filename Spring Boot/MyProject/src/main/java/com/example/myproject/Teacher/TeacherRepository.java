package com.example.myproject.Teacher;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Repository
@Transactional
public interface TeacherRepository extends JpaRepository<Teacher, Long> {
    Optional<Teacher> findTeacherByUsername(String username);
}
