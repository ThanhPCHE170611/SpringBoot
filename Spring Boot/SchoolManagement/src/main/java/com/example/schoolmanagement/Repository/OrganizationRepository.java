package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.Class;
import com.example.schoolmanagement.Model.Organization;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public interface OrganizationRepository extends JpaRepository<Organization, Long> {
    Optional<Organization> findOrganizationByaClass(Class aclass);

    Optional<Organization> findOrganizationByclassorganization(Organization classorganization);
    List<Organization> findAllByschoolcode(String schoolCode);
}
