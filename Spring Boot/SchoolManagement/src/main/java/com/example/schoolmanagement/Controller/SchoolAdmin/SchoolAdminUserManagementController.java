package com.example.schoolmanagement.Controller.SchoolAdmin;

import com.example.schoolmanagement.Model.*;
import com.example.schoolmanagement.Model.Class;
import com.example.schoolmanagement.Repository.*;
import com.example.schoolmanagement.Service.SchoolAdminSubjectManagementService;
import com.example.schoolmanagement.Service.SchoolAdminUserManagementService;
import com.sun.net.httpserver.HttpsServer;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Controller
@AllArgsConstructor
public class SchoolAdminUserManagementController {
    private final SchoolAdminUserManagementService schoolAdminUserManagementService;
    private final UserRepository userRepository;

    private final GenderRepository genderRepository;
    private final ReligionRepository religionRepository;
    private final EthnicRepository ethnicRepository;
    private final RoleRepository roleRepository;
    private final OrganizationRepository organizationRepository;
    private final ClassRepository classRepository;
    private final PasswordEncoder passwordEncoder;


    @GetMapping(path = "/schooladmin/usermanagement")
    public String viewAllUsers(HttpSession session, Model model, @RequestParam(value = "page", defaultValue = "0") int page,
                               @RequestParam(value = "size", defaultValue = "25") int pageSize){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        }
        else {
            Users schoolAdmin = (Users) session.getAttribute("user");
            Page<Users> users = schoolAdminUserManagementService.getUsers(schoolAdmin, page, pageSize);
                    model.addAttribute("users", users);
            model.addAttribute("page", page);
            return "schooladminusermanagement";
        }
    }

    @GetMapping(path = "/schooladmin/usermanagement/deleteuser/{rollNumber}")
    public String deleteUser(@PathVariable String rollNumber, HttpSession session, Model model){
        Users user = userRepository.findById(rollNumber).get();
        user.setStatus("deactive");
        schoolAdminUserManagementService.deleteUser(user);
        model.addAttribute("error", "Delete Successful!");
        return viewAllUsers(session, model, 0, 25);
    }


    @GetMapping(path = "/schooladmin/usermanagement/update/{rollNumber}")
    public String viewFormUpdate(@PathVariable String rollNumber, HttpSession session, Model model){
        Users schoolAdmin = (Users) session.getAttribute("user");
        Users users = userRepository.findById(rollNumber).get();
        List<Gender> genders = genderRepository.findAll();
        List<Ethnic> ethnics = ethnicRepository.findAll();
        List<Religion> religions = religionRepository.findAll();
        List<Role> allRoles = roleRepository.findAll();
        List<Role> roles = new ArrayList<>();
        for (Role role : allRoles){
            if(!role.getRolename().equals("superadmin")){
                roles.add(role);
            }
        }
        boolean isstudent = false, isteacher = false, isschooladmin = false;
        for (Role role : users.getRoles()){
            if(role.getRolename().equals("student")){
                isstudent = true;
                model.addAttribute("isttudent", true);
            } else if(role.getRolename().equals("teacher")){
                isteacher = true;
                model.addAttribute("isteacher", true);
            } else if (role.getRolename().equals("schooladmin")){
                isschooladmin = true;
                model.addAttribute("isschooladmin", true);
            }
        }

        //split student class and teacher class:
        //each teacher just responsibility for one class
        //each class just have 50 students max
        List<Class> classes = classRepository.findAllByclassOrganization(schoolAdmin.getSchoolOrganization());
        List<Class> studentClass = new ArrayList<>();
        List<Class> teacherClass  = new ArrayList<>();
        model.addAttribute("genders", genders);
        model.addAttribute("ethnics", ethnics);
        model.addAttribute("religions", religions);
        model.addAttribute("roles", roles);
        model.addAttribute("user", users);
        for (Class aClass : classes){
            if(userRepository.findAllBystudentclass(aClass.getId(), "active").size()<50 || (isstudent && aClass.getId() == users.getStudentclass().getId())){
                studentClass.add(aClass);
            }
            if(userRepository.findAllByteacherclass(aClass.getId(), "active").isEmpty() || (isteacher && users.getTeacherclass()!=null && aClass.getId() == users.getTeacherclass().getId())){
                teacherClass.add(aClass);
            }
        }
        model.addAttribute("studentclass", studentClass);
        model.addAttribute("teacherclass", teacherClass);
        model.addAttribute("organization", schoolAdmin.getSchoolOrganization());
        return "schooladminupdateuser";
    }


    @PostMapping(path = "schooladmin/usermanagement/update")
    public String updateUser(@RequestParam String rollnumber ,@RequestParam(name = "picture", required = false) MultipartFile picture, @RequestParam("fullname") String fullname,
                             @RequestParam("password") String newpassword, @RequestParam List<Long> roles, @RequestParam String status,
                             @RequestParam(name="gender") Long gender, @RequestParam("ethnic") Long ethnic, @RequestParam("religion") Long religion,
                             @RequestParam("parrentname") String parrentname, @RequestParam("address") String address, @RequestParam("hometown") String hometown,
                             @RequestParam(name = "hobbies", required = false) String hobbies, @RequestParam(name="studentclass", required = false) Long studentclass,
            @RequestParam(name="teacherclass", required = false) Long teacherclass, @RequestParam(name="email", required = false) String email
            , HttpSession session, Model model){
        //check if student want to update profile picture:
        //get the current information:
        boolean canUpdate = true;
        Users users = userRepository.findById(rollnumber).get();
        // check fullname is valid
        if(!isFullNameValid(fullname)){
            canUpdate = false;
            model.addAttribute("error", "Wrong fullname format!");
            return viewFormUpdate(rollnumber, session, model);
        }
        if(!isEmailValid(email)){
            canUpdate = false;
            model.addAttribute("error", "Wrong email format!");
            return viewFormUpdate(rollnumber, session, model);
        }
        if(userRepository.findUsersByEmail(email).isPresent() && !userRepository.findUsersByEmail(email).get().getEmail().equals(email)){
            canUpdate = false;
            model.addAttribute("error", "Email is exist!");
            return viewFormUpdate(rollnumber, session, model);
        }
        if(!status.equals("active") && !status.equals("deactive")){
            canUpdate = false;
            model.addAttribute("error", "Status must be active or deactive!");
            return viewFormUpdate(rollnumber, session, model);
        }
        if(!isPasswordValid(newpassword)){
            canUpdate = false;
            model.addAttribute("error", "Wrong new password format!");
            return viewFormUpdate(rollnumber, session, model);
        }
        if(!isFullNameValid(parrentname)){
            canUpdate = false;
            model.addAttribute("error", "Wrong parrent name format!");
            return viewFormUpdate(rollnumber, session, model);
        }
        if(!isAddressValid(address)){
            canUpdate = false;
            model.addAttribute("error", "Wrong address format!");
            return viewFormUpdate(rollnumber, session, model);
        }
        if(!isAddressValid(hometown)){
            canUpdate = false;
            model.addAttribute("error", "Wrong home town format!");
            return viewFormUpdate(rollnumber, session, model);
        }
        if(roles.isEmpty()){
            canUpdate = false;
            model.addAttribute("error", "Please select at least one roles!");
            return viewFormUpdate(rollnumber, session, model);
        }
        if(canUpdate && picture.isEmpty()){
            schoolAdminUserManagementService.updateUserWithoutPicture(session,users ,fullname, newpassword, gender, ethnic, religion, parrentname, address, hometown, hobbies, status, roles, studentclass, teacherclass, email);
            model.addAttribute("error", "Update information successfully!");
            return viewAllUsers(session, model, 0, 25);
        }// update avatar
        else if(canUpdate && !picture.isEmpty()){
            schoolAdminUserManagementService.updateStudentWithPicture(picture, session,users ,fullname, newpassword, gender, ethnic, religion, parrentname, address, hometown, hobbies, status, roles, studentclass, teacherclass, email);
            model.addAttribute("error", "Update information successfully!");
            return viewAllUsers(session, model, 0, 25);
        }
        return viewAllUsers(session, model, 0, 25);
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

    private boolean isEmailValid(String email){
        return email.matches("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
    }
    private boolean isRollNumberValid(String rollNumber){
        return rollNumber.matches("^(ha|se|he)[a-zA-Z0-9_]{4}$");
    }

    @GetMapping(path = "/schooladmin/usermanagement/adduser")
    public String viewFormAddUser(HttpSession session, Model model){
        Users schoolAdmin = (Users) session.getAttribute("user");
        List<Gender> genders = genderRepository.findAll();
        List<Ethnic> ethnics = ethnicRepository.findAll();
        List<Religion> religions = religionRepository.findAll();
        List<Role> allRoles = roleRepository.findAll();
        List<Role> roles = new ArrayList<>();
        for (Role role : allRoles){
            if(!role.getRolename().equals("superadmin")){
                roles.add(role);
            }
        }
        model.addAttribute("genders", genders);
        model.addAttribute("ethnics", ethnics);
        model.addAttribute("religions", religions);
        model.addAttribute("roles", roles);
        return "schooladminusermanagementadduser";
    }
    @PostMapping(path = "/schooladmin/usermanagement/adduser")
    public String addUser(@RequestParam String rollnumber ,@RequestParam String username, @RequestParam String password, @RequestParam String email, @RequestParam Long gender, @RequestParam Long ethnic,
                          @RequestParam Long religion, @RequestParam(name = "roles", required = false) List<Long> roles, HttpSession session, Model model){
        boolean canAdd = true;
        if(!isRollNumberValid(rollnumber)){
            canAdd = false;
            model.addAttribute("error", "RollNumber is invalid!\nThe format is ha|se|he and 4 number\nExample:ha0000");
            return viewFormAddUser(session, model);
        }
        if(userRepository.findById(rollnumber).isPresent()){
            canAdd = false;
            model.addAttribute("error", "RollNumber is dupplicate!");
            return viewFormAddUser(session, model);
        }
        if(!username.matches("^[a-zA-Z][a-zA-Z0-9_]{2,14}$")){
            canAdd = false;
            model.addAttribute("error", "Username is invalid!");
            return viewFormAddUser(session, model);
        }
        if(userRepository.findUsersByUsername(username).isPresent()){
            canAdd = false;
            model.addAttribute("error", "Username is dupplicate!");
            return viewFormAddUser(session, model);
        }
        if(!isEmailValid(email)){
            canAdd = false;
            model.addAttribute("error", "Email is invalid!");
            return viewFormAddUser(session, model);
        }
        if(userRepository.findUsersByEmail(email).isPresent()){
            canAdd = false;
            model.addAttribute("error", "Email is dupplicate!");
            return viewFormAddUser(session, model);
        }
        if(roles == null){
            canAdd = false;
            model.addAttribute("error", "Please select at least one role!");
            return viewFormAddUser(session, model);
        }
        if(canAdd){
            Users schoolAdmin = (Users) session.getAttribute("user");
            Set<Role> roleSet = new HashSet<>();
            for (Long role : roles){
                roleSet.add(roleRepository.findById(role).get());
            }
            Users newUser = new Users(rollnumber, username, email, passwordEncoder.encode(password), genderRepository.findById(gender).get(), religionRepository.findById(religion).get(), ethnicRepository.findById(ethnic).get(), roleSet, schoolAdmin.getSchoolOrganization());
            schoolAdminUserManagementService.addUser(newUser);
            model.addAttribute("error", "Add user success, please update user information soon!");
            return viewAllUsers(session, model, 0, 25);
        }
        return viewAllUsers(session, model, 0, 25);
    }


}
