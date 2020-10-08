package io.github.gasparbarancelli.blog.newsletter;

import org.springframework.stereotype.Service;

import javax.validation.constraints.NotNull;

@Service
public class NewsLetterServiceImpl implements NewsLetterService {

    private final NewsLetterData newsLetterData;

    public NewsLetterServiceImpl(NewsLetterData newsLetterData) {
        this.newsLetterData = newsLetterData;
    }

    @Override
    public NewsLetter subscribe(@NotNull NewsLetter newsLetter) {
        return newsLetterData.save(newsLetter);
    }

    @Override
    public boolean unsubscribe(@NotNull NewsLetter newsLetter) {
        return newsLetterData.deleteByEmail(newsLetter.getEmail()) == 1;
    }

}
