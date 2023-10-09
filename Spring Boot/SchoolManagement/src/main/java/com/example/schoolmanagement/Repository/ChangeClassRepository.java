package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.ChangeClass;
import com.example.schoolmanagement.Model.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public interface ChangeClassRepository extends JpaRepository<ChangeClass, Integer> {

    List<ChangeClass> findAllByStudent(Users student);

    List<ChangeClass> findTop10ByStudentOrderByIdDesc(Users student);

}
