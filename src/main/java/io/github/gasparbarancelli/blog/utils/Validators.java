package io.github.gasparbarancelli.blog.utils;

import java.util.regex.Pattern;

public class Validators {

    public static boolean isEmailValid(String email) {
        var emailValidationregex = "^(.+)@(.+)$";
        var pattern = Pattern.compile(emailValidationregex);
        return pattern.matcher(email).matches();
    }
}
