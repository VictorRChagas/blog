package io.github.gasparbarancelli.blog.recommendation;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;

@ExtendWith(MockitoExtension.class)
public class RecommendationServiceTest {

    private static final String SUBJECT = "System Design";

    @InjectMocks
    private RecommendationServiceImpl recommendationService;

    @Mock
    private RecommendationData recommendationData;

    @Test
    @DisplayName("make sure the save is called in data layer")
    public void makeSureSaveIsCalled() {
        recommendationService.newRecommendation(SUBJECT);
        verify(recommendationData).save(any(Recommendation.class));
    }

    @Test
    @DisplayName("does not throw any execpton for valid subjects")
    public void doesNotThrowsForValidSubjects() {
        assertDoesNotThrow(() -> recommendationService.newRecommendation(SUBJECT));
    }

    @Test
    @DisplayName("throw execpton for invalid subjects")
    public void throwsForInvalidSubjects() {
        assertThrows(IllegalArgumentException.class, () -> recommendationService.newRecommendation("  "));
    }
}
