package io.github.gasparbarancelli.blog.utils;

import org.springframework.context.MessageSource;
import org.springframework.context.NoSuchMessageException;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;

@Component
public class MessageUtil {

    private static MessageSource messageSource;

    private MessageUtil(MessageSource messageSource){
        MessageUtil.messageSource = messageSource;
    }

    public static String get(String id, Object... args) {
        try {
            return messageSource.getMessage(id, args, LocaleContextHolder.getLocale());
        } catch (NoSuchMessageException e) {
            return id;
        }
    }
}
