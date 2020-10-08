package io.github.gasparbarancelli.blog.newsletter;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Set;

import static org.junit.jupiter.api.Assertions.assertThrows;

public class NewsLetterTest {

    private static final String EMAIL = "jvrc2000@outlook.com";

    @Test
    public void emptyConstructor() {
        Assertions.assertDoesNotThrow(NewsLetter::new);
    }

    @Test
    public void createNewInstance() {
        var newsLetter = NewsLetter.of(EMAIL);
        Assertions.assertNull(newsLetter.getId());
        Assertions.assertEquals(EMAIL, newsLetter.getEmail());
    }

    @Test
    public void uniqueByEmail() {
        var newsLetter1 = NewsLetter.of(EMAIL);
        var newsLetter2 = NewsLetter.of(EMAIL);
        assertThrows(IllegalArgumentException.class, () -> Set.of(newsLetter1, newsLetter2));
    }

    @Test
    @DisplayName("throw exception for invalid mails")
    public void thorwsIllegalArgumentExceptionIfEmailIsNotValid() {
        assertThrows(IllegalArgumentException.class, () -> NewsLetter.of("john"));
    }

    @Test
    @DisplayName("throw exception for invalid mails")
    public void thorwsIllegalArgumentExceptionIfEmailIsEmpty() {
        assertThrows(IllegalArgumentException.class, () -> NewsLetter.of(""));
    }

}
