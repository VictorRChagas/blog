package io.github.gasparbarancelli.blog.newsletter;

public interface NewsLetterService {

    NewsLetter save(NewsLetter newsLetter);

    boolean delete(NewsLetter newsLetter);

}
