package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.Gender;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public interface GenderRepository extends JpaRepository<Gender, Long> {

    @Cacheable(value = "genderCache")
    List<Gender> findAll();
}
