package com.example.schoolmanagement.Model;

import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Table
@Entity
@Getter
@Setter
public class Users implements UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private String rollNumber;

    private String username;
    private String password;
    private String email;

    //Orgarnizaion
    @ManyToOne
    @JoinColumn(name = "gender")
    private Gender gender;

    @ManyToOne
    @JoinColumn(name = "ethnic")
    private Ethnic ethnic;

    @ManyToOne
    @JoinColumn(name = "religion")
    private Religion religions;

    private String picture;
    private String hobbies;
    private String address;
    private String hometown;
    private String parrentName;
    private String status;
    @ManyToOne
    @JoinColumn(name = "teacher_roll_number")
    private Users teacher;
    private double markAverage;
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name="user_role", joinColumns = @JoinColumn(name ="rollnumber"),
            inverseJoinColumns = @JoinColumn(name="id"))
    private Set<Role> roles;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name="teacher_subject", joinColumns = @JoinColumn(name ="rollnumber"),
            inverseJoinColumns = @JoinColumn(name="subjectcode"))
    private Set<Subject> subjects;

    @OneToOne
    @JoinColumn(name = "teacher_class")
    private Class teacherclass;

    @ManyToOne
    @JoinColumn(name = "student_class")
    private Class studentclass;

    private Date lastchangepassword;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Set<GrantedAuthority> authorities = new HashSet<>();

        // Iterate through user roles and add them as authorities
        for (Role role : roles) {
            authorities.add(new SimpleGrantedAuthority("ROLE_" + role.getRolename().toUpperCase()));
        }
        return authorities;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
    @PrePersist
    public void prePersist() {
        this.lastchangepassword = new Date();
    }
}
