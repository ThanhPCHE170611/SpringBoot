package com.example.myproject.Class;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Repository
@Transactional
public interface ClassRepository extends JpaRepository<Class, Long> {
    @Override
    Optional<Class> findById(Long aLong);
}
