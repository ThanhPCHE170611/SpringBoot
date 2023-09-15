package com.example.myproject.SubjectClass;

import lombok.AllArgsConstructor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public interface SubjectClassRepository extends JpaRepository<SubjectClass, Long> {
    @Query(value = "Select * from find_all_subject_in_class(?1)", nativeQuery = true)
    List<Object[]> findAllSubjectsInClass(Long classId);
}
