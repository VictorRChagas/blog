package io.github.gasparbarancelli.blog.newsletter;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/newsletter")
public class NewsLetterApi {

    private final NewsLetterService newsLetterService;

    public NewsLetterApi(NewsLetterService newsLetterService) {
        this.newsLetterService = newsLetterService;
    }

    /***
     * endpoint for registering users in the newsletter
     * @param email is used for creating a subscription
     * @return ResponseEntity with OK status on success and FORBIDDEN status on failure
     */
    @PostMapping
    public ResponseEntity<NewsLetter> subscribe(@RequestParam("email") String email) {
        var newsLetter = NewsLetter.of(email);
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(newsLetterService.save(newsLetter));
    }

    /***
     * endpoint for unregister users in the newsletter
     * @param email is used for delete a subscription
     * @return ResponseEntity with OK status on success and FORBIDDEN status on failure
     */
    @DeleteMapping
    public ResponseEntity<Boolean> unsubscribe(@RequestParam("email") String email) {
        var newsLetter = NewsLetter.of(email);
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(newsLetterService.delete(newsLetter));
    }

}
