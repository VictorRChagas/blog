package io.github.gasparbarancelli.blog.config;

import io.github.gasparbarancelli.blog.utils.MessageUtil;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.Optional;

@ControllerAdvice
public class ExceptionHandlerAdvice {

    private static final String DATABASE_SCHEMA = "PUBLIC.";
    private static final int DATABASE_SCHEMA_LENGTH = DATABASE_SCHEMA.length();
    private static final String UNIQUE_INDEX_SUFFIX = "_INDEX";

    @ExceptionHandler(Exception.class)
    public ResponseEntity<String> handleException(Exception e) {
        return ResponseEntity
                .status(HttpStatus.FORBIDDEN)
                .body(e.getMessage());
    }

    @ExceptionHandler(DataIntegrityViolationException.class)
    public ResponseEntity<String> handleConstraintViolationException(DataIntegrityViolationException e) {
        return Optional.ofNullable(e.getMessage())
                .map(it -> it.substring(
                        it.indexOf(DATABASE_SCHEMA) + DATABASE_SCHEMA_LENGTH,
                        it.indexOf(UNIQUE_INDEX_SUFFIX)
                ))
                .map(MessageUtil::get)
                .map(it -> ResponseEntity.status(HttpStatus.FORBIDDEN).body(it))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.FORBIDDEN).body(e.getCause().getMessage()));
    }

}
