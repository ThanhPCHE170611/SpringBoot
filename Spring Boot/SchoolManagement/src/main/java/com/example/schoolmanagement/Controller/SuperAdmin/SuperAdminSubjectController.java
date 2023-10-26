package com.example.schoolmanagement.Controller.SuperAdmin;

import com.example.schoolmanagement.Model.*;
import com.example.schoolmanagement.Repository.*;
import com.example.schoolmanagement.Service.SuperAdminSubjectManagementService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Controller
@AllArgsConstructor
@RequestMapping(path = "/superadmin/subjectmanagement")
public class SuperAdminSubjectController {

    private final SubjectRepository subjectRepository;
    private final SuperAdminSubjectManagementService superAdminSubjectManagementService;
    private final CityRepository cityRepository;
    private final DistrictRepository districtRepository;
    private final WardRepository wardRepository;
    private final OrganizationRepository organizationRepository;

    @GetMapping("")
    public String viewPage(HttpSession session, Model model,
                           @RequestParam(value = "page", defaultValue = "0") int page,
                           @RequestParam(value = "size", defaultValue = "25") int pageSize,
                           @RequestParam(name = "filterOrganization", required = false) Long filterOrganization,
                           @RequestParam(name = "filterSubjectName", required = false) String filterSubjectName){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        }
        else {
            Page<Subject> subjects = null;
            Specification<Subject> spec = Specification.where(null);
            if(filterOrganization != null && filterOrganization > 0){
                spec = spec.and((root, cq, cb) -> cb.isMember(organizationRepository.findById(filterOrganization).get() ,root.get("organizations")));
            }
            else if(filterSubjectName != null && !filterSubjectName.isEmpty()){
                spec = spec.and((root, cq, cb) -> cb.like(root.get("subjectname"), "%" + filterSubjectName + "%"));
            }
            else {
                subjects = superAdminSubjectManagementService.getSubjects(page, pageSize);
            }
            subjects = superAdminSubjectManagementService.getSubjectsWithCriteria(spec, PageRequest.of(page, pageSize));
            List<Organization> organizations = organizationRepository.findAll("active");
            model.addAttribute("organizations", organizations);
            model.addAttribute("subjects", subjects);
            model.addAttribute("filterOrganization", filterOrganization);
            model.addAttribute("filterSubjectName", filterSubjectName);
            return "superadminsubjectmanagment";
        }
    }

    @GetMapping("/deletesubject/{subjectcode}")
    public String deleteSubject(@PathVariable("subjectcode") String subjectcode){
        superAdminSubjectManagementService.deleteSubject(subjectcode);
        return "redirect:/superadmin/subjectmanagement";
    }

    @GetMapping("/update/{subjectcode}")
    public String viewFormUpdateSubject(@PathVariable("subjectcode") String subjectcode,
                                        HttpSession session, Model model){
        if (session.getAttribute("user")== null) {
            return "redirect:/auth/login";
        } else {
            Subject subject = subjectRepository.findById(subjectcode).get();
            List<City> cities = cityRepository.findAll("active");
            List<District> districts = districtRepository.findAll("active");
            List<Ward> wards = wardRepository.findAll("active");
            List<Organization> organizations = organizationRepository.findAll("active");
            model.addAttribute("subject", subject);
            model.addAttribute("cities", cities);
            model.addAttribute("districts", districts);
            model.addAttribute("wards", wards);
            model.addAttribute("organizations", organizations);
            return "superadminupdatesubject";
        }
    }
    @PostMapping("/update")
    public String updateSubject(@RequestParam String subjectcode, @RequestParam String subjectname,
                                @RequestParam String status, @RequestParam(name="organization", required = false) Long organization,
                                @RequestParam (name="organizations", required = false) List<Long> organizations,
                                HttpSession session, Model model){
        if (session.getAttribute("user")== null) {
            return "redirect:/auth/login";
        } else {
            Subject subject = subjectRepository.findById(subjectcode).get();
            if(!isValidSubjectName(subjectname)){
                model.addAttribute("error", "Subject name is invalid");
                return viewFormUpdateSubject(subjectcode, session, model);
            }
            if(!status.equalsIgnoreCase("active") && !subject.getStatus().equalsIgnoreCase("deactive")){
                model.addAttribute("error", "Status must be active or deactive");
                return viewFormUpdateSubject(subjectcode, session, model);
            }
            if(organization == null && (organizations == null || organizations.size() == 0)){
                model.addAttribute("error", "Please choose at least one Organization");
                return viewFormUpdateSubject(subjectcode, session, model);
            }
            Set<Organization> organizationSet = new HashSet<>();
            if(organizations != null) {
                for (Long organizationId : organizations) {
                    organizationSet.add(organizationRepository.findById(organizationId).get());
                }
            }
            organizationSet.add(organizationRepository.findById(organization).get());
            subject.setSubjectname(subjectname);
            subject.setStatus(status);
            subject.setOrganizations(organizationSet);
            superAdminSubjectManagementService.updateSubject(subject);
            model.addAttribute("error", "Update subject successfully");
            return viewPage(session, model, 0, 25, null, null);
        }
    }
    private boolean isValidSubjectName(String subjectname){
        return subjectname.matches("^[\\p{L}\\s0-9]+$");
    }
    @GetMapping("/addsubject")
    public String viewFormAddSubject(HttpSession session, Model model){
        //validate session
        if (session.getAttribute("user")== null) {
            return "redirect:/auth/login";
        } else {
            return "superadminaddsubject";
        }
    }
    private boolean isValidSubjectCode(String subjectcode){
        return subjectcode.matches("^[a-zA-Z0-9]+$");
    }
    @PostMapping("/addsubject")
    public String addSubject(@RequestParam String subjectcode, @RequestParam String subjectname, HttpSession session, Model model){
        boolean canAdd = true;
        if(!isValidSubjectCode(subjectcode)){
            model.addAttribute("error", "Subject code is invalid, Subject code just contain Alphabet, Digit and No Space!");
            canAdd = false;
            return viewFormAddSubject(session, model);
        }
        if(subjectRepository.findById(subjectcode).isPresent()){
            model.addAttribute("error", "Subject code is existed");
            canAdd = false;
            return viewFormAddSubject(session, model);
        }
        if(!isValidSubjectName(subjectname)){
            model.addAttribute("error", "Subject name is invalid");
            canAdd = false;
            return viewFormAddSubject(session, model);
        }
        if(canAdd){
            Subject subject = new Subject(subjectcode, subjectname);
            superAdminSubjectManagementService.addSubject(subject);
            model.addAttribute("error", "Add subject successfully");
            return viewPage(session, model, 0, 25, null, null);
        }
        else {
            model.addAttribute("error", "Add subject failed");
            return viewFormAddSubject(session, model);
        }
    }
}
