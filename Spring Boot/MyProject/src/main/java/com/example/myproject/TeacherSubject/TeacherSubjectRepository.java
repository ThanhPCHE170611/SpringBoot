package com.example.myproject.TeacherSubject;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public interface TeacherSubjectRepository extends JpaRepository<TeacherSubject, Long> {
    @Query(value = "Select * from getteacherswith1subjects()", nativeQuery = true)
    List<Object[]> findAllTeacherCanAssignSubject();

    @Query(value = "Select * from getothersubjects(?1)", nativeQuery = true)
    List<Object[]> getOtherSubjets(Long teacherId);
}
