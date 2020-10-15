package io.github.gasparbarancelli.blog.config;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import io.github.gasparbarancelli.blog.utils.DateUtil;

import java.io.IOException;
import java.time.LocalDate;

public class LocalDateSerializer extends JsonSerializer<LocalDate> {

    @Override
    public void serialize(LocalDate value, JsonGenerator generator, SerializerProvider serializers) throws IOException {
        generator.writeString(toString(value));
    }

    public String toString(LocalDate value) {
        return DateUtil.toString(value);
    }

}
