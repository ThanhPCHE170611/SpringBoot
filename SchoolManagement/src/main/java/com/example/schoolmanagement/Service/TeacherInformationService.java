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
public class TeacherInformationService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final GenderRepository genderRepository;
    private final EthnicRepository ethnicRepository;
    private final ReligionRepository religionRepository;

    @Transactional
    public void updateTeacherWithoutPicture(HttpSession session, Users teacher, String fullname, String newpassword, Long gender, Long ethnic, Long religion, String address, String hometown) {
        Users teacherInDb = userRepository.findById(teacher.getRollNumber()).get();
        teacherInDb.setFullname(fullname);
        teacherInDb.setPassword(passwordEncoder.encode(newpassword));
        teacherInDb.setGender(genderRepository.findById(gender).get());
        teacherInDb.setEthnic(ethnicRepository.findById(ethnic).get());
        teacherInDb.setReligions(religionRepository.findById(religion).get());
        teacherInDb.setAddress(address);
        teacherInDb.setHometown(hometown);
        Date date = new Date();
        teacherInDb.setLastchangepassword(date);
        session.setAttribute("user", teacherInDb);
    }

    @Transactional
    public void updateTeacherWithPicture(MultipartFile picture, HttpSession session, Users teacher, String fullname, String newpassword, Long gender, Long ethnic, Long religion, String address, String hometown) {
        String picturePath = "";
        Users teacherInDb = userRepository.findById(teacher.getRollNumber()).get();
        try {
            // Get the bytes of the uploaded file
            byte[] profilePictureBytes = picture.getBytes();

            // Save the bytes to a file in the desired location (e.g., resources/images)
            String newImagePath = "/images/"+ teacherInDb.getRollNumber() +".png"; // Adjust the path as needed
            Files.write(Paths.get("D:/SpringBootGitHub/SpringBoot/Spring Boot/SchoolManagement/src/main/resources/static" + newImagePath), profilePictureBytes);

            // Update the student's profile picture path in the model
            picturePath = newImagePath;
        } catch (IOException e) {
            System.out.println("error: " + e.getMessage());
        }
        teacherInDb.setFullname(fullname);
        teacherInDb.setPassword(passwordEncoder.encode(newpassword));
        teacherInDb.setGender(genderRepository.findById(gender).get());
        teacherInDb.setEthnic(ethnicRepository.findById(ethnic).get());
        teacherInDb.setReligions(religionRepository.findById(religion).get());
        teacherInDb.setAddress(address);
        teacherInDb.setHometown(hometown);
        Date date = new Date();
        teacherInDb.setLastchangepassword(date);
        teacherInDb.setPicture(picturePath);
        session.setAttribute("user", teacherInDb);
    }
}
