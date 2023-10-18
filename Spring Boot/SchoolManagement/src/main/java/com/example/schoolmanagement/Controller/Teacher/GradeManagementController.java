package com.example.schoolmanagement.Controller.Teacher;

import com.example.schoolmanagement.Model.*;
import com.example.schoolmanagement.Model.Class;
import com.example.schoolmanagement.Repository.*;
import com.example.schoolmanagement.Service.GradeManagementService;
import lombok.AllArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.awt.print.Pageable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

@Controller
@AllArgsConstructor
public class GradeManagementController {

    private final TeacherClassSubjectRepository teacherClassSubjectRepository;
    private final UserRepository userRepository;
    private final ClassRepository classRepository;
    private final SemesterRepository semesterRepository;
    private final SubjectRepository subjectRepository;
    private final StudentTranscriptRepository studentTranscriptRepository;
    private final MarkRepository markRepository;
    private final GradeManagementService gradeManagementService;

    @GetMapping(path = "/teacher/grademanagement")
    public String getAllClass(HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        } else {
            Users teacher = (Users) session.getAttribute("user");
            // List all the class that teacher teach
            List<TeacherClassSubject> teacherClassSubjects = teacherClassSubjectRepository.findAllByTeacher_RollNumber(teacher.getRollNumber());
            List<Class> classes = new ArrayList<>();
            HashSet<Long> set = new HashSet<>();
            //remove duplicate class:
            for (TeacherClassSubject notCheckClass : teacherClassSubjects) {
                if (set.add(notCheckClass.getClassTeaching().getId())) {
                    classes.add(notCheckClass.getClassTeaching());
                }
            }
            model.addAttribute("classes", classes);
            return "teachergrademanagement";
        }
    }

    @GetMapping(path = "/teacher/grademanagement/{classid}")
    public String getAllSubjectInClass(@PathVariable Long classid, HttpSession session, Model model){
        Users teacher = (Users) session.getAttribute("user");
        // List all the class that teacher teach
        List<TeacherClassSubject> teacherClassSubjects = teacherClassSubjectRepository.findAllByTeacher_RollNumber(teacher.getRollNumber());
        List<Class> classes = new ArrayList<>();
        HashSet<Long> set = new HashSet<>();
        //remove duplicate class:
        for (TeacherClassSubject notCheckClass : teacherClassSubjects) {
            if (set.add(notCheckClass.getClassTeaching().getId())) {
                classes.add(notCheckClass.getClassTeaching());
            }
        }
        model.addAttribute("classes", classes);
        set.clear();
        List<Subject> subjects = new ArrayList<>();
        for (TeacherClassSubject notCheckClass : teacherClassSubjects) {
            if (notCheckClass.getClassTeaching().getId() == classid) {
                subjects.add(notCheckClass.getSubjectTeaching());
            }
        }
        model.addAttribute("subjects", subjects);
        return "teachergrademanagement";
    }

    @GetMapping(path = "/teacher/grademanagement/{classid}/{subjectcode}")
    public String getAllStudentInClass(@PathVariable Long classid, @PathVariable String subjectcode, HttpSession session, Model model){
        Users teacher = (Users) session.getAttribute("user");
        // List all the class that teacher teach
        List<TeacherClassSubject> teacherClassSubjects = teacherClassSubjectRepository.findAllByTeacher_RollNumber(teacher.getRollNumber());
        List<Class> classes = new ArrayList<>();
        HashSet<Long> set = new HashSet<>();
        //remove duplicate class:
        for (TeacherClassSubject notCheckClass : teacherClassSubjects) {
            if (set.add(notCheckClass.getClassTeaching().getId())) {
                classes.add(notCheckClass.getClassTeaching());
            }
        }
        model.addAttribute("classes", classes);
        set.clear();
        List<Subject> subjects = new ArrayList<>();
        for (TeacherClassSubject notCheckClass : teacherClassSubjects) {
            if (notCheckClass.getClassTeaching().getId() == classid) {
                subjects.add(notCheckClass.getSubjectTeaching());
            }
        }
        model.addAttribute("subjects", subjects);
        // List all Student in the Class
        List<Users> allStudent = userRepository.findAllBystudentclass(classRepository.findById(classid).get().getId(), "active");
        List<Users> students =  new ArrayList<>();
        for (Users student : allStudent){
            if(student.getStatus().equals("active"))
                students.add(student);
        }
        model.addAttribute("students", students);
        return "teachergrademanagement";
    }
    @GetMapping(path = "/teacher/grademanagement/{classid}/{subjectcode}/{rollnumber}")
    public String updateStudentGrade(@PathVariable String rollnumber ,@PathVariable Long classid, @PathVariable String subjectcode, HttpSession session, Model model){
        Users student = userRepository.findById(rollnumber).get();
        Semester semester = semesterRepository.findFirstByOrderByIdDesc();
        Subject subject = subjectRepository.findById(subjectcode).get();
        List<StudentTranscript> studentTranscripts = studentTranscriptRepository.findAllByStudent(student);
        List<StudentTranscript> transcriptsInfo = new ArrayList<>();
        List<Mark> mark1 = new ArrayList<>(3);
        List<Mark> mark2 = new ArrayList<>(2);
        List<Mark> mark3 = new ArrayList<>(1);
        for (StudentTranscript studentTranscript : studentTranscripts){
            if(studentTranscript.getSemester().getId() == semester.getId() &&
            studentTranscript.getSubject().getSubjectcode().equals(subjectcode)){
                transcriptsInfo.add(studentTranscript);
            }
        }
        if(transcriptsInfo.size() != 0) {
            List<List<Mark>> marks = new ArrayList<>();
            for (StudentTranscript studentTranscript : studentTranscripts) {
                if (studentTranscript.getSemester().getId() == semester.getId() &&
                        studentTranscript.getSubject().getSubjectcode().equals(subjectcode)) {
                    marks.add(studentTranscript.getMarks());
                }
            }
            for (List<Mark> marks1 : marks) {
                for (Mark mark : marks1) {
                    if (mark.getWeight() * 10 == 1) {
                        mark1.add(mark);
                    } else if (mark.getWeight() * 10 == 2) {
                        mark2.add(mark);
                    } else {
                        mark3.add(mark);
                    }
                }
            }
        } else {
            Mark temp = new Mark(0,0);
            mark1.add(temp);
            mark1.add(temp);
            mark1.add(temp);
            mark2.add(temp);
            mark2.add(temp);
            mark3.add(temp);
        }
        model.addAttribute("student", student);
        model.addAttribute("subject", subject);
        model.addAttribute("semester", semester);
        model.addAttribute("mark1", mark1);
        model.addAttribute("mark2", mark2);
        model.addAttribute("mark3", mark3);
        return "teacherupdatestudentgrade";
    }

    @PostMapping(path = "teacher/grademanagement")
    public String saveGradeForStudent(@RequestParam("factor1") List<String> factor1Values,
                               @RequestParam("factor2") List<String> factor2Values,
                               @RequestParam("factor3") List<String> factor3Values,
                                @RequestParam("rollnumber") String rollnumber, @RequestParam("classid") Long classid, @RequestParam("subject") String subjectcode, HttpSession session, Model model){
        List<Mark> marks1 = new ArrayList<>();
        List<Mark> marks2 = new ArrayList<>();
        List<Mark> marks3 = new ArrayList<>();
        //2 case: update or create more transcript -> each case
        //get the student transcript by student, semester and subject
        Users student = userRepository.findById(rollnumber).get();
        Semester semester = semesterRepository.findFirstByOrderByIdDesc();
        Subject subject = subjectRepository.findById(subjectcode).get();
        for (String mark : factor1Values){
            if(!isDouble(mark)){
                model.addAttribute("error", "Mark is wrong format!");
                return updateStudentGrade(rollnumber, classid, subjectcode, session, model);
            } else {
                Mark mark1 = new Mark(Double.parseDouble(mark), 0.1);
                marks1.add(mark1);
            }
        }
        for (String mark : factor2Values){
            if(!isDouble(mark)){
                model.addAttribute("error", "Mark is wrong format!");
                return updateStudentGrade(rollnumber, classid, subjectcode, session, model);
            }else {
                Mark mark2 = new Mark(Double.parseDouble(mark), 0.2);
                marks2.add(mark2);
            }
        }
        for (String mark : factor3Values){
            if(!isDouble(mark)){
                model.addAttribute("error", "Mark is wrong format!");
                return updateStudentGrade(rollnumber, classid, subjectcode, session, model);
            }else {
                Mark mark3 = new Mark(Double.parseDouble(mark), 0.3);
                marks3.add(mark3);
            }
        }
        StudentTranscript studentTranscript = studentTranscriptRepository.findByStudentSemesterAndSubject(student, semester, subject);
        // dont have transcript
        if(studentTranscript == null){
            studentTranscript = new StudentTranscript(student, semester, subject);
            studentTranscriptRepository.save(studentTranscript);
            markRepository.saveAll(marks1);
            markRepository.saveAll(marks2);
            markRepository.saveAll(marks3);
            List<Mark> allNewMark = markRepository.findTop6ByOrderByIdDesc();
            studentTranscript.setMarks(allNewMark);
        }
        // student_transcript exist -> update not create
        else {
            List<Mark> oldMarks = studentTranscript.getMarks();
            // update mark list
            int indexMark1 = 0, indexMark2 = 0;
            for (int i = 0; i < oldMarks.size(); i++){
                if(oldMarks.get(i).getWeight()*10 == 1){
                    oldMarks.set(i, new Mark(oldMarks.get(i).getId(), marks1.get(indexMark1).getMark(), 0.1));
                    indexMark1++;
                }else if (oldMarks.get(i).getWeight()*10 == 2){
                    oldMarks.set(i, new Mark(oldMarks.get(i).getId(), marks2.get(indexMark2).getMark(), 0.2));
                    indexMark2++;
                } else {
                    oldMarks.set(i, new Mark(oldMarks.get(i).getId(), marks3.get(0).getMark(), 0.3));
                }
            }

            for (Mark mark : oldMarks){
                System.out.println("Id: " + mark.getId());
                System.out.println("mark: " + mark.getMark());
                System.out.println("weight: " + mark.getWeight());
            }
            //set mark list to student transcript:
            studentTranscript.setMarks(oldMarks);
            gradeManagementService.updateStudentTranscript(studentTranscript);
        }
        return "redirect:/teacher/grademanagement/" + classid +"/"+ subjectcode;
    }
    private boolean isDouble(String dbString){
        try{
            double doubleNum = Double.parseDouble(dbString);
            if(doubleNum >= 0 && doubleNum <=10){
                return true;
            } else return false;
        } catch (Exception e){
            return false;
        }
    }
}
