package com.example.schoolmanagement.Controller.SuperAdmin;


import com.example.schoolmanagement.Model.*;
import com.example.schoolmanagement.Repository.CityRepository;
import com.example.schoolmanagement.Repository.DistrictRepository;
import com.example.schoolmanagement.Repository.OrganizationRepository;
import com.example.schoolmanagement.Repository.WardRepository;
import com.example.schoolmanagement.Service.SuperAdminOrganizationManagementService;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.*;


@Controller
@RequestMapping("/superadmin/Organizationmanagement")
@AllArgsConstructor
public class SuperAdminOrganizationController {

    private final OrganizationRepository organizationRepository;
    private final CityRepository cityRepository;
    private final DistrictRepository districtRepository;
    private final WardRepository wardRepository;
    private final SuperAdminOrganizationManagementService superAdminOrganizationManagementService;

    @GetMapping()
    public String viewPage(HttpSession session, Model model,
                           @RequestParam(value = "city", required = false) Long city,
                           @RequestParam(value = "district", required = false) Long district,
                           @RequestParam(value = "ward", required = false) Long ward,
                           @RequestParam(value = "page", defaultValue = "0") int page,
                           @RequestParam(value = "size", defaultValue = "10") int pageSize){
       //validate session
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        } else {
            Set<Organization> schoolSet = new HashSet();
            List<City> cities = cityRepository.findAll("active");
            if((district != null && district > 0 && ward == null)){
                District selectDistrict= districtRepository.findById(district).get();
                List<Ward> wardInDistrict = wardRepository.findByDistrict(selectDistrict, "active");
                for (Ward eachWard : wardInDistrict) {
                    Organization wardOrganization = organizationRepository.findOrganizationByWardorganization(eachWard.getId(), "active");
                    if(wardOrganization != null){
                        List<Organization> schoolOrganization = organizationRepository.findAllByWardAndStatus(wardOrganization.getId(), "active");
                        for (Organization eachSchool : schoolOrganization) {
                            schoolSet.add(eachSchool);
                        }
                    }
                }
            }
            else if(ward != null && ward > 0){
                Ward selectWard = wardRepository.findById(ward).get();
                Organization wardOrganization = organizationRepository.findOrganizationByWardorganization(selectWard.getId(), "active");
                if(wardOrganization != null){
                    List<Organization> schoolOrganization = organizationRepository.findAllByWardAndStatus(wardOrganization.getId(), "active");
                    for (Organization eachSchool : schoolOrganization) {
                        schoolSet.add(eachSchool);
                    }
                }
            }
            if(!schoolSet.isEmpty()){
                List<Organization> schoolList = new ArrayList<>(schoolSet);
                Pageable pageable = PageRequest.of(page, pageSize);
                int start = (int) pageable.getOffset();
                int end = (start + pageable.getPageSize()) > schoolList.size() ? schoolList.size() : (start + pageable.getPageSize());

                Page<Organization> organizations = new PageImpl<>(schoolList.subList(start, end), pageable, schoolList.size());
                model.addAttribute("organizations", organizations);
            }
            model.addAttribute("cities", cities);
            model.addAttribute("cityselect", city);
            model.addAttribute("districtselect", district);
            model.addAttribute("wardselect", ward);
            if(ward != null){
                model.addAttribute("wardObj", wardRepository.findById(ward).get());
            }
            model.addAttribute("pageSizeParam", pageSize);
            return "superadminorganizationmanagement";
        }
    }

    @GetMapping("/update/{organizationid}")
    public String viewFormUpdate(@RequestParam(value = "city", required = false) Long city,
                                 @RequestParam(value = "district", required = false) Long district,
                                 @RequestParam(value = "ward", required = false) Long ward,
                                 @PathVariable Long organizationid,
                                 HttpSession session, Model model){
        //validate session
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        } else {
            Organization organization = organizationRepository.findById(organizationid).get();
            List<City> cities = cityRepository.findAll("active");
            List<District> districts = districtRepository.findAll("active");
            List<Ward> wards = wardRepository.findAll("active");
            model.addAttribute("organization", organization);
            model.addAttribute("cityselect", city);
            model.addAttribute("districtselect", district);
            model.addAttribute("wardselect", ward);
            model.addAttribute("cities", cities);
            model.addAttribute("districts", districts);
            model.addAttribute("wards", wards);
            return "superadminorganizationupdate";
        }
    }

    @PostMapping("/update")
    public String updateSchool(@RequestParam Long city,
                               @RequestParam Long district,
                               @RequestParam Long ward,
                               @RequestParam Long schoolid,
                               @RequestParam String schoolname,
                               @RequestParam String status,
                               @RequestParam("operatingday") @DateTimeFormat(pattern = "yyyy-MM-dd") Date operatingDay,
                               HttpSession session, Model model){
        if(!isValidSchoolName(schoolname)){
            model.addAttribute("error", "School name is invalid!");
            return viewFormUpdate(city, district, ward, schoolid, session, model);
        }
        if(!status.equals("active") && !status.equals("deactive")){
            model.addAttribute("error", "Status is invalid!");
            return viewFormUpdate(city, district, ward, schoolid, session, model);
        }
        Organization organization = organizationRepository.findById(schoolid).get();
        organization.setStatus(status);
        organization.setSchoolname(schoolname);
        organization.setOperatingday(operatingDay);
        // change location of school organization
        if(ward != organization.getWardorganization().getWard().getId()){
            Organization wardOrganization = organizationRepository.findOrganizationByWardorganization(ward, "active");
            //check if the wardOrganization is not exist
            if(wardOrganization == null){
                Ward newWard = wardRepository.findById(ward).get();
                Organization newWardOrganization = new Organization(newWard);
                superAdminOrganizationManagementService.createOrganization(newWardOrganization);
                organization.setWardorganization(newWardOrganization);
                superAdminOrganizationManagementService.updateOrganization(organization);
            } else {
                organization.setWardorganization(wardOrganization);
                superAdminOrganizationManagementService.updateOrganization(organization);
            }
            model.addAttribute("error", "Update successfully!");
            return viewPage(session, model, city, district, ward, 0, 10);
        } else {
            model.addAttribute("error", "You must choose Ward for this school!");
            return viewFormUpdate(city, district, ward, schoolid, session, model);
        }
    }

    private boolean isValidSchoolName(String schoolname) {
        return schoolname.matches("^[\\p{L}\\s]+$");
    }

    @GetMapping("/addorganization/{wardid}")
    public String viewFormAddSchool(@PathVariable long wardid, HttpSession session, Model model){
        //validate session
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        } else {
            Ward ward = wardRepository.findById(wardid).get();
            model.addAttribute("ward", ward);
            return "superadminorganizationaddschool";
        }
    }

    @PostMapping("/addorganization")
    public String addOrganization(@RequestParam("ward") String wardid, @RequestParam String schoolcode, @RequestParam String schoolname,
                                  HttpSession session, Model model){
        Long ward = Long.parseLong(wardid);
        if(!isValidSchoolName(schoolname)){
            model.addAttribute("error", "School name is invalid!");
            return viewFormAddSchool(ward, session, model);
        }
        if(!isValidSchoolCode(schoolcode)){
            model.addAttribute("error", "School code is invalid!");
            return viewFormAddSchool(ward, session, model);
        }
        if(organizationRepository.findAllByschoolcode(schoolcode) != null && organizationRepository.findAllByschoolcode(schoolcode).size() > 0){
            model.addAttribute("error", "School code is already exist!");
            return viewFormAddSchool(ward, session, model);
        }
        Organization wardOrganization = organizationRepository.findOrganizationByWardorganization(ward, "active");
        //check if the wardOrganization is not exist
        if(wardOrganization == null){
            Ward newWard = wardRepository.findById(ward).get();
            Organization newWardOrganization = new Organization(newWard);
            superAdminOrganizationManagementService.createOrganization(newWardOrganization);
            Organization newSchool = new Organization(schoolcode, schoolname, newWardOrganization);
            superAdminOrganizationManagementService.createSchoolOrganization(newSchool);
            model.addAttribute("error", "Add successfully!");
            return viewPage(session, model, newWard.getDistrict().getCity().getId(), newWard.getDistrict().getId(), ward, 0, 10);
        } else {
            Organization newSchool = new Organization(schoolcode, schoolname, wardOrganization);
            Ward selectWard = wardRepository.findById(ward).get();
            superAdminOrganizationManagementService.createSchoolOrganization(newSchool);
            model.addAttribute("error", "Add successfully!");
            return viewPage(session, model, selectWard.getDistrict().getCity().getId(), selectWard.getDistrict().getId(), ward, 0, 10);
        }
    }

    private boolean isValidSchoolCode(String schoolcode) {
        return schoolcode.matches("^[A-Za-z0-9]+$");
    }

}
