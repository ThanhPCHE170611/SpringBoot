package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.Ethnic;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public interface EthnicRepository extends JpaRepository<Ethnic, Long> {

    @Cacheable(value = "ethnicCache")
    List<Ethnic> findAll();

    Optional<Ethnic> findEthnicByEthnic(@Param("ethnic") String ethnic);
}
