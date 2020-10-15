package io.github.gasparbarancelli.blog.sitemap;

import io.github.gasparbarancelli.blog.post.PostService;
import org.springframework.stereotype.Service;

import java.util.stream.Collectors;

@Service
public class SitemapServiceImpl implements SitemapService {

    private final PostService postService;

    public SitemapServiceImpl(PostService postService) {
        this.postService = postService;
    }

    @Override
    public Sitemap get() {
        var urls = postService.findAll()
                .stream()
                .map(SitemapUrlConverter::converter)
                .collect(Collectors.toSet());
        return Sitemap.of(urls);
    }

}
