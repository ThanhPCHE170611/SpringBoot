package com.example.schoolmanagement.Service;

import com.example.schoolmanagement.Model.Organization;
import com.example.schoolmanagement.Model.Subject;
import com.example.schoolmanagement.Model.TeacherClassSubject;
import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.SubjectRepository;
import com.example.schoolmanagement.Repository.TeacherClassSubjectRepository;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;

@Service
@AllArgsConstructor
public class SuperAdminSubjectManagementService {

    private final SubjectRepository subjectRepository;
    private final TeacherClassSubjectRepository teacherClassSubjectRepository;


    public Page<Subject> getSubjects(int page, int pageSize) {
        Pageable pageable =  PageRequest.of(page, pageSize);
        return subjectRepository.findAll(pageable);
    }

    public Page<Subject> getSubjectsWithCriteria(Specification<Subject> spec, Pageable page) {
        return subjectRepository.findAll(spec, page);
    }

    @Transactional
    public void deleteSubject(String subjectcode) {
        Subject subjectInDb = subjectRepository.findById(subjectcode).get();
        subjectInDb.setStatus("deactive");
    }

    @Transactional
    public void updateSubject(Subject subject) {
        Subject subjectInDb = subjectRepository.findById(subject.getSubjectcode()).get();
        subjectInDb.setSubjectname(subject.getSubjectname());
        subjectInDb.setStatus(subject.getStatus());
        subjectInDb.setOrganizations(subject.getOrganizations());
        //organization that have subject
        Set<Organization> organizationSet = subject.getOrganizations();
        //all the teacher class subject -> teacher in use teach the subject
        List<TeacherClassSubject> teacherClassSubjectList = teacherClassSubjectRepository.findAllBySubject_subjectcode(subjectInDb.getSubjectcode());

        for (TeacherClassSubject teacherClassSubject : teacherClassSubjectList){
            if(teacherClassSubject.getSubjectTeaching().getSubjectcode().equalsIgnoreCase(subject.getSubjectcode()) && !organizationSet.contains(teacherClassSubject.getTeacher().getSchoolOrganization()) &&!organizationSet.contains(teacherClassSubject.getClassTeaching().getClassOrganization())){
                teacherClassSubject.setStatus("deactive");
            }
        }
    }
}
