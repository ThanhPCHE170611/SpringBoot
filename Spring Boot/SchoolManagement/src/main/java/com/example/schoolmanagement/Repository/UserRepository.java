package com.example.schoolmanagement.Repository;


import com.example.schoolmanagement.Model.ChangeClass;
import com.example.schoolmanagement.Model.Class;
import com.example.schoolmanagement.Model.Organization;
import com.example.schoolmanagement.Model.Users;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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

    User findByUsername(String username);

    List<Users> findAllBystudentclass(Class studentclass);

    List<Users> findAllByschoolOrganization(Organization schoolOrganization);

    @Query("SELECT u FROM Users u WHERE u.schoolOrganization.Id = :organizationId")
    Page<Users> findBySchoolOrganization_Id(@Param("organizationId") Long organizationId, Pageable pageable);
}
