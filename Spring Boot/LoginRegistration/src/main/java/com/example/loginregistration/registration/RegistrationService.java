package com.example.loginregistration.registration;

import com.example.loginregistration.appuser.AppUser;
import com.example.loginregistration.appuser.AppUserRole;
import com.example.loginregistration.appuser.AppUserService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class RegistrationService {
    private EmailValidator emailValidator;
    private final AppUserService appUserService;
    public String register(RegistrationRequest request) {
        boolean isValidEmail = emailValidator.test(request.getEmail());
        if(!isValidEmail) throw new IllegalStateException("Email not valid");
        return appUserService.signUpUser(new AppUser(
                request.getName(), request.getUsername(), request.getPassword()
                ,request.getEmail(), AppUserRole.User, false,true
        ));
    }
}
