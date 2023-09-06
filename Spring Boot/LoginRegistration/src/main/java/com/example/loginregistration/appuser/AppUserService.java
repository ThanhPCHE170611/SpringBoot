package com.example.loginregistration.appuser;

import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class AppUserService implements UserDetailsService {
    private final static String User_Not_Found = "user with email %s not found";
    private final AppUserRepository appuserrepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        return appuserrepository.findByEmail(email).orElseThrow(() -> new UsernameNotFoundException(String.format(User_Not_Found, email)));
    }

    public String signUpUser(AppUser appUser){
        boolean exist = appuserrepository.findByEmail(appUser.getEmail()).isPresent();
        if(exist) throw new IllegalStateException("Email taken");
        String encodePassword = bCryptPasswordEncoder.encode(appUser.getPassword());
        appUser.setPassword(encodePassword);
        // ToDo: Send confirmation token
        appuserrepository.save(appUser);
        return "it works";
    }
}
