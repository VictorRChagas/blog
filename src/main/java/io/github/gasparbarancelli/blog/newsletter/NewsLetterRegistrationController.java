package io.github.gasparbarancelli.blog.newsletter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/newsletter")
public class NewsLetterRegistrationController {

    @Autowired
    private NewsLetterService newsLetterService;

    /***
     * endpoint for registering users in the newsletter
     * @param email is used for creating a subscription
     */
    @PostMapping("/subscribe/{email}")
    public void subscribeInNewsLetter(@PathVariable("email") String email) {
        newsLetterService.subscribeNewUser(email);
    }
}
