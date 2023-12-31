package com.example.schoolmanagement.Repository;


import com.example.schoolmanagement.Model.Class;
import com.example.schoolmanagement.Model.Organization;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public interface ClassRepository extends JpaRepository<Class, Long> {
    List<Class> findAllByclassOrganization(Organization schoolOrganization);
}
