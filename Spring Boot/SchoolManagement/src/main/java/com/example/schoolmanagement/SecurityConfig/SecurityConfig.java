package com.example.schoolmanagement.SecurityConfig;

import com.example.schoolmanagement.Provide.CustomAuthenticationProvider;
import com.example.schoolmanagement.Service.CustomeUserDetailService;
import lombok.AllArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import static org.springframework.security.config.Customizer.withDefaults;

@EnableWebSecurity
@Configuration
@AllArgsConstructor
public class SecurityConfig {

    private CustomAuthenticationProvider customAuthenticationProvider;
    private CustomeUserDetailService customeUserDetailService;
    @Bean
    @Lazy
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(12);
    }


    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        return http
                .authorizeHttpRequests(auth -> {
                    auth.antMatchers("/**").permitAll()
                            .antMatchers("/admin/**").hasRole("admin")
                            .antMatchers("/student/**").hasRole("student")
                            .antMatchers("/teacher/**").hasRole("teacher");
                    auth.anyRequest().authenticated();
                })
                .oauth2Login()
                .loginPage("/oauth2/authorization/google")
                .failureUrl("/auth/login?error=true")
                .defaultSuccessUrl("/user/welcome")
                .and()
                .formLogin()
                .loginPage("/auth/login")
                .failureUrl("/auth/login?error=true")
                .defaultSuccessUrl("/user/welcome")
                .permitAll()
                .and()
                .authenticationProvider(customAuthenticationProvider)
                .userDetailsService(customeUserDetailService)
                .build();
    }


}
