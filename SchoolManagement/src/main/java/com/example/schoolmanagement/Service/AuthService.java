package com.example.schoolmanagement.Service;

import com.example.schoolmanagement.DTO.LoginDTO;
import com.example.schoolmanagement.Model.Role;
import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Provide.JwtTokenProvider;
import com.example.schoolmanagement.Repository.RoleRepository;
import com.example.schoolmanagement.Repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

import static org.checkerframework.checker.nullness.Opt.orElseThrow;

@Service
@AllArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final UserDetailsService userDetailsService;
    private final AuthenticationManager authenticationManager;
    private final JwtTokenProvider jwtTokenProvider;
    public String login(LoginDTO loginDTO) {

        Authentication authentication =
                authenticationManager.authenticate(
                        new UsernamePasswordAuthenticationToken(
                                loginDTO.getUsername(), loginDTO.getPassword()
                        )
                );

        return jwtTokenProvider.genarateToken(
                (UserDetails) authentication.getPrincipal()
        );
    }

    public void AddRoleToCurrentUser(String role){
        Role roleInDb = roleRepository.findRoleByrolename(role).orElseThrow(()-> new BadCredentialsException("Role not found"));
        String username =  (String)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users userInDb = userRepository.findUsersByUsername(username).get();
    }
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
