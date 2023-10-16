package com.example.schoolmanagement.Repository;


import com.example.schoolmanagement.Model.Semester;
import com.example.schoolmanagement.Model.StudentTranscript;
import com.example.schoolmanagement.Model.Subject;
import com.example.schoolmanagement.Model.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public interface StudentTranscriptRepository extends JpaRepository<StudentTranscript, Long> {
    List<StudentTranscript> findAllByStudent(Users student);
    @Query("SELECT st FROM StudentTranscript st " +
            "WHERE st.student = :student " +
            "AND st.semester = :semester " +
            "AND st.subject = :subject")
    StudentTranscript findByStudentSemesterAndSubject(@Param("student") Users student,
                                                      @Param("semester") Semester semester,
                                                      @Param("subject") Subject subject);

}
