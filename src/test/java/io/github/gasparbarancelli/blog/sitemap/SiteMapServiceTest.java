package io.github.gasparbarancelli.blog.sitemap;

import io.github.gasparbarancelli.blog.post.Post;
import io.github.gasparbarancelli.blog.post.PostData;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.util.Assert;

import java.net.MalformedURLException;
import java.util.List;

import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class SiteMapServiceTest {

    @InjectMocks private SiteMapServiceImpl siteMapService;

    @Mock private PostData postData;

    private static Post post = Post.of("Spring boot", "Framework",
            "For Java Developers", "https://www.blog.com.br/spring/authentication");

    @Test
    @DisplayName("returns the sitemap xml")
    public void returnsSingleXMLFile() throws MalformedURLException {
        when(postData.findAll()).thenReturn(List.of(post));

        var siteMap = siteMapService.getSiteMap();

        Assert.notEmpty(siteMap);
    }
}
