package com.example.schoolmanagement.Service;

import com.example.schoolmanagement.Model.Subject;
import com.example.schoolmanagement.Repository.SubjectRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@AllArgsConstructor
public class SchoolAdminSubjectManagementService {

    private final SubjectRepository subjectRepository;


    @Transactional
    public void addSubject(Subject newSubject) {
        subjectRepository.save(newSubject);
    }
}
