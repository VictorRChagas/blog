package io.github.gasparbarancelli.blog.recommendation;

import com.google.common.base.Strings;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.time.LocalDate;

@Entity
@Table(name = "RECOMMENDATION")
public class Recommendation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @Column(name = "SUBJECT", length = 320, nullable = false, updatable = false)
    private String subject;

    @Column(name = "RECOMMENDATION_DATE", length = 320, nullable = false, updatable = false)
    private LocalDate recommendationDate;

    @Column(name = "VOTES")
    private Integer currentAmoutOfVotes;

    @Deprecated
    public Recommendation() {
    }

    private Recommendation(String subject, LocalDate recommendationDate) {
        if (Strings.isNullOrEmpty(subject)) {
            throw new IllegalArgumentException("subject must not be null or empty!");
        }
        this.subject = subject;
        this.recommendationDate = recommendationDate;
        this.currentAmoutOfVotes = 0;
    }

    public static Recommendation of(@NotNull String subject) {
        return new Recommendation(subject, LocalDate.now());
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public LocalDate getRecommendationDate() {
        return recommendationDate;
    }

    public void setRecommendationDate(LocalDate recommendationDate) {
        this.recommendationDate = recommendationDate;
    }

    public Integer getCurrentAmoutOfVotes() {
        return currentAmoutOfVotes;
    }

    public void setCurrentAmoutOfVotes(Integer currentAmoutOfVotes) {
        this.currentAmoutOfVotes = currentAmoutOfVotes;
    }
}
