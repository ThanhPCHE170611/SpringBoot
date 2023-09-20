package com.example.myproject.ChangeClass;

import com.example.myproject.Class.Class;
import com.example.myproject.Class.ClassRepository;
import com.example.myproject.ClassChangeRequest.ClassChangeRequest;
import com.example.myproject.ClassChangeRequest.ClassChangeRequestRepository;
import com.example.myproject.Student.Student;
import com.example.myproject.Student.StudentRepository;
import com.example.myproject.Subject.Subject;
import com.example.myproject.SubjectClass.SubjectClassRepository;
import com.example.myproject.ViewSubject.ViewSubjectService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@AllArgsConstructor
public class ChangeClassService {
    private final StudentRepository studentRepository;
    private final ClassRepository classRepository;
    private final ViewSubjectService viewSubjectService;
    private final ClassChangeRequestRepository classChangeRequestRepository;

    public boolean hasRequest(long id) {
        List<ClassChangeRequest> request = classChangeRequestRepository.findAllByStudentId(id);
        if(request.isEmpty()){
            return false;
        } else {
            int size = request.size();
            if(request.get(size-1).getStatus().equals("process")){
                return true;
            } else return false;
        }
    }

    public List<Class> listClassEnoughSlot(Class studentClass) {
        //create a list include other class:
        List<Class> tryClasses = classRepository.findAllByIdNotEqual(studentClass.getId());
        List<Class> result = new ArrayList<>();
        //check the number of student of each class:
        for (Class oneClass : tryClasses){
            int numberOfStudentInClass = studentRepository.findAllByStudentClassId(oneClass.getId()).size();
            if(numberOfStudentInClass <= 49)
                result.add(oneClass);
        }
        return result;
    }
    public List<Subject> getListOfSubjectInClass(Long classid){
        return viewSubjectService.viewListSubject(classid);
    }
    public Class getClassByClassName(String classname){
        return classRepository.findClassByClassname(classname).get();
    }

    @Transactional
    public void AddNewRequest(Long studentidL, Long oldclassid, Long newclassidL) {
        Student student = studentRepository.findById(studentidL).get();
        Class oldClass = classRepository.findById(oldclassid).get();
        Class newClass = classRepository.findById(newclassidL).get();
        ClassChangeRequest classChangeRequest = new ClassChangeRequest("process", student, oldClass,newClass);
        classChangeRequestRepository.save(classChangeRequest);
    }
    public List<ClassChangeRequest> listClassChangeRequest(){
        return classChangeRequestRepository.findAll();
    }
    @Transactional
    public void acceptRequest(Long id) {
        ClassChangeRequest classChangeRequest = classChangeRequestRepository.findById(id).get();
        classChangeRequest.setStatus("accepted");
        Student student = studentRepository.findById(classChangeRequest.getStudent().getId()).get();
        student.setStudentClass(classChangeRequest.getNewClass());
    }
}
