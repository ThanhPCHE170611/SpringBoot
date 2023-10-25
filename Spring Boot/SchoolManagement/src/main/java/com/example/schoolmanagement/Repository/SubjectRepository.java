package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.Organization;
import com.example.schoolmanagement.Model.Subject;
import com.example.schoolmanagement.Model.Users;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public interface SubjectRepository extends JpaRepository<Subject, String> {

    List<Subject> findAllByorganizations(Organization schoolOrganization);

    @Query("Select s from Subject s where s.status = :status And :schoolOrganization member of s.organizations")
    List<Subject> findAllByStatusAndOrOrganizations(@Param("status") String status,@Param("schoolOrganization") Organization schoolOrganization);

    Page<Subject> findAll(Specification<Subject> spec, Pageable page);
}
