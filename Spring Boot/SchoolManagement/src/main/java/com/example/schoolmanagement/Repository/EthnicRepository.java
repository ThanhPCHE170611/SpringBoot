package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.Ethnic;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public interface EthnicRepository extends JpaRepository<Ethnic, Long> {

    @Cacheable(value = "ethnicCache")
    List<Ethnic> findAll();
}
