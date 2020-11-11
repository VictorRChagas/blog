package io.github.gasparbarancelli.blog.recommendation;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertThrows;

public class RecommendationTest {

    private static final String SUBJECT = "Data Structures";

    @Test
    @DisplayName("create new instance properly")
    public void createNewInstance() {
        var recommendation = Recommendation.of(SUBJECT);
        Assertions.assertNull(recommendation.getId());
        Assertions.assertEquals(SUBJECT, recommendation.getSubject());
    }

    @Test
    @DisplayName("make sure empty subject is not allowed")
    public void throwsExceptionIfEmptySubject() {
        assertThrows(IllegalArgumentException.class, () -> Recommendation.of(""));
    }

    @Test
    @DisplayName("make sure null subjects cannot instanciate new recoomendation")
    public void throwsExceptionIfNullSubject() {
        assertThrows(IllegalArgumentException.class, () -> Recommendation.of(null));
    }
}
