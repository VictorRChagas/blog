package io.github.gasparbarancelli.blog.subscriptionTest;

import io.github.gasparbarancelli.blog.newsletter.NewsLetterData;
import io.github.gasparbarancelli.blog.newsletter.NewsLetterRegistrationController;
import io.github.gasparbarancelli.blog.newsletter.NewsLetterService;
import io.github.gasparbarancelli.blog.newsletter.NewsLetterSubscription;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class SubscriptionControllerTest {

    @InjectMocks
    private NewsLetterRegistrationController newsLetterRegistrationController;

    @Mock
    private NewsLetterService newsLetterService;

    @Mock
    private NewsLetterData newsLetterData;

    private final String email = "jvrc2000@outlook.com";

    @Test
    @DisplayName("make sure the subscribe new user in service is called")
    private void makeSureServiceIsCalled() {
        newsLetterRegistrationController.subscribeInNewsLetter(email);

        newsLetterService.subscribeNewUser(email);
    }

    @Test
    @DisplayName("make sure the save is called in data layer")
    private void makeSureSaveIsCalled() {
        newsLetterService.subscribeNewUser(email);

        newsLetterData.save(new NewsLetterSubscription(email));
    }
}
