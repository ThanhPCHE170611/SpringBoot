package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.Semester;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Table;
import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public interface SemesterRepository extends JpaRepository<Semester, Long> {
    Semester findFirstByOrderByIdDesc();

    @Query("SELECT s FROM Semester s WHERE s.Year = :year")
    List<Semester> findAllByyear(@Param("year") String year);
}
