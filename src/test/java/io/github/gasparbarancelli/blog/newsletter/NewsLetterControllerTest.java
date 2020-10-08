package io.github.gasparbarancelli.blog.newsletter;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;

@ExtendWith(MockitoExtension.class)
public class NewsLetterControllerTest {

    private static final String EMAIL = "jvrc2000@outlook.com";

    @InjectMocks private NewsLetterController newsLetterController;

    @Mock private NewsLetterService newsLetterService;

    @Test
    @DisplayName("make sure the subscribe new user in service is called")
    public void subscribeServiceIsCalled() {
        newsLetterController.subscribe(EMAIL);
        verify(newsLetterService).save(any(NewsLetter.class));
    }

    @Test
    @DisplayName("make sure that when removing a user the service is called")
    public void unsubscribeServiceIsCalled() {
        newsLetterController.unsubscribe(EMAIL);
        verify(newsLetterService).delete(any(NewsLetter.class));
    }

}
