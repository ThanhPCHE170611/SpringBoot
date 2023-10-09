package com.example.schoolmanagement.Repository;


import com.example.schoolmanagement.Model.StudentTranscript;
import com.example.schoolmanagement.Model.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public interface StudentTranscriptRepository extends JpaRepository<StudentTranscript, Long> {
    List<StudentTranscript> findAllByStudent(Users student);
}
