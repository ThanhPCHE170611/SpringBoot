package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.City;
import lombok.AllArgsConstructor;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public interface CityRepository extends JpaRepository<City, Long> {

    @Cacheable(value = "cityCache")
    @Query(value = "SELECT c.id, c.cityname, c.status FROM city c WHERE c.status = :status", nativeQuery = true)
    List<City> findAll(@Param("status") String status);

}
