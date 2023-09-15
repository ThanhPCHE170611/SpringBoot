package com.example.myproject.ClassChangeRequest;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Repository
@Transactional
public interface ClassChangeRequestRepository extends JpaRepository<ClassChangeRequest, Long> {
    Optional<ClassChangeRequest> findClassChangeRequestByStudentId(Long studentid);
}
