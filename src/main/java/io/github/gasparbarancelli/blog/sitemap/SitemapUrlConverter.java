package io.github.gasparbarancelli.blog.sitemap;

import io.github.gasparbarancelli.blog.post.Post;

public class SitemapUrlConverter {

    private static final String BLOG_URL = "https://www.blog.com.br/";
    private static final String CHANGE_FREQUENCY = "monthly";
    private static final Double DEFAULT_PRIORITY = 0.8;

    public static SitemapUrl converter(Post post) {
        return SitemapUrl.of(
            BLOG_URL + post.getUrl(),
            post.getLastModified(),
            CHANGE_FREQUENCY,
            DEFAULT_PRIORITY
        );
    }

}
