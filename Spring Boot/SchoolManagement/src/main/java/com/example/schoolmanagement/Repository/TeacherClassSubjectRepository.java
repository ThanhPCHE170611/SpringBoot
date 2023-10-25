package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.TeacherClassSubject;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public interface TeacherClassSubjectRepository extends JpaRepository<TeacherClassSubject, Long> {
    List<TeacherClassSubject> findAllByTeacher_RollNumberAndStatus(String rollNumber, String status);

    @Query(value = "select tcs from TeacherClassSubject tcs where tcs.classTeaching.Id = :classid and tcs.subjectTeaching.subjectcode = :subjectcode and tcs.status = :status")
    List<TeacherClassSubject> findAllByClassTeachingAndSubjectTeachingAndStatus(@Param("classid") Long classid ,@Param("subjectcode") String subjectcode,@Param("status") String status);

    @Query("Select tcs from TeacherClassSubject tcs where tcs.subjectTeaching.subjectcode = :subjectcode")
    List<TeacherClassSubject> findAllBySubject_subjectcode( @Param("subjectcode") String subjectcode);
}
