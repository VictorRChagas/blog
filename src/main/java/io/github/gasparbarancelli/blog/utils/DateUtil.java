package io.github.gasparbarancelli.blog.utils;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class DateUtil {

    private DateUtil() {

    }

    public static LocalDate toLocalDate(String value) {
        return LocalDate.parse(value, DateTimeFormatter.ISO_LOCAL_DATE);
    }

    public static String toString(LocalDate value) {
        return value.format(DateTimeFormatter.ISO_LOCAL_DATE);
    }

}
