package com.example.schoolmanagement.Service;

import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@AllArgsConstructor
public class UserService {
    private final UserRepository userRepository;

    @Transactional
    public void updateStudentMark(Users student, double mark){
        Users studentInDb = userRepository.findById(student.getRollNumber()).get();
        studentInDb.setMarkAverage(mark);
    }
}
