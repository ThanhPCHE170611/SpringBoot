package com.example.schoolmanagement.Controller.SuperAdmin;


import com.example.schoolmanagement.Model.*;
import com.example.schoolmanagement.Repository.CityRepository;
import com.example.schoolmanagement.Repository.DistrictRepository;
import com.example.schoolmanagement.Repository.OrganizationRepository;
import com.example.schoolmanagement.Repository.WardRepository;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.ArrayList;


@Controller
@RequestMapping("/superadmin/Organizationmanagement")
@AllArgsConstructor
public class SuperAdminOrganizationController {

    private final OrganizationRepository organizationRepository;
    private final CityRepository cityRepository;
    private final DistrictRepository districtRepository;
    private final WardRepository wardRepository;

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
            Specification<Users> spec = Specification.where(null);
            List<City> cities = cityRepository.findAll("active");
            List<District> districts = districtRepository.findAll("active");
            List<Ward> wards = wardRepository.findAll("active");
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
                System.out.println("ward :" + selectWard.getWardname());
                System.out.println("ward id :" + selectWard.getId());
                Organization wardOrganization = organizationRepository.findOrganizationByWardorganization(selectWard.getId(), "active");
                if(wardOrganization != null){
                    System.out.println("Get ward Organization successfully!");
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
            model.addAttribute("districts", districts);
            model.addAttribute("wards", wards);
            model.addAttribute("cityselect", city);
            model.addAttribute("districtselect", district);
            model.addAttribute("wardselect", ward);
            model.addAttribute("pageSizeParam", pageSize);
            return "superadminorganizationmanagement";
        }
    }

}
