package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.Organization;
import com.example.schoolmanagement.Model.Subject;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public interface SubjectRepository extends JpaRepository<Subject, String> {

    List<Subject> findAllByorganizations(Organization schoolOrganization);

}
