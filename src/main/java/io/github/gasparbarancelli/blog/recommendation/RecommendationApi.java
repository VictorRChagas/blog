package io.github.gasparbarancelli.blog.recommendation;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/recommendation")
public class RecommendationApi {

    private RecommendationService recommendationService;

    public RecommendationApi(RecommendationService recommendationService) {
        this.recommendationService = recommendationService;
    }

    /***
     * endpoint for submitting a new subject for being written about
     * @param subject is not null, necessary for instancing the object Recommendation
     * @return the saved object
     */
    @PostMapping
    public ResponseEntity<Recommendation> newRecommendation(@RequestParam("subject") String subject) {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(recommendationService.newRecommendation(subject));
    }

    /***
     * endpoint for adding a new vote for recommendation
     */
    @PostMapping("/vote/{id]")
    public ResponseEntity<Boolean> voteRecommendationById(@PathVariable Long id) {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(recommendationService.addVoteById(id));
    }

    /***
     * endpoint for listing the first five recommendatios about being voted
     */
    @GetMapping
    public ResponseEntity<List<Recommendation>> listFirstFiveRecommendationsSubmitted() {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(recommendationService.findFirstFiveBeingVoted());
    }
}
