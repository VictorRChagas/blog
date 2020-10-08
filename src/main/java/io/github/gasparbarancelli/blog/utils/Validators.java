package io.github.gasparbarancelli.blog.utils;

import javax.validation.constraints.NotNull;
import java.util.regex.Pattern;

public class Validators {

    public static boolean isEmailValid(@NotNull String email) {
        var emailValidationRegex = "^(.+)@(.+)$";
        var pattern = Pattern.compile(emailValidationRegex);
        return pattern.matcher(email).matches();
    }

}
