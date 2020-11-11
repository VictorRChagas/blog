package io.github.gasparbarancelli.blog.recommendation;

import io.github.gasparbarancelli.blog.utils.StringUtils;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import javax.validation.constraints.NotNull;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;
import java.util.Objects;

@Service
public class RecommendationServiceImpl implements RecommendationService {

    private RecommendationData recommendationData;

    public RecommendationServiceImpl(RecommendationData recommendationData) {
        this.recommendationData = recommendationData;
    }

    @Override
    public Recommendation newRecommendation(@NotNull String subject) {
        var reccomendation = Recommendation.of(StringUtils.removeSequentialBlankSpace(subject));
        recommendationData.findBySubject(subject).ifPresentOrElse(recommendation -> {
            throw new IllegalArgumentException("Recommendation already submitted!");
        }, () -> recommendationData.save(reccomendation));
        return reccomendation;
    }

    @Override
    public boolean addVoteById(@NotNull Long id) {
        Objects.requireNonNull(id, "id must not be null!");
        var recommendationOptional = recommendationData.findById(id);
        if (recommendationOptional.isPresent()) {
            var updatedVotes = recommendationOptional.get().getCurrentAmoutOfVotes() + 1;
            return recommendationData.incrementVoteByRecommendationId(id, updatedVotes) == 1;
        }
        return false;
    }

    @Override
    public List<Recommendation> findFirstFiveBeingVoted() {
        var fisrtDayOfTheWeek = LocalDate.now().with(DayOfWeek.MONDAY);
        var lastDayOfTheWeek = LocalDate.now().with(DayOfWeek.SUNDAY);
        return recommendationData.findFirstFiveBeingVoted(fisrtDayOfTheWeek, lastDayOfTheWeek, PageRequest.of(0, 5));
    }

    public void removeAllPreviousRecommendations() {
        // todo - remove all the previous recommendations of the previous week
    }
}
