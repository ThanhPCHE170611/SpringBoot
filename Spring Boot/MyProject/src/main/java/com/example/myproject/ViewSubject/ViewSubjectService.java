package com.example.myproject.ViewSubject;

import com.example.myproject.Class.ClassRepository;
import com.example.myproject.Subject.Subject;
import com.example.myproject.Subject.SubjectRepository;
import com.example.myproject.SubjectClass.SubjectClassRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

@Service
@AllArgsConstructor
public class ViewSubjectService {
    private final SubjectRepository subjectRepository;
    private final ClassRepository classRepository;
    private final SubjectClassRepository subjectClassRepository;

    public List<Subject> viewListSubject(Long classid) {
        List<Object[]> objects = subjectClassRepository.findAllSubjectsInClass(classid);
        List<Subject> subjects = new ArrayList<>();
        for (Object[] row : objects){
            BigInteger bigint = (BigInteger) row[0];
            Subject subject = new Subject(bigint.longValue(), (String) row[1]);
            subjects.add(subject);
        }
        return subjects;
    }
}
