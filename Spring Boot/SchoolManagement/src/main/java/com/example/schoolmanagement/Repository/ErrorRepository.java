package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.Error;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Repository
public interface ErrorRepository extends JpaRepository<Error, Long> {

}
