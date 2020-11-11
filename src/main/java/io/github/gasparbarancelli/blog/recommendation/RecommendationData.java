package io.github.gasparbarancelli.blog.recommendation;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface RecommendationData extends JpaRepository<Recommendation, Long> {

    Optional<Recommendation> findBySubject(String subject);

    @Transactional
    @Modifying
    @Query("update Recommendation r set r.currentAmoutOfVotes = ?2 where r.id = ?1")
    int incrementVoteByRecommendationId(Long id, Integer currentAmoutOfVotes);

    @Query("select r from Recommendation r where r.recommendationDate >= ?1 and r.recommendationDate <= ?2 order by r.id")
    List<Recommendation> findFirstFiveBeingVoted(LocalDate fisrtDayOfTheWeek, LocalDate lastDayOfTheWeek, PageRequest pageRequest);
}
