package io.github.gasparbarancelli.blog.newsletter;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;

@ExtendWith(MockitoExtension.class)
public class NewsLetterServiceTest {

    private static final NewsLetter NEWS_LETTER = NewsLetter.of("jvrc2000@outlook.com");

    @InjectMocks private NewsLetterServiceImpl newsLetterService;

    @Mock private NewsLetterData newsLetterData;

    @Test
    @DisplayName("make sure the save is called in data layer")
    public void makeSureSaveIsCalled() {
        newsLetterService.save(NEWS_LETTER);
        verify(newsLetterData).save(any(NewsLetter.class));
    }

    @Test
    @DisplayName("make sure the delete is called in data layer")
    public void makeSureDeleteIsCalled() {
        newsLetterService.delete(NEWS_LETTER);
        verify(newsLetterData).deleteByEmail(any(String.class));
    }

    @Test
    @DisplayName("does not throw any execpton for valid emails")
    public void doesNotThrowsForValidEmails() {
        assertDoesNotThrow(() -> newsLetterService.save(NEWS_LETTER));
    }

}
