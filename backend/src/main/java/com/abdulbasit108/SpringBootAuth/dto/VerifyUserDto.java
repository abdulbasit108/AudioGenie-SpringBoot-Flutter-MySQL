package com.abdulbasit108.SpringBootAuth.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VerifyUserDto {
    private String username;
    private String verificationCode;
}