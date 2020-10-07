package io.github.gasparbarancelli.blog.newsletter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Objects;

@Service
public class NewLetterServiceImpl implements NewsLetterService {

    @Autowired
    private NewsLetterData newsLetterData;

    /***
     * save new subscription
     */
    @Override
    public void subscribeNewUser(String email) {
        Objects.requireNonNull(email, "email must not be null!");
        if (email.isBlank()) {
            throw new IllegalArgumentException("email must not be empty");
        }
        newsLetterData.save(new NewsLetterSubscription(email));
    }
}
