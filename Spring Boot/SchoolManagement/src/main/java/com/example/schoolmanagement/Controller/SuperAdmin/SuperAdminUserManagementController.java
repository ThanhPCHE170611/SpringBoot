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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@AllArgsConstructor
@RequestMapping(path = "/superadmin/usermanagement")
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

    @GetMapping()
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

    @GetMapping("/deleteuser/{rollnumber}")
    public String deleteUser(@PathVariable String rollnumber, HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        } else {
            superAdminUserManagementService.deleteUser(rollnumber);
            return "redirect:/superadmin/usermanagement";
        }
    }

    @GetMapping("/update/{rollnumber}")
    public String viewFormUpdateUser(@PathVariable String rollnumber, HttpSession session, Model model){
        Users users = userRepository.findById(rollnumber).get();
        List<Gender> genders = genderRepository.findAll();
        List<Ethnic> ethnics = ethnicRepository.findAll();
        List<Religion> religions = religionRepository.findAll();
        List<Role> allRoles = roleRepository.findAll();
        List<City> cities = cityRepository.findAll("active");
        List<District> districts = districtRepository.findAll("active");
        List<Ward> wards = wardRepository.findAll("active");
        List<Organization> organizations = organizationRepository.findAllByWardAndStatus(users.getSchoolOrganization().getWardorganization().getWard().getId(), "active");
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

}
