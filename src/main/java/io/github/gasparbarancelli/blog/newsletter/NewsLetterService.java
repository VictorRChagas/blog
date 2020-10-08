package io.github.gasparbarancelli.blog.newsletter;

public interface NewsLetterService {

    NewsLetter subscribe(NewsLetter newsLetter);

    boolean unsubscribe(NewsLetter newsLetter);

}
