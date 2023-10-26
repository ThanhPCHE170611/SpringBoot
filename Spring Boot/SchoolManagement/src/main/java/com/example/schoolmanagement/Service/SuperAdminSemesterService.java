package com.example.schoolmanagement.Service;

import com.example.schoolmanagement.Model.Semester;
import com.example.schoolmanagement.Model.TeacherClassSubject;
import com.example.schoolmanagement.Repository.SemesterRepository;
import com.example.schoolmanagement.Repository.TeacherClassSubjectRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@AllArgsConstructor
public class SuperAdminSemesterService {

    private final SemesterRepository semesterRepository;
    private final TeacherClassSubjectRepository teacherClassSubjectRepository;

    @Transactional
    public void createSemester(Semester semester) {
        Semester semesterInuse = semesterRepository.findFirstByOrderByIdDesc();
        List<TeacherClassSubject> teacherClassSubjectList = teacherClassSubjectRepository.findAll();
        for (TeacherClassSubject teacherClassSubject : teacherClassSubjectList) {
            teacherClassSubjectRepository.findById(teacherClassSubject.getId()).get().setStatus("deactive");
        }
        semesterRepository.save(semester);
    }
}
