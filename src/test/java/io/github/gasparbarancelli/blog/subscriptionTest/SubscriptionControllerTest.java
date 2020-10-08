package io.github.gasparbarancelli.blog.subscriptionTest;

import io.github.gasparbarancelli.blog.newsletter.*;
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
public class SubscriptionControllerTest {

    @InjectMocks
    private NewsLetterRegistrationController newsLetterRegistrationController;

    @InjectMocks
    private NewLetterServiceImpl newsLetterServiceImpl;

    @Mock
    private NewsLetterService newsLetterService;

    @Mock
    private NewsLetterData newsLetterData;

    private final String email = "jvrc2000@outlook.com";

    @Test
    @DisplayName("make sure the subscribe new user in service is called")
    public void makeSureServiceIsCalled() {
        newsLetterRegistrationController.subscribeInNewsLetter(email);
        verify(newsLetterService).subscribeNewUser(email);
    }

    @Test
    @DisplayName("make sure the save is called in data layer")
    public void makeSureSaveIsCalled() {
        newsLetterServiceImpl.subscribeNewUser(email);
        verify(newsLetterData).save(any(NewsLetterSubscription.class));
    }

    @Test
    @DisplayName("throw exception for invalid mails")
    public void thorwsIllegalArgumentExceptionIfEmailIsNotValid() {
        assertThrows(IllegalArgumentException.class, () -> newsLetterServiceImpl.subscribeNewUser("john"));
    }

    @Test
    @DisplayName("throw exception for invalid mails")
    public void thorwsIllegalArgumentExceptionIfEmailIsEmpty() {
        assertThrows(IllegalArgumentException.class, () -> newsLetterServiceImpl.subscribeNewUser(""));
    }

    @Test
    @DisplayName("does not throw any execpton for valid emails")
    public void doesNotThrowsForValidEmails() {
        assertDoesNotThrow(() -> newsLetterServiceImpl.subscribeNewUser("jvrc2000@outlook.com"));
    }
}
