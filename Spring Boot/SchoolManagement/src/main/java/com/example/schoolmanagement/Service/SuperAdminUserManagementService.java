package com.example.schoolmanagement.Service;

import com.example.schoolmanagement.Model.Error;
import com.example.schoolmanagement.Model.ImportUserHistory;
import com.example.schoolmanagement.Model.Role;
import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.*;
import lombok.AllArgsConstructor;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@AllArgsConstructor
public class SuperAdminUserManagementService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final GenderRepository genderRepository;
    private final EthnicRepository ethnicRepository;
    private final ReligionRepository religionRepository;
    private final RoleRepository roleRepository;
    private final ClassRepository classRepository;
    private final ImportUserHistoryRepository importUserHistoryRepository;
    private final OrganizationRepository organizationRepository;
    private final ErrorRepository errorRepository;

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

    @Transactional
    public void updateUserWithoutPicture(HttpSession session, Users users, String fullname, String newpassword, Long gender, Long ethnic, Long religion, String parrentname, String address, String hometown, String hobbies, String status, List<Long> roles, Long studentclass, Long teacherclass, String email, Long organization) {
        Users userInDb = userRepository.findById(users.getRollNumber()).get();
        userInDb.setFullname(fullname);
        userInDb.setEmail(email);
        userInDb.setPassword(passwordEncoder.encode(newpassword));
        userInDb.setGender(genderRepository.findById(gender).get());
        userInDb.setEthnic(ethnicRepository.findById(ethnic).get());
        userInDb.setReligions(religionRepository.findById(religion).get());
        userInDb.setSchoolOrganization(organizationRepository.findById(organization).get());
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
        } else {
            userInDb.setStudentclass(null);
        }
        if(teacherclass != null){
            userInDb.setTeacherclass(classRepository.findById(teacherclass).get());
        } else {
            userInDb.setTeacherclass(null);
        }
    }

    @Transactional
    public void updateStudentWithPicture(MultipartFile picture, HttpSession session, Users users, String fullname, String newpassword, Long gender, Long ethnic, Long religion, String parrentname, String address, String hometown, String hobbies, String status, List<Long> roles, Long studentclass, Long teacherclass, String email, Long organization) {
        String picturePath = "";
        Users userInDb = userRepository.findById(users.getRollNumber()).get();
        try {
            // Get the bytes of the uploaded file
            byte[] profilePictureBytes = picture.getBytes();

            // Save the bytes to a file in the desired location (e.g., resources/images)
            String newImagePath = "/images/"+ users.getRollNumber() +".png"; // Adjust the path as needed
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
        userInDb.setSchoolOrganization(organizationRepository.findById(organization).get());
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
    public void updateImportUserHistory(ImportUserHistory importUserHistory, List<Error> errorTotal) {
        errorRepository.saveAll(errorTotal);
        ImportUserHistory importUserHistoryInDb = importUserHistoryRepository.findById(importUserHistory.getId()).get();
        importUserHistoryInDb.setErrors(errorTotal);
    }

    @Transactional
    public ImportUserHistory createNewInportUserHistory(Users author, java.sql.Date currentDate, List<Error> errorTotal) {
        ImportUserHistory newImportUserHistory = null;
        int id = importUserHistoryRepository.findAll().size() + 1;
        if(!errorTotal.isEmpty()){
            errorRepository.saveAll(errorTotal);

            newImportUserHistory = new ImportUserHistory(author, currentDate, errorTotal, id);
        }
        else {
            newImportUserHistory = new ImportUserHistory(author, currentDate, id);
        }
        importUserHistoryRepository.save(newImportUserHistory);
        return newImportUserHistory;
    }

    public void writeExcelFile(Workbook workbook, String path) {
        try (ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
            workbook.write(outputStream);
            byte[] excelData = outputStream.toByteArray();
            Files.write(Paths.get(path), excelData);
            // Save the byte array to the database (assuming you have a method for that)
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Transactional
    public void saveAllUser(List<Users> newUserList, ImportUserHistory newImportUserHistory) {
        //save all student in db, set new student to history student list
        userRepository.saveAll(newUserList);
        ImportUserHistory importUserHistoryInDb = importUserHistoryRepository.findById(newImportUserHistory.getId()).get();
        importUserHistoryInDb.setStudents(newUserList);
    }

    public void downloadTempFile(String path, HttpServletResponse response) {
        try {
            byte[] fileContent = Files.readAllBytes(Paths.get(path));
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment; filename="+ path.substring(97));
            response.setContentLength(fileContent.length);
            response.getOutputStream().write(fileContent);
            response.getOutputStream().flush();
            response.getOutputStream().close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
