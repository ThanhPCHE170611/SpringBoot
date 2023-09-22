package com.example.jwtspringboot.Auth;

import com.example.jwtspringboot.AppUser.AppUser;
import com.example.jwtspringboot.AppUser.AppUserRepository;
import com.example.jwtspringboot.Role.Role;
import com.example.jwtspringboot.Role.RoleRepository;
import lombok.AllArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Collection;
import java.util.Collections;

@Controller
@RequestMapping("/api/auth")
@AllArgsConstructor
public class AuthController {
    private final AuthenticationManager authenticationManager;
    private AppUserRepository appUserRepository;
    private RoleRepository roleRepository;
    private PasswordEncoder passwordEncoder;

    @PostMapping(path = "/register")
    public String register(@RequestBody RegisterDto registerDto){
        if(appUserRepository.existsAppUserByUsername(registerDto.getUsername())){
            return "/eror";
        }
        AppUser user = new AppUser();
        user.setUsername(registerDto.getUsername());
        user.setPassword(passwordEncoder.encode(registerDto.getPassword()));
        user.setEmail(registerDto.getEmail());
        Role role = roleRepository.findByName("USER").get();
        user.setRoles(Collections.singletonList(role));
        appUserRepository.save(user);
        return "/homepage";
    }
    @PostMapping(path = "/login")
    public String logIn(@RequestBody LoginDto logInDto){
        Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(logInDto.getUsername(), logInDto.getPassword()));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        return "homepage";
    }
}
