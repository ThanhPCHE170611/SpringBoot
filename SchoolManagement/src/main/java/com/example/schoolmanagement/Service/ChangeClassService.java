package com.example.schoolmanagement.Service;

import com.example.schoolmanagement.Model.ChangeClass;
import com.example.schoolmanagement.Model.Organization;
import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.ChangeClassRepository;
import com.example.schoolmanagement.Repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@AllArgsConstructor
public class ChangeClassService {

    private final ChangeClassRepository changeClassRepository;
    private final UserRepository userRepository;

    public Page<ChangeClass> getRequests(Users schoolAdmin, int page, int pageSize) {
        Organization currentOrganization = schoolAdmin.getSchoolOrganization();
        Pageable pageable =  PageRequest.of(page, pageSize);
        return changeClassRepository.findByOldClass_ClassOrganization_Id(currentOrganization.getId(), pageable);
    }

    @Transactional
    public void updateRequest(ChangeClass request) {
        ChangeClass requestInDb = changeClassRepository.findById(request.getId()).get();
        requestInDb.setReason(request.getReason());
    }

    @Transactional
    public void updateStudentClass(Users student) {
        Users studentInDb = userRepository.findById(student.getRollNumber()).get();
        studentInDb.setStudentclass(student.getStudentclass());
    }
}
