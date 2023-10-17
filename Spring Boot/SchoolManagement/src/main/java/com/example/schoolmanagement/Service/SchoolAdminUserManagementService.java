package com.example.schoolmanagement.Service;

import com.example.schoolmanagement.Model.ChangeClass;
import com.example.schoolmanagement.Model.Organization;
import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class SchoolAdminUserManagementService {

    private final UserRepository userRepository;
    public Page<Users> getUsers(Users schoolAdmin, int page, int pageSize) {
        Organization currentOrganization = schoolAdmin.getSchoolOrganization();
        Pageable pageable =  PageRequest.of(page, pageSize);
        return userRepository.findBySchoolOrganization_Id(currentOrganization.getId(), pageable);
    }
}
