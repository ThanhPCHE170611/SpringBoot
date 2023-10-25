package com.example.schoolmanagement.Controller.SuperAdmin;


import com.example.schoolmanagement.Model.*;
import com.example.schoolmanagement.Model.Class;
import com.example.schoolmanagement.Repository.*;
import com.example.schoolmanagement.Service.SuperAdminUserManagementService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Controller
@AllArgsConstructor
public class SuperAdminUserManagementController {

    private final SuperAdminUserManagementService superAdminUserManagementService;
    private final GenderRepository genderRepository;
    private final ReligionRepository religionRepository;
    private final EthnicRepository ethnicRepository;
    private final RoleRepository roleRepository;
    private final OrganizationRepository organizationRepository;
    private final ClassRepository classRepository;
    private final PasswordEncoder passwordEncoder;
    private final SubjectRepository subjectRepository;
    private final TeacherClassSubjectRepository teacherClassSubjectRepository;
    private final UserRepository userRepository;
    private final CityRepository cityRepository;
    private final DistrictRepository districtRepository;
    private final WardRepository wardRepository;

    @GetMapping(path = "/superadmin/usermanagement")
    public String viewUserManagementPage(HttpSession session, Model model,
                                         @RequestParam(value = "page", defaultValue = "0") int page,
                                         @RequestParam(value = "size", defaultValue = "25") int pageSize,
                                         @RequestParam(name = "filterUsername", required = false) String filterUsername,
                                         @RequestParam(name = "filterEmail", required = false) String filterEmail,
                                         @RequestParam(name = "filterFullName", required = false) String filterFullname,
                                         @RequestParam(name = "filterRole", required = false) Long filterRole,
                                         @RequestParam(name = "filterGender", required = false) Long filterGender,
                                         @RequestParam(name = "filterEthnic", required = false) Long filterEthnic,
                                         @RequestParam(name = "filterReligion", required = false) Long filterReligion,
                                         @RequestParam(name = "filterOrganization", required = false) Long filterOrganization) {

        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        } else {
            Page<Users> users = null;
            Specification<Users> spec = Specification.where(null);
            if (filterUsername != null && !filterUsername.isEmpty()) {
                spec = spec.and((root, query, criteriaBuilder) ->
                        criteriaBuilder.like(root.get("username"), "%" + filterUsername + "%")
                );
            }
            else if(filterEmail != null && !filterEmail.isEmpty()){
                spec = spec.and((root, query, criteriaBuilder) ->
                        criteriaBuilder.like(root.get("email"), "%" + filterEmail + "%")
                );
            }
            else if(filterFullname != null && !filterFullname.isEmpty()){
                spec = spec.and((root, query, criteriaBuilder) ->
                        criteriaBuilder.like(root.get("fullname"), "%" + filterFullname + "%")
                );
            }
            else if (filterRole != null && filterRole > 0) {
                Role filterRoleObj = roleRepository.findById(filterRole).get();
                spec = spec.and((root, query, criteriaBuilder) -> {
                    return criteriaBuilder.isMember(filterRoleObj, root.get("roles"));
                });
            } else if (filterGender != null && filterGender > 0) {
                spec = spec.and((root, query, criteriaBuilder) ->
                        criteriaBuilder.equal(root.get("gender").get("Id"), filterGender)
                );
            } else if (filterEthnic != null && filterEthnic > 0) {
                spec = spec.and((root, query, criteriaBuilder) ->
                        criteriaBuilder.equal(root.get("ethnic").get("Id"), filterEthnic)
                );
            } else if (filterReligion != null && filterReligion > 0) {
                spec = spec.and((root, query, criteriaBuilder) ->
                        criteriaBuilder.equal(root.get("religions").get("Id"), filterReligion)
                );
            } else if (filterOrganization != null && filterOrganization > 0) {
                spec = spec.and((root, query, criteriaBuilder) ->
                        criteriaBuilder.equal(root.get("schoolOrganization").get("Id"), filterOrganization)
                );
            } else {
                users = superAdminUserManagementService.getUsers(page, pageSize);
            }
            users = superAdminUserManagementService.getUsersWithCriteria(spec, PageRequest.of(page, pageSize));
            List<Role> roles = roleRepository.findAll();
            List<Gender> genders = genderRepository.findAll();
            List<Ethnic> ethnics = ethnicRepository.findAll();
            List<Religion> religions = religionRepository.findAll();
            List<Organization> organizations = organizationRepository.findAll("active");

            model.addAttribute("users", users);
            model.addAttribute("roles", roles);
            model.addAttribute("genders", genders);
            model.addAttribute("ethnics", ethnics);
            model.addAttribute("religions", religions);
            model.addAttribute("organizations", organizations);

            // Add the filter criteria to the model to repopulate the filter form
            model.addAttribute("filterUsername", filterUsername);
            model.addAttribute("filterEmail", filterEmail);
            model.addAttribute("filterFullname", filterFullname);
            model.addAttribute("filterRole", filterRole);
            model.addAttribute("filterGender", filterGender);
            model.addAttribute("filterEthnic", filterEthnic);
            model.addAttribute("filterReligion", filterReligion);
            model.addAttribute("filterOrganization", filterOrganization);
            return "superadminusermanagement";
        }
    }

    @GetMapping("/superadmin/usermanagement/deleteuser/{rollnumber}")
    public String deleteUser(@PathVariable String rollnumber, HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        } else {
            superAdminUserManagementService.deleteUser(rollnumber);
            return "redirect:/superadmin/usermanagement";
        }
    }

    @GetMapping("/superadmin/usermanagement/update/{rollnumber}")
    public String ViewFormUpdateUser(@PathVariable String rollnumber, HttpSession session, Model model){
        Users users = userRepository.findById(rollnumber).get();
        List<Gender> genders = genderRepository.findAll();
        List<Ethnic> ethnics = ethnicRepository.findAll();
        List<Religion> religions = religionRepository.findAll();
        List<Role> allRoles = roleRepository.findAll();
        List<City> cities = cityRepository.findAll("active");
        List<District> districts = districtRepository.findAll("active");
        List<Ward> wards = wardRepository.findAll("active");
        List<Organization> organizations = organizationRepository.findAllByWardAndStatus(users.getSchoolOrganization().getWardorganization().getId(), "active");
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
        List<Class> classes = classRepository.findAllByclassOrganization(users.getSchoolOrganization());
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
        model.addAttribute("cities", cities);
        model.addAttribute("districts", districts);
        model.addAttribute("wards", wards);
        model.addAttribute("organizations", organizations);
        model.addAttribute("studentclass", studentClass);
        model.addAttribute("teacherclass", teacherClass);
        return "superadminupdateuser";
    }

    @PostMapping(path = "/superadmin/usermanagement/update")
    public String updateUser(@RequestParam String rollnumber, @RequestParam String email,
                             @RequestParam(name = "picture", required = false) MultipartFile picture,
                             @RequestParam("fullname") String fullname, @RequestParam String status,
                             @RequestParam(name="organization", required = false) Long organization,
                             @RequestParam List<Long> roles, @RequestParam(name="studentclass", required = false) Long studentclass,
                             @RequestParam(name="teacherclass", required = false) Long teacherclass,
                             @RequestParam("password") String newpassword, @RequestParam(name="gender") Long gender, @RequestParam("ethnic") Long ethnic, @RequestParam("religion") Long religion,
                             @RequestParam("parrentname") String parrentname, @RequestParam("address") String address, @RequestParam("hometown") String hometown,
                             @RequestParam(name = "hobbies", required = false) String hobbies, HttpSession session, Model model){
        //check if student want to update profile picture:
        //get the current information:
        boolean canUpdate = true;
        Users users = userRepository.findById(rollnumber).get();
        if(!isFullNameValid(fullname)){
            canUpdate = false;
            model.addAttribute("error", "Wrong fullname format!");
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        if(!isEmailValid(email)){
            canUpdate = false;
            model.addAttribute("error", "Wrong email format!");
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        if(userRepository.findUsersByEmail(email).isPresent() && !userRepository.findUsersByEmail(email).get().getEmail().equals(email)){
            canUpdate = false;
            model.addAttribute("error", "Email is exist!");
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        if(!status.equals("active") && !status.equals("deactive")){
            canUpdate = false;
            model.addAttribute("error", "Status must be active or deactive!");
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        if(organization == null ){
            canUpdate = false;
            model.addAttribute("error", "You must select the organization of user!" );
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        if(!isPasswordValid(newpassword)){
            canUpdate = false;
            model.addAttribute("error", "Wrong new password format!");
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        if(!isFullNameValid(parrentname)){
            canUpdate = false;
            model.addAttribute("error", "Wrong parrent name format!");
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        if(!isAddressValid(address)){
            canUpdate = false;
            model.addAttribute("error", "Wrong address format!");
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        if(!isAddressValid(hometown)){
            canUpdate = false;
            model.addAttribute("error", "Wrong home town format!");
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        if(roles.isEmpty()){
            canUpdate = false;
            model.addAttribute("error", "Please select at least one roles!");
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        //Update without picture
        if(canUpdate && picture.isEmpty()){
            superAdminUserManagementService.updateUserWithoutPicture(session,users ,fullname, newpassword, gender, ethnic, religion, parrentname, address, hometown, hobbies, status, roles, studentclass, teacherclass, email, organization);
            model.addAttribute("error", "Update information successfully!");
            return viewUserManagementPage(session, model, 0, 25, null, null, null, null, null, null, null, null);
        }// update avatar
        else if(canUpdate && !picture.isEmpty()){
            superAdminUserManagementService.updateStudentWithPicture(picture, session,users ,fullname, newpassword, gender, ethnic, religion, parrentname, address, hometown, hobbies, status, roles, studentclass, teacherclass, email, organization);
            model.addAttribute("error", "Update information successfully!");
            return viewUserManagementPage(session, model, 0, 25, null, null, null, null, null, null, null, null);

        }
        return viewUserManagementPage(session, model, 0, 25, null, null, null, null, null, null, null, null);

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

    @GetMapping("/superadmin/usermanagement/adduser")
    public String viewFormAddUser(HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        } else {
            List<Gender> genders = genderRepository.findAll();
            List<Ethnic> ethnics = ethnicRepository.findAll();
            List<Religion> religions = religionRepository.findAll();
            List<Role> allRoles = roleRepository.findAll();
            List<City> cities = cityRepository.findAll("active");
            List<District> districts = districtRepository.findAll("active");
            List<Ward> wards = wardRepository.findAll("active");
            List<Organization> organizations = organizationRepository.findAll("active");
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
            model.addAttribute("cities", cities);
            model.addAttribute("districts", districts);
            model.addAttribute("wards", wards);
            model.addAttribute("organizations", organizations);
            return "superadminadduser";
        }
    }

    @PostMapping(path = "/superadmin/usermanagement/adduser")
    public String createUser(@RequestParam String rollnumber, @RequestParam String email,
                             @RequestParam String username, @RequestParam String password,
                             @RequestParam Long organization, @RequestParam List<Long> roles,
                             @RequestParam(name="gender") Long gender, @RequestParam("ethnic") Long ethnic, @RequestParam("religion") Long religion,
                             HttpSession session, Model model){
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
        if(organization == null){
            canAdd = false;
            model.addAttribute("error", "Please select the organization, If dont see the organization, create more in Organization Management!");
            return viewFormAddUser(session, model);
        }
        if(roles == null){
            canAdd = false;
            model.addAttribute("error", "Please select at least one role!");
            return viewFormAddUser(session, model);
        }
        if(canAdd){
            Set<Role> roleSet = new HashSet<>();
            for (Long role : roles){
                roleSet.add(roleRepository.findById(role).get());
            }
            Users newUser = new Users(rollnumber, username, email, passwordEncoder.encode(password), genderRepository.findById(gender).get(), religionRepository.findById(religion).get(), ethnicRepository.findById(ethnic).get(), roleSet, organizationRepository.findById(organization).get());
            superAdminUserManagementService.addUser(newUser);
            model.addAttribute("error", "Add user success, please update user information soon!");
            return viewUserManagementPage(session, model, 0, 25, null, null, null, null, null, null, null, null);
        }
        return viewUserManagementPage(session, model, 0, 25, null, null, null, null, null, null, null, null);
    }
}
