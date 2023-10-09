package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.Semester;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Table;

@Repository
@Transactional
public interface SemesterRepository extends JpaRepository<Semester, Long> {
    Semester findFirstByOrderByIdDesc();
}
