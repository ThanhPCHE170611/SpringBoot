package com.example.myproject.TeacherManager;

import com.example.myproject.AcountSetting.AccountSettingService;
import com.example.myproject.AcountSetting.AcountSettingController;
import com.example.myproject.Class.Class;
import com.example.myproject.Class.ClassRepository;
import com.example.myproject.Subject.Subject;
import com.example.myproject.Subject.SubjectRepository;
import com.example.myproject.SubjectClass.SubjectClass;
import com.example.myproject.SubjectClass.SubjectClassRepository;
import com.example.myproject.Teacher.Teacher;
import com.example.myproject.Teacher.TeacherRepository;
import com.example.myproject.Teacher.TeacherService;
import com.example.myproject.TeacherSubject.TeacherSubject;
import com.example.myproject.TeacherSubject.TeacherSubjectRepository;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

@Service
@AllArgsConstructor
public class TeacherManagerService {
    private final ClassRepository classRepository;
    private final TeacherRepository teacherRepository;
    private final SubjectRepository subjectRepository;
    private final TeacherSubjectRepository teacherSubjectRepository;
    private final SubjectClassRepository subjectClassRepository;
    private final PasswordEncoder passwordEncoder;
    public List<Teacher> viewListTeacher(){
        List<Teacher> teachers = new ArrayList<>();
        List<Object[]> data = teacherSubjectRepository.findAllTeacherCanAssignSubject();
        for (Object[] row : data){
            BigInteger bigint = (BigInteger) row[0];
            Teacher teacher = new Teacher(bigint.longValue(), (String) row[1]);
            teachers.add(teacher);
        }
        return teachers;
    }

    public List<Subject> viewListSubject(long teacherid) {
        List<Subject> subjects = new ArrayList<>();
        List<Object[]> data = teacherSubjectRepository.getOtherSubjets(teacherid);
        for (Object[] row : data){
            BigInteger bigint = (BigInteger) row[0];
            Subject subject = new Subject(bigint.longValue(), (String) row[1]);
            subjects.add(subject);
        }
        return subjects;
    }

    @Transactional
    public void createNewTeacherSubject(long teacherid, long subjectid) {
        Teacher teacher = teacherRepository.findById(teacherid).get();
        Subject subject = subjectRepository.findById(subjectid).get();
        TeacherSubject teacherSubject = new TeacherSubject(teacher, subject);
        teacherSubjectRepository.save(teacherSubject);
    }

    public List<SubjectClass> findBySubjectId(long subjectid) {
        return subjectClassRepository.findAllBySubjectId(subjectid);
    }

    public List<Class> findAllClass() {
        return classRepository.findAll();
    }

    @Transactional
    public void createNewSubjectClass(long subjectid, long classid) {
        Subject subject = subjectRepository.findById(subjectid).get();
        Class aClass = classRepository.findById(classid).get();
        SubjectClass subjectClass = new SubjectClass(subject, aClass);
        subjectClassRepository.save(subjectClass);
    }

    public String teacherValidateData(String name, String username,String password, String confirmpassword, String gender, Model model) {
        if (name == null || !name.matches("^[A-Z][a-zA-Z]{3,}$")) {
            model.addAttribute("name", name);
            model.addAttribute("username", username);
            model.addAttribute("password", password);
            model.addAttribute("confirmpassword", confirmpassword);
            model.addAttribute("gender", gender);
            return "Name must start with an uppercase letter and be at least 4 characters long and dont have any number and speical chars.";
        }

        // Check username
        if (username == null || !username.matches("^[a-zA-Z0-9]{4,}$")) {
            model.addAttribute("name", name);
            model.addAttribute("username", username);
            model.addAttribute("password", password);
            model.addAttribute("confirmpassword", confirmpassword);
            model.addAttribute("gender", gender);
            return "Username must be at least 4 characters long and contain only letters and numbers.";
        }
        if(teacherRepository.findTeacherByUsername(username).isPresent()){
            model.addAttribute("name", name);
            model.addAttribute("username", username);
            model.addAttribute("password", password);
            model.addAttribute("confirmpassword", confirmpassword);
            model.addAttribute("gender", gender);
            return "Username is exist!";
        }

        // Check password and confirmpassword
        if (password == null || confirmpassword == null || !password.equals(confirmpassword)) {
            model.addAttribute("name", name);
            model.addAttribute("username", username);
            model.addAttribute("password", password);
            model.addAttribute("confirmpassword", confirmpassword);
            model.addAttribute("gender", gender);
            return "Password and Confirm Password must match.";
        }

        if (password.length() < 4) {
            model.addAttribute("name", name);
            model.addAttribute("username", username);
            model.addAttribute("password", password);
            model.addAttribute("confirmpassword", confirmpassword);
            model.addAttribute("gender", gender);
            return "Password must be at least 4 characters long.";
        }

        if (!password.matches("^[a-zA-Z0-9]+$")) {
            model.addAttribute("name", name);
            model.addAttribute("username", username);
            model.addAttribute("password", password);
            model.addAttribute("confirmpassword", confirmpassword);
            model.addAttribute("gender", gender);
            return "Password must contain only letters and numbers.";
        }

        // Check gender
        if (gender == null) {
            model.addAttribute("name", name);
            model.addAttribute("username", username);
            model.addAttribute("password", password);
            model.addAttribute("confirmpassword", confirmpassword);
            model.addAttribute("gender", gender);
            return "Please select a gender.";
        }
        return null; // No validation errors
    }

    @Transactional
    public void saveTeacher(Teacher teacher) {
        String encodePassword = passwordEncoder.encode(teacher.getPassword());
        teacher.setPassword(encodePassword);
        teacherRepository.save(teacher);
    }
}
