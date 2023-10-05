package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.Ward;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public interface WardRepository extends JpaRepository<Ward, Long> {
}
