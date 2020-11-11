package io.github.gasparbarancelli.blog.recommendation;

import java.util.List;

public interface RecommendationService {

    Recommendation newRecommendation(String subject);

    boolean addVoteById(Long id);

    List<Recommendation> findFirstFiveBeingVoted();
}
