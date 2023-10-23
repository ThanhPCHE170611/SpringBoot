package com.example.schoolmanagement.Service;

import com.example.schoolmanagement.Model.*;
import com.example.schoolmanagement.Model.Class;
import com.example.schoolmanagement.Repository.*;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;

@Service
@AllArgsConstructor
public class SchoolAdminUserManagementService {
    
    
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final GenderRepository genderRepository;
    private final EthnicRepository ethnicRepository;
    private final ReligionRepository religionRepository;
    private final RoleRepository roleRepository;
    private final ClassRepository classRepository;
    private final TeacherClassSubjectRepository teacherClassSubjectRepository;
    private final SubjectRepository subjectRepository;
    
    public Page<Users> getUsers(Users schoolAdmin, int page, int pageSize) {
        Organization currentOrganization = schoolAdmin.getSchoolOrganization();
        Pageable pageable =  PageRequest.of(page, pageSize);
        return userRepository.findBySchoolOrganization_Id(currentOrganization.getId(), pageable);
    }

    @Transactional
    public void deleteUser(Users user) {
        Users userInDb = userRepository.findById(user.getRollNumber()).get();
        userInDb.setStatus(user.getStatus());
    }

    @Transactional
    public void updateUserWithoutPicture(HttpSession session, Users student, String fullname, String newpassword, Long gender, Long ethnic, Long religion, String parrentname, String address, String hometown, String hobbies, String status, List<Long> roles, Long studentclass, Long teacherclass, String email) {
        Users userInDb = userRepository.findById(student.getRollNumber()).get();
        userInDb.setFullname(fullname);
        userInDb.setEmail(email);
        userInDb.setPassword(passwordEncoder.encode(newpassword));
        userInDb.setGender(genderRepository.findById(gender).get());
        userInDb.setEthnic(ethnicRepository.findById(ethnic).get());
        userInDb.setReligions(religionRepository.findById(religion).get());
        userInDb.setParrentName(parrentname);
        userInDb.setAddress(address);
        userInDb.setHometown(hometown);
        userInDb.setHobbies(hobbies);
        Date date = new Date();
        userInDb.setLastchangepassword(date);
        userInDb.setStatus(status);
        Set<Role> roleList = new HashSet<>();
        for (Long roleId : roles){
            roleList.add(roleRepository.findById(roleId).get());
        }
        userInDb.setRoles(roleList);
        if(studentclass != null){
            userInDb.setStudentclass(classRepository.findById(studentclass).get());
        }
        if(teacherclass != null){
            userInDb.setTeacherclass(classRepository.findById(teacherclass).get());
        }
    }

    @Transactional
    public void updateStudentWithPicture(MultipartFile picture, HttpSession session, Users student, String fullname, String newpassword, Long gender, Long ethnic, Long religion, String parrentname, String address, String hometown, String hobbies, String status, List<Long> roles, Long studentclass, Long teacherclass, String email) {
        String picturePath = "";
        Users userInDb = userRepository.findById(student.getRollNumber()).get();
        try {
            // Get the bytes of the uploaded file
            byte[] profilePictureBytes = picture.getBytes();

            // Save the bytes to a file in the desired location (e.g., resources/images)
            String newImagePath = "/images/"+ student.getRollNumber() +".png"; // Adjust the path as needed
            Files.write(Paths.get("D:/SpringBootGitHub/SpringBoot/Spring Boot/SchoolManagement/src/main/resources/static" + newImagePath), profilePictureBytes);

            // Update the student's profile picture path in the model
            picturePath = newImagePath;
        } catch (IOException e) {
            System.out.println("error: " + e.getMessage());
        }
        userInDb.setFullname(fullname);
        userInDb.setEmail(email);
        userInDb.setPassword(passwordEncoder.encode(newpassword));
        userInDb.setGender(genderRepository.findById(gender).get());
        userInDb.setEthnic(ethnicRepository.findById(ethnic).get());
        userInDb.setReligions(religionRepository.findById(religion).get());
        userInDb.setParrentName(parrentname);
        userInDb.setAddress(address);
        userInDb.setHometown(hometown);
        userInDb.setHobbies(hobbies);
        Date date = new Date();
        userInDb.setLastchangepassword(date);
        userInDb.setPicture(picturePath);
        userInDb.setStatus(status);
        Set<Role> roleList = new HashSet<>();
        for (Long roleId : roles){
            roleList.add(roleRepository.findById(roleId).get());
        }
        userInDb.setRoles(roleList);
        if(studentclass != null){
            userInDb.setStudentclass(classRepository.findById(studentclass).get());
        }
        if(teacherclass != null){
            userInDb.setTeacherclass(classRepository.findById(teacherclass).get());
        }
    }

    @Transactional
    public void addUser(Users newUser) {
        userRepository.save(newUser);
    }

    @Transactional
    public void deleteTeacherClassSubject(Long id) {
        TeacherClassSubject teacherClassSubjectinDB = teacherClassSubjectRepository.findById(id).get();
        teacherClassSubjectinDB.setStatus("deactive");
    }

    @Transactional
    public void addTeacherClassSubject(String teacherrollnumber, Long teacherclass, String teachersubject) {
        Users teacher = userRepository.findById(teacherrollnumber).get();
        Class classTeaching = classRepository.findById(teacherclass).get();
        Subject subjectTeaching = subjectRepository.findById(teachersubject).get();
        TeacherClassSubject teacherClassSubject = new TeacherClassSubject(teacher, classTeaching, subjectTeaching);
        teacherClassSubjectRepository.save(teacherClassSubject);
    }

    @Transactional
    public void updateTeacherClassSubject(Long recordid, String teacherrollnumber, Long teacherclass, String teachersubject) {
        TeacherClassSubject teacherClassSubjectinDB = teacherClassSubjectRepository.findById(recordid).get();
        Class classTeaching = classRepository.findById(teacherclass).get();
        Subject subjectTeaching = subjectRepository.findById(teachersubject).get();
        teacherClassSubjectinDB.setClassTeaching(classTeaching);
        teacherClassSubjectinDB.setSubjectTeaching(subjectTeaching);
    }
}
