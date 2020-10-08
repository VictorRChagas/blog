package io.github.gasparbarancelli.blog.newsletter;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("newsletter")
public class NewsLetterController {

    private final NewsLetterService newsLetterService;

    public NewsLetterController(NewsLetterService newsLetterService) {
        this.newsLetterService = newsLetterService;
    }

    /***
     * endpoint for registering users in the newsletter
     * @param email is used for creating a subscription
     * @return ResponseEntity with OK status on success and FORBIDDEN status on failure
     */
    @PostMapping("subscribe")
    public ResponseEntity<NewsLetter> subscribe(@RequestParam("email") String email) {
        var newsLetter = NewsLetter.of(email);
        var newsLetterSubscription = newsLetterService.subscribe(newsLetter);
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(newsLetterSubscription);
    }

    /***
     * endpoint for unregister users in the newsletter
     * @param email is used for delete a subscription
     * @return ResponseEntity with OK status on success and FORBIDDEN status on failure
     */
    @PostMapping("unsubscribe")
    public ResponseEntity<Boolean> unsubscribe(@RequestParam("email") String email) {
        var newsLetter = NewsLetter.of(email);
        var success = newsLetterService.unsubscribe(newsLetter);
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(success);
    }

}
