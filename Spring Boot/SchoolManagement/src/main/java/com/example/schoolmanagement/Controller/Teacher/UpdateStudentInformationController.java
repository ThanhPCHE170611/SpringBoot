package com.example.schoolmanagement.Controller.Teacher;

import com.example.schoolmanagement.Model.Ethnic;
import com.example.schoolmanagement.Model.Gender;
import com.example.schoolmanagement.Model.Religion;
import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.EthnicRepository;
import com.example.schoolmanagement.Repository.GenderRepository;
import com.example.schoolmanagement.Repository.ReligionRepository;
import com.example.schoolmanagement.Repository.UserRepository;
import com.example.schoolmanagement.Service.StudentInformationService;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@AllArgsConstructor
public class UpdateStudentInformationController {

    private final UserRepository userRepository;
    private final GenderRepository genderRepository;
    private final EthnicRepository ethnicRepository;
    private final ReligionRepository religionRepository;
    private final StudentInformationService studentInformationService;

    @GetMapping(path = "/teacher/updatestudentinfo/{rollnumber}")
    public String getStudentInformation(@PathVariable String rollnumber, HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        }
        else {
            Users student = userRepository.findById(rollnumber).get();
            List<Gender> genders = genderRepository.findAll();
            List<Ethnic> ethnics = ethnicRepository.findAll();
            List<Religion> religions = religionRepository.findAll();
            System.out.println(student.getGender().getGender());
            model.addAttribute("genders", genders);
            model.addAttribute("ethnics", ethnics);
            model.addAttribute("religions", religions);
            model.addAttribute("student", student);
            return "updatestudentinformation";
        }
    }
    @PostMapping(path = "/teacher/updatestudentinfo")
    public String updateStudentprofile(@RequestParam(name = "picture", required = false) MultipartFile picture, @RequestParam("fullname") String fullname,
                                       @RequestParam("password") String newpassword, @RequestParam("rollnumber") String rollnumber,
                                       @RequestParam(name="gender") Long gender, @RequestParam("ethnic") Long ethnic, @RequestParam("religion") Long religion,
                                       @RequestParam("parrentname") String parrentname, @RequestParam("address") String address, @RequestParam("hometown") String hometown,
                                       @RequestParam(name = "hobbies", required = false) String hobbies
            , HttpSession session, Model model){
        //check if student want to update profile picture:
        //get the current information:
        boolean canUpdate = true;
        Users student = userRepository.findById(rollnumber).get();
        // check fullname is valid
        if(!isFullNameValid(fullname)){
            canUpdate = false;
            model.addAttribute("error", "Wrong fullname format!");
            return getStudentInformation(rollnumber, session, model);
        }
        if(!isPasswordValid(newpassword)){
            canUpdate = false;
            model.addAttribute("error", "Wrong new password format!");
            return getStudentInformation(rollnumber, session, model);
        }
        if(!isFullNameValid(parrentname)){
            canUpdate = false;
            model.addAttribute("error", "Wrong parrent name format!");
            return getStudentInformation(rollnumber, session, model);
        }
        if(!isAddressValid(address)){
            canUpdate = false;
            model.addAttribute("error", "Wrong address format!");
            return getStudentInformation(rollnumber, session, model);
        }
        if(!isAddressValid(hometown)){
            canUpdate = false;
            model.addAttribute("error", "Wrong home town format!");
            return getStudentInformation(rollnumber, session, model);
        }
        // no update avatar
        if(canUpdate && picture.isEmpty()){
            studentInformationService.updateStudentWithoutPictureForTeacher(session,student ,fullname, newpassword, gender, ethnic, religion, parrentname, address, hometown, hobbies);
            model.addAttribute("error", "Update information successfully!");
            return getStudentInformation(rollnumber, session, model);
        }// update avatar
        else if(canUpdate && !picture.isEmpty()){
            studentInformationService.updateStudentWithPictureForTeacher(picture, session,student ,fullname, newpassword, gender, ethnic, religion, parrentname, address, hometown, hobbies);
            model.addAttribute("error", "Update information successfully!");
            return getStudentInformation(rollnumber, session, model);
        }
        return getStudentInformation(rollnumber, session, model);
    }
    private boolean isFullNameValid(String fullName) {
        return fullName.matches("^[\\p{L}\\s]+$");
    }
    private boolean isPasswordValid(String password){
        return password.matches("^[^\\p{L}\\s]*$");
    }
    private boolean isAddressValid(String address){
        return address.matches("^[\\p{L}\\d\\s,./-]+$");
    }
}
