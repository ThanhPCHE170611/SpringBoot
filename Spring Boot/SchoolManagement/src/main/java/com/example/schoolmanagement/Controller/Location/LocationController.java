package com.example.schoolmanagement.Controller.Location;

import com.example.schoolmanagement.Model.City;
import com.example.schoolmanagement.Model.District;
import com.example.schoolmanagement.Model.Organization;
import com.example.schoolmanagement.Model.Ward;
import com.example.schoolmanagement.Repository.CityRepository;
import com.example.schoolmanagement.Repository.DistrictRepository;
import com.example.schoolmanagement.Repository.OrganizationRepository;
import com.example.schoolmanagement.Repository.WardRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Collections;
import java.util.List;

@Controller
@RequestMapping("/location")
@AllArgsConstructor
@ResponseBody
public class LocationController {

    private final CityRepository cityRepository;
    private final DistrictRepository districtRepository;
    private final WardRepository wardRepository;
    private final OrganizationRepository organizationRepository;

    @GetMapping(path="/getDistricts",produces = "application/json")
    public List<District> getDistrictsByCity(@RequestParam("city") String cityId) {
        City city = cityRepository.findById(Long.parseLong(cityId)).orElse(null);
        if (city != null) {
            return districtRepository.findByCity(city, "active");
        } else {
            return Collections.emptyList();
        }
    }

    @GetMapping(path = "/getWards",produces = "application/json")
    public List<Ward> getWardsByDistrict(@RequestParam("district") String districtId) {
        District district = districtRepository.findById(Long.parseLong(districtId)).orElse(null);
        if (district != null) {
            return wardRepository.findByDistrict(district, "active");
        } else {
            return Collections.emptyList();
        }
    }

    @GetMapping(path = "/getOrganizations",produces = "application/json")
    public List<Organization> getOrganizationsByWard(@RequestParam("ward") String wardId) {
        Ward ward = wardRepository.findById(Long.parseLong(wardId)).orElse(null);
        if (ward != null) {
            return organizationRepository.findAllByWardAndStatus(ward.getId(), "active");
        } else {
            return Collections.emptyList();
        }
    }

}
