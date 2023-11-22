package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.Gender;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public interface GenderRepository extends JpaRepository<Gender, Long> {

    @Cacheable(value = "genderCache")
    List<Gender> findAll();

    Optional<Gender> findGenderByGender(String gender);
}
