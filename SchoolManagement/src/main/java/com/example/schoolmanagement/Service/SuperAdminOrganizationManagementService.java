package com.example.schoolmanagement.Service;

import com.example.schoolmanagement.Model.Organization;
import com.example.schoolmanagement.Repository.OrganizationRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@AllArgsConstructor
public class SuperAdminOrganizationManagementService {

    private final OrganizationRepository organizationRepository;


    @Transactional
    public void createOrganization(Organization newWardOrganization) {
        organizationRepository.save(newWardOrganization);
    }

    @Transactional
    public void updateOrganization(Organization organization) {
        Organization schoolOrganization = organizationRepository.findById(organization.getId()).get();
        schoolOrganization.setSchoolname(organization.getSchoolname());
        schoolOrganization.setWardorganization(organization.getWardorganization());
        schoolOrganization.setStatus(organization.getStatus());
        schoolOrganization.setOperatingday(organization.getOperatingday());
    }

    public void createSchoolOrganization(Organization newSchool) {
        organizationRepository.save(newSchool);
    }
}
