package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.District;
import com.example.schoolmanagement.Model.Ward;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public interface WardRepository extends JpaRepository<Ward, Long> {

    @Cacheable(value = "wardCache")
    @Query(value = "SELECT * FROM ward w WHERE w.status = :status", nativeQuery = true)
    List<Ward> findAll(@Param("status") String status);


    @Query("Select w from Ward w where w.district = :district and w.status = :status")
    List<Ward> findByDistrict(District district, String status);
}
