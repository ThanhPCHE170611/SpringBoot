package com.example.schoolmanagement.Service;

import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@AllArgsConstructor
@Service
public class CustomeUserDetailService implements UserDetailsService {
    private final UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        System.out.println(username);
        Optional<Users> userOptional = userRepository.findUsersByUsername(username);

        // Check if the userOptional has a value
        if (userOptional.isPresent()) {
            Users user = userOptional.get();
            // Create and return UserDetails based on the user data
            return User.builder()
                    .username(user.getUsername())
                    .password(user.getPassword()) // You might want to apply a PasswordEncoder here
                    .authorities(user.getAuthorities())
                    .build();
        } else {
            throw new UsernameNotFoundException("User not found with username: " + username);
        }
    }
}
