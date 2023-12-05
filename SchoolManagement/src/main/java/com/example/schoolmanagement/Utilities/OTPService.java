package com.example.schoolmanagement.Utilities;

import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

@Service
@AllArgsConstructor
public class OTPService {
    private static final Integer EXPIRATION = 3;
    private LoadingCache<String, Integer> otpCache;

    public OTPService(){
        super();
        otpCache = CacheBuilder.newBuilder()
                .expireAfterWrite(EXPIRATION, TimeUnit.MINUTES)
                .build(new CacheLoader<String, Integer>() {
                    @Override
                    public Integer load(String key) throws Exception {
                        return 0;
                    }
                });
    }
    public int generateOTP(String key){
        int otp = (int) (Math.random() * 900000) + 100000;
        otpCache.put(key, otp);
        return otp;
    }

    public int getOTP(String key){
        try{
            return otpCache.get(key);
        } catch (Exception e){
            return 0;
        }
    }

    public void clearOTP(String key){
        otpCache.invalidate(key);
    }

}
