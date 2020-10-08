package io.github.gasparbarancelli.blog.newsletter;

import org.springframework.data.jpa.repository.JpaRepository;

public interface NewsLetterData extends JpaRepository<NewsLetterSubscription, Long> {
}
