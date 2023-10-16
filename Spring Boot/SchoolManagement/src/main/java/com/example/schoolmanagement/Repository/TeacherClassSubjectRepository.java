package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.TeacherClassSubject;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public interface TeacherClassSubjectRepository extends JpaRepository<TeacherClassSubject, Long> {
    List<TeacherClassSubject> findAllByTeacher_RollNumber(String rollNumber);
}
