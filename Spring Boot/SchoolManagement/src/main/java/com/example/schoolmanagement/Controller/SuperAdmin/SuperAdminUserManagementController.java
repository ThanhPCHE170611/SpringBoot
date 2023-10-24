package com.example.schoolmanagement.Controller.SuperAdmin;


import com.example.schoolmanagement.Model.*;
import com.example.schoolmanagement.Repository.*;
import com.example.schoolmanagement.Service.SuperAdminUserManagementService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@AllArgsConstructor
@RequestMapping(path = "/superadmin/usermanagement")
public class SuperAdminUserManagementController {

    private final SuperAdminUserManagementService superAdminUserManagementService;
    private final RoleRepository roleRepository;
    private final GenderRepository genderRepository;
    private final EthnicRepository ethnicRepository;
    private final ReligionRepository religionRepository;
    private final OrganizationRepository organizationRepository;

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
}
