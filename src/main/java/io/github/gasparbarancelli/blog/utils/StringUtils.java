package io.github.gasparbarancelli.blog.utils;

import java.text.Normalizer;
import java.util.regex.Pattern;

public class StringUtils {

    private StringUtils() {
    }

    public static String removeAccents(String value) {
        String nfdNormalizedString = Normalizer.normalize(value, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(nfdNormalizedString).replaceAll("");
    }

    public static String convertToUrlFormat(String value) {
        return removeAccents(value.trim().toLowerCase())
                .replace(" ", "-");
    }

    public static String removeSequentialBlankSpace(String value) {
        return removeAccents(value.trim()).replaceAll("\\s{2,}", " ");
    }

}
