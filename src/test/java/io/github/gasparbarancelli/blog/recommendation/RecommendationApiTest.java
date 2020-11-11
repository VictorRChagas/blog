package io.github.gasparbarancelli.blog.recommendation;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.mockito.Mockito.verify;

@ExtendWith(MockitoExtension.class)
public class RecommendationApiTest {

    private static final String SUBJECT = "Algorithms";

    @InjectMocks
    private RecommendationApi recommendationApi;

    @Mock
    private RecommendationService recommendationService;

    @Test
    @DisplayName("make sure the method for creating a new recommendation in service is called")
    public void subscribeServiceIsCalled() {
        recommendationApi.newRecommendation(SUBJECT);
        verify(recommendationService).newRecommendation(SUBJECT);
    }
}
