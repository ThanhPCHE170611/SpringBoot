package com.example.schoolmanagement.Controller.Teacher;

import com.example.schoolmanagement.Model.Ethnic;
import com.example.schoolmanagement.Model.Gender;
import com.example.schoolmanagement.Model.Religion;
import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.EthnicRepository;
import com.example.schoolmanagement.Repository.GenderRepository;
import com.example.schoolmanagement.Repository.ReligionRepository;
import com.example.schoolmanagement.Service.TeacherInformationService;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@AllArgsConstructor
public class TeacherInformationController {
    private final GenderRepository genderRepository;
    private final EthnicRepository ethnicRepository;
    private final ReligionRepository religionRepository;
    private final PasswordEncoder passwordEncoder;
    private final TeacherInformationService teacherInformationService;

    @GetMapping(path = "/teacher/accountsetting")
    public String getTeacherInformation(HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        }
        else {
            Users teacher = (Users) session.getAttribute("user");
            List<Gender> genders = genderRepository.findAll();
            List<Ethnic> ethnics = ethnicRepository.findAll();
            List<Religion> religions = religionRepository.findAll();
            System.out.println(teacher.getGender().getGender());
            model.addAttribute("genders", genders);
            model.addAttribute("ethnics", ethnics);
            model.addAttribute("religions", religions);
            model.addAttribute("teacher", teacher);
            return "teacherinformation";
        }
    }

    @PostMapping(path = "/teacher/accountsetting")
    public String updateTeacherprofile(@RequestParam(name = "picture", required = false) MultipartFile picture, @RequestParam("fullname") String fullname,
                                       @RequestParam("oldpassword") String oldpassword, @RequestParam("password") String newpassword,
                                       @RequestParam(name="gender") Long gender, @RequestParam("ethnic") Long ethnic, @RequestParam("religion") Long religion,
                                        @RequestParam("address") String address, @RequestParam("hometown") String hometown
            , HttpSession session, Model model){
        //check if student want to update profile picture:
        //get the current information:
        boolean canUpdate = true;
        Users teacher = (Users) session.getAttribute("user");
        // check fullname is valid
        if(!isFullNameValid(fullname)){
            canUpdate = false;
            model.addAttribute("error", "Wrong fullname format!");
            return getTeacherInformation(session, model);
        }
        if(!passwordEncoder.matches(oldpassword, teacher.getPassword()) && !oldpassword.equals(teacher.getPassword())){
            canUpdate = false;
            model.addAttribute("error", "Wrong old password not match");
            return getTeacherInformation(session, model);
        }
        if(!isPasswordValid(newpassword)){
            canUpdate = false;
            model.addAttribute("error", "Wrong new password format!");
            return getTeacherInformation(session, model);
        }
        if(!isAddressValid(address)){
            canUpdate = false;
            model.addAttribute("error", "Wrong address format!");
            return getTeacherInformation(session, model);
        }
        if(!isAddressValid(hometown)){
            canUpdate = false;
            model.addAttribute("error", "Wrong home town format!");
            return getTeacherInformation(session, model);
        }
        // no update avatar
        System.out.println(picture );
        if(canUpdate && picture.isEmpty()){
            teacherInformationService.updateTeacherWithoutPicture(session,teacher ,fullname, newpassword, gender, ethnic, religion, address, hometown);
            model.addAttribute("error", "Update information successfully!");
            return getTeacherInformation(session, model);
        }// update avatar
        else if(canUpdate && !picture.isEmpty()){
            teacherInformationService.updateTeacherWithPicture(picture, session,teacher ,fullname, newpassword, gender, ethnic, religion,  address, hometown);
            model.addAttribute("error", "Update information successfully!");
            return getTeacherInformation(session, model);
        }
        return getTeacherInformation(session, model);
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
