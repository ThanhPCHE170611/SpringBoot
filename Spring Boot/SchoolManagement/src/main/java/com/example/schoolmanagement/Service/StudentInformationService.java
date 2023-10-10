package com.example.schoolmanagement.Service;

import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.EthnicRepository;
import com.example.schoolmanagement.Repository.GenderRepository;
import com.example.schoolmanagement.Repository.ReligionRepository;
import com.example.schoolmanagement.Repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Date;

@Service
@AllArgsConstructor
public class StudentInformationService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final GenderRepository genderRepository;
    private final EthnicRepository ethnicRepository;
    private final ReligionRepository religionRepository;
    @Transactional
    public void updateStudentWithoutPicture(HttpSession session, Users student, String fullname, String newpassword, Long gender, Long ethnic, Long religion, String parrentname, String address, String hometown, String hobbies){
        Users studentInDb = userRepository.findById(student.getRollNumber()).get();
        studentInDb.setFullname(fullname);
        studentInDb.setPassword(passwordEncoder.encode(newpassword));
        studentInDb.setGender(genderRepository.findById(gender).get());
        studentInDb.setEthnic(ethnicRepository.findById(ethnic).get());
        studentInDb.setReligions(religionRepository.findById(religion).get());
        studentInDb.setParrentName(parrentname);
        studentInDb.setAddress(address);
        studentInDb.setHometown(hometown);
        studentInDb.setHobbies(hobbies);
        Date date = new Date();
        studentInDb.setLastchangepassword(date);
        session.setAttribute("user", studentInDb);
    }

    @Transactional
    public void updateStudentWithPicture(MultipartFile picture, HttpSession session, Users student, String fullname, String newpassword, Long gender, Long ethnic, Long religion, String parrentname, String address, String hometown, String hobbies) {
        String picturePath = "";
        Users studentInDb = userRepository.findById(student.getRollNumber()).get();
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
        studentInDb.setFullname(fullname);
        studentInDb.setPassword(passwordEncoder.encode(newpassword));
        studentInDb.setGender(genderRepository.findById(gender).get());
        studentInDb.setEthnic(ethnicRepository.findById(ethnic).get());
        studentInDb.setReligions(religionRepository.findById(religion).get());
        studentInDb.setParrentName(parrentname);
        studentInDb.setAddress(address);
        studentInDb.setHometown(hometown);
        studentInDb.setHobbies(hobbies);
        Date date = new Date();
        studentInDb.setLastchangepassword(date);
        studentInDb.setPicture(picturePath);
        session.setAttribute("user", studentInDb);
    }
}
