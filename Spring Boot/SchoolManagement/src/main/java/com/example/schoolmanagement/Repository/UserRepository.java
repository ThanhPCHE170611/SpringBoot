package com.example.schoolmanagement.Repository;


import com.example.schoolmanagement.Model.*;
import com.example.schoolmanagement.Model.Class;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public interface UserRepository extends JpaRepository<Users, String> {
    Optional<Users> findUsersByEmail(String email);

    Optional<Users> findUsersByUsername(String username);


    @Query("SELECT u FROM Users u WHERE u.studentclass.Id = :studentclassid and u.status = :status")
    List<Users> findAllBystudentclass(@Param("studentclassid") Long studentclassid, @Param("status") String status);

    @Query("SELECT u FROM Users u WHERE u.teacherclass.Id = :teacherclassid and u.status = :status")
    List<Users> findAllByteacherclass(@Param("teacherclassid") Long studentclassid, @Param("status") String status);


    @Query("SELECT u FROM Users u WHERE u.schoolOrganization.Id = :organizationId AND u.status = :status AND EXTRACT(YEAR FROM u.deactivetime) = EXTRACT(YEAR FROM CURRENT_DATE)")
    List<Users> findAllByschoolOrganizationAndStatusAndDeactiveTime(@Param("organizationId") Long organizationId, @Param("status") String status);

    @Query("Select u from Users u where u.schoolOrganization.Id = :organizationId and u.status = :status and u.ethnic.Id = :ethnicId")
    List<Users> findAllByschoolOrganizationAndStatusAndEthnic(@Param("organizationId") Long organizationId, @Param("status") String status, @Param("ethnicId") Long ethnicId);
    @Query("SELECT u FROM Users u WHERE u.schoolOrganization.Id = :organizationId")
    Page<Users> findBySchoolOrganization_Id(@Param("organizationId") Long organizationId, Pageable pageable);

    @Query("SELECT u FROM Users u WHERE u.schoolOrganization.Id = :organizationId AND u.status = :status")
    List<Users> findAllByschoolOrganizationAndStatus(@Param("organizationId") Long organizationId, @Param("status") String status);


    Page<Users> findAll(Specification<Users> spec, Pageable pageable);
    Page<Users> findAll(Pageable pageable);
}
