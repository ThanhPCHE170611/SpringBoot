package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.Mark;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.awt.print.Pageable;
import java.util.List;

@Repository
@Transactional
public interface MarkRepository extends JpaRepository<Mark, Long> {
    List<Mark> findTop6ByOrderByIdDesc();
}
