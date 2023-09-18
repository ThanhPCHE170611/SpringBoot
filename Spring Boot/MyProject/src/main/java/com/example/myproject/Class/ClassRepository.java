package com.example.myproject.Class;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

import static org.springframework.data.jpa.domain.AbstractPersistable_.id;

@Repository
@Transactional
public interface ClassRepository extends JpaRepository<Class, Long> {
    @Override
    Optional<Class> findById(Long aLong);

    @Query("Select e from Class e where e.id != :id")
    List<Class> findAllByIdNotEqual(Long id);

    Optional<Class> findClassByClassname(String classname);
    @Query(value = "Select * from find_all_class_for_teacher(?1)", nativeQuery = true)
    List<Object[]> findAllClassForTeacher(Long teacherId);
}
