package io.github.gasparbarancelli.blog.sitemap;

import io.github.gasparbarancelli.blog.post.Post;
import io.github.gasparbarancelli.blog.ui.PostController;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Arrays;
import java.util.List;
import java.util.ResourceBundle;
import java.util.Set;
import java.util.stream.Collectors;

public class SitemapUrlConverter {

    private static final String BLOG_URL;
    private static final SitemapFrequency CHANGE_FREQUENCY = SitemapFrequency.MONTHLY;
    private static final Double DEFAULT_PRIORITY = 0.8;
    private static final List<String> URL_POST_LIST;

    static {
        BLOG_URL = ResourceBundle.getBundle("application").getString("blog.url");

        var postMapping = PostController.class.getAnnotation(RequestMapping.class);
        if (postMapping.value().length > 0) {
            URL_POST_LIST = Arrays.asList(postMapping.value());
        } else {
            URL_POST_LIST = Arrays.asList(postMapping.path());
        }
    }

    public static Set<SitemapUrl> converter(Post post) {
        return URL_POST_LIST.stream()
                .map(it -> SitemapUrl.of(
                        getUrlByPostAndPath(post, it),
                        post.getLastModified(),
                        CHANGE_FREQUENCY,
                        DEFAULT_PRIORITY
                ))
                .collect(Collectors.toSet());
    }

    public static String getUrlByPostAndPath(Post post, String path) {
        return BLOG_URL + path + "/" + post.getUrl();
    }

}
