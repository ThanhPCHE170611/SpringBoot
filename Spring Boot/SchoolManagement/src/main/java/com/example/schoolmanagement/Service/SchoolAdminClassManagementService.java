package com.example.schoolmanagement.Service;

import com.example.schoolmanagement.Model.Class;
import com.example.schoolmanagement.Repository.ClassRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@AllArgsConstructor
public class SchoolAdminClassManagementService {

    private final ClassRepository classRepository;

    @Transactional
    public void updateClass(Class aClass){
        Class classInDB = classRepository.findById(aClass.getId()).get();
        classInDB.setClassname(aClass.getClassname());
        classInDB.setClassOrganization(aClass.getClassOrganization());
    }

    @Transactional
    public void deleteClass(Long classid) {
        classRepository.deleteById(classid);
    }
}
