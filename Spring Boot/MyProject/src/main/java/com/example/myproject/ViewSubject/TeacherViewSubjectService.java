package com.example.myproject.ViewSubject;

import com.example.myproject.Subject.Subject;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class TeacherViewSubjectService {
    private final ViewSubjectService viewSubjectService;
    public List<Subject> viewListSubject(long classid){
        return viewSubjectService.viewListSubject(classid);
    }
}
