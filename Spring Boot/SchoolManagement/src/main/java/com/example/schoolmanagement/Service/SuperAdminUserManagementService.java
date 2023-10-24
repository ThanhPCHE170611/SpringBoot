package com.example.schoolmanagement.Service;

import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@AllArgsConstructor
public class SuperAdminUserManagementService {

    private final UserRepository userRepository;

    public Page<Users> getUsers(int page, int pageSize) {
        Pageable pageable =  PageRequest.of(page, pageSize);
        return userRepository.findAll(pageable);
    }

    public Page<Users> getUsersWithCriteria(Specification<Users> spec, Pageable pageable) {
        return userRepository.findAll(spec, pageable);
    }

    @Transactional
    public void deleteUser(String rollnumber) {
        Users userInDb = userRepository.findById(rollnumber).get();
        userInDb.setStatus("deactive");
        Date todayDate = new Date();
        userInDb.setDeactivetime(todayDate);
    }
}
