package com.example.schoolmanagement.Service;

import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@AllArgsConstructor
public class AuthService {

    private final UserRepository userRepository;

    @Transactional
    public void updatePassword(Users user) {
        Users userInDb = userRepository.findUsersByUsername(user.getUsername()).get();
        userInDb.setLastchangepassword(user.getLastchangepassword());
        userInDb.setPassword(user.getPassword());
    }


    @Transactional
    public void updateUserStatus(String usernameCheckLogin) {
        Users userInDb = userRepository.findUsersByUsername(usernameCheckLogin).get();
        userInDb.setStatus("deactive");
    }
}
