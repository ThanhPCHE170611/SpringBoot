package com.example.myproject.Admin;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Repository
@Transactional
public interface AdminRepository extends JpaRepository<Admin, Long> {
    Optional<Admin> findAdminByUsername(String username);
}
