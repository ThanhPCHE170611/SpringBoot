package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.Gender;
import com.example.schoolmanagement.Model.Role;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public interface RoleRepository extends JpaRepository<Role, Long> {
    Optional<Role> findRoleByrolename(String name);
    @Cacheable(value = "roleCache")
    List<Role> findAll();
}
