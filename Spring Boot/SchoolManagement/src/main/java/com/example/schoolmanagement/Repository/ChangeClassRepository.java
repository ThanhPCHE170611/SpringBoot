package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.ChangeClass;
import com.example.schoolmanagement.Model.Users;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public interface ChangeClassRepository extends JpaRepository<ChangeClass, Long> {

    List<ChangeClass> findAllByStudent(Users student);

    List<ChangeClass> findTop10ByStudentOrderByIdDesc(Users student);
    @Query("SELECT c FROM ChangeClass c WHERE c.oldClass.classOrganization.Id = :organizationId")
    Page<ChangeClass> findByOldClass_ClassOrganization_Id(@Param("organizationId") Long organizationId, Pageable pageable);
}
