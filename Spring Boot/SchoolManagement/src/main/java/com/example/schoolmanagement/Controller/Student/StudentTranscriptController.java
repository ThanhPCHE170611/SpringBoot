package com.example.schoolmanagement.Controller.Student;

import com.example.schoolmanagement.Model.*;
import com.example.schoolmanagement.Repository.SemesterRepository;
import com.example.schoolmanagement.Repository.StudentTranscriptRepository;
import com.example.schoolmanagement.Service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@AllArgsConstructor
public class StudentTranscriptController {

    private SemesterRepository semesterRepository;
    private StudentTranscriptRepository studentTranscriptRepository;
    private UserService userService;

    @GetMapping(path = "/student/studenttranscript")
    public String getAllSemester(HttpSession session, Model model){
        Users student = (Users) session.getAttribute("user");
        //get all the semester of database
        List<Semester> semesters = new ArrayList<>();
        //check if the student have transcript of that semester or not
        List<StudentTranscript> studentTranscripts = studentTranscriptRepository.findAllByStudent(student);
        for (StudentTranscript studentTranscript : studentTranscripts){
            semesters.add(studentTranscript.getSemester());
        }
        for (int i = 0; i< semesters.size() - 1; i++){
            if(semesters.get(i).getId() == semesters.get(i+1).getId()){
                semesters.remove(i);
            }
        }
        model.addAttribute("semesters", semesters);
        return "studenttranscript";
    }

    @GetMapping("/student/studenttranscript/{semesterId}")
    public String showStudentSubjectList(@PathVariable Long semesterId, Model model, HttpSession session) {
        Users student =(Users) session.getAttribute("user");
        List<Semester> semesters = new ArrayList<>();
        //check if the student have transcript of that semester or not
        List<StudentTranscript> studentTranscripts = studentTranscriptRepository.findAllByStudent(student);
        for (StudentTranscript studentTranscript : studentTranscripts){
            semesters.add(studentTranscript.getSemester());
        }
        for (int i = 0; i< semesters.size() - 1; i++){
            if(semesters.get(i).getId() == semesters.get(i+1).getId()){
                semesters.remove(i);
            }
        }
        model.addAttribute("semesters", semesters);
        List<Subject> subjects = new ArrayList<>();
        for (StudentTranscript studentTranscript : studentTranscripts){
            if(studentTranscript.getSemester().getId() == semesterId && studentTranscript.getSubject().getStatus().equals("active")){
                subjects.add(studentTranscript.getSubject());
            }
        }
        model.addAttribute("semesterid", semesterId);
        model.addAttribute("subjects", subjects);
        return "studenttranscript";
    }
    @GetMapping("/student/studenttranscript/{semesterId}/{subjectId}")
    public String getStudentTranscript(@PathVariable Long semesterId, @PathVariable String subjectId , Model model, HttpSession session) {
        Users student =(Users) session.getAttribute("user");
        List<Semester> semesters = new ArrayList<>();
        //check if the student have transcript of that semester or not
        List<StudentTranscript> studentTranscripts = studentTranscriptRepository.findAllByStudent(student);
        for (StudentTranscript studentTranscript : studentTranscripts){
            semesters.add(studentTranscript.getSemester());
        }
        for (int i = 0; i< semesters.size() - 1; i++){
            if(semesters.get(i).getId() == semesters.get(i+1).getId()){
                semesters.remove(i);
            }
        }
        model.addAttribute("semesters", semesters);
        List<Subject> subjects = new ArrayList<>();
        for (StudentTranscript studentTranscript : studentTranscripts){
            if(studentTranscript.getSemester().getId() == semesterId && studentTranscript.getSubject().getStatus().equals("active")){
                subjects.add(studentTranscript.getSubject());
            }
        }
        model.addAttribute("subjects", subjects);
        model.addAttribute("semesterid", semesterId);

        // get subject mark
        List<List<Mark>> marks = new ArrayList<>();
        for (StudentTranscript studentTranscript : studentTranscripts){
            if(studentTranscript.getSemester().getId() ==  semesterId &&
                    studentTranscript.getSubject().getSubjectcode().equals(subjectId)){
                marks.add(studentTranscript.getMarks());
            }
        }
        double markAVG = 0;
        List<Mark> markList = new ArrayList<>();
        for (List<Mark> marks1 : marks){
            for (Mark mark : marks1){
                markList.add(mark);
                if(mark.getWeight()*10 == 1){
                    markAVG += mark.getMark()*0.1;
                } else if(mark.getWeight()*10 == 2){
                    markAVG += mark.getMark()*0.2;
                } else {
                    markAVG += mark.getMark()*0.3;
                }
            }
        }
//        if(markList.size() == 6){
//            userService.updateStudentMark(student, markAVG);
//        }
        model.addAttribute("markAVG", markAVG);
        model.addAttribute("marks", markList);
        return "studenttranscript";
    }

}
