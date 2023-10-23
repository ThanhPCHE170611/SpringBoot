package com.example.schoolmanagement.Service;

import com.example.schoolmanagement.Model.Mark;
import com.example.schoolmanagement.Model.StudentTranscript;
import com.example.schoolmanagement.Repository.MarkRepository;
import com.example.schoolmanagement.Repository.StudentTranscriptRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@AllArgsConstructor
public class GradeManagementService {
    private final StudentTranscriptRepository studentTranscriptRepository;
    private final MarkRepository markRepository;

    @Transactional
    public void updateStudentTranscript(StudentTranscript studentTranscript){
        List<Mark> markList = studentTranscript.getMarks();
        for (Mark mark : markList){
            Mark markinDb = markRepository.findById(mark.getId()).get();
            markinDb.setMark(mark.getMark());
        }
    }

    @Transactional
    public void addMarkToTranscript(StudentTranscript studentTranscript, List<Mark> allMark){
        StudentTranscript studentTranscriptInDb = studentTranscriptRepository.findById(studentTranscript.getId()).get();
        studentTranscriptInDb.setMarks(allMark);
    }
}
