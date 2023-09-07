package com.example.thymeleafproject.Security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                // Define security rules for HTTP requests
                .authorizeRequests()
                // Allow unrestricted access to URLs starting with "/public/"
                .antMatchers("/**").permitAll()
                // Require authentication for all other requests
                .anyRequest().authenticated();
    }

    // Define a bean for the PasswordEncoder (used for password hashing and verification)
    @Bean
    public PasswordEncoder passwordEncoder() {
        // Create and return an instance of BCryptPasswordEncoder
        return new BCryptPasswordEncoder();
    }
}
