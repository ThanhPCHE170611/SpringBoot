package com.example.schoolmanagement.Provide;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Date;

import static io.jsonwebtoken.SignatureAlgorithm.HS512;

@Component
@AllArgsConstructor
public class JwtTokenProvider {
    private final SecretKey JWT_SECRET = Keys.hmacShaKeyFor(Decoders.BASE64.decode("helloXinchaoTatcaCacBanjkahsdkjasdjkahdkjahhqwuejahbkjhijwqjehkjqwekjqhwkjehwqkjekqhweqwkjehqwkjeq"));
    private final long JWT_EXPIRATION = 24 * 60 * 60 * 1000; // 1 ngày

    public String genarateToken(UserDetails userDetails) {
        Date now = new Date();
        Date dateExpire = new Date(now.getTime() + JWT_EXPIRATION);
        return Jwts.builder()
                .setSubject(userDetails.getUsername())
                .claim("roles", userDetails.getAuthorities()
                        .stream()
                        .map(a -> a.getAuthority())
                        .toList())
                .setIssuedAt(now)
                .setExpiration(dateExpire)
                .signWith(HS512, JWT_SECRET)
                .compact();
    }
    public String getUsernameFromJWT(String token) {
        return Jwts.parser()
                .setSigningKey(JWT_SECRET)
                .parseClaimsJws(token)
                .getBody()
                .getSubject();
    }

    public boolean validateToken(String token) {
        try {
            Jwts.parser().setSigningKey(JWT_SECRET).parseClaimsJws(token);
            return true;
        } catch (Exception ex) {
            return false;
        }
    }
}
