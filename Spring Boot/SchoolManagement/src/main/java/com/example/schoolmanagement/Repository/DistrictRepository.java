package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.City;
import com.example.schoolmanagement.Model.District;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public interface DistrictRepository extends JpaRepository<District, Long> {

    @Cacheable(value = "districtCache")
    @Query(value = "SELECT * FROM district d WHERE d.status = :status", nativeQuery = true)
    List<District> findAll(@Param("status") String status);

    @Query("Select d from District d where d.city = :city and d.status = :status")
    List<District> findByCity(City city, String status);
}
