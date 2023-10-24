package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.Class;
import com.example.schoolmanagement.Model.Organization;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public interface OrganizationRepository extends JpaRepository<Organization, Long> {
//    Optional<Organization> findOrganizationByaClass(Class aclass);

    Optional<Organization> findOrganizationByclassOrganization(Organization classorganization);
    List<Organization> findAllByschoolcode(String schoolCode);

    @Query("SELECT o FROM Organization o WHERE o.status = :status and o.schoolcode != null")
    List<Organization> findAll(String status);

    @Query("SELECT o FROM Organization o WHERE o.wardorganization.ward.id = :id and o.status = :status")
    List<Organization> findAllByWardAndStatus(@Param("id") Long id, @Param("status") String status);
}
