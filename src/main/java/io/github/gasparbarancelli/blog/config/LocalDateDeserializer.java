package io.github.gasparbarancelli.blog.config;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import io.github.gasparbarancelli.blog.utils.DateUtil;

import java.io.IOException;
import java.time.LocalDate;

public class LocalDateDeserializer extends JsonDeserializer<LocalDate> {

    @Override
    public LocalDate deserialize(JsonParser parser, DeserializationContext context) throws IOException {
        return toLocalDate(parser.getValueAsString());
    }

    public LocalDate toLocalDate(String value) {
        return DateUtil.toLocalDate(value);
    }

}
