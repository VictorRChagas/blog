package io.github.gasparbarancelli.blog.sitemap;

import com.redfin.sitemapgenerator.ChangeFreq;
import com.redfin.sitemapgenerator.WebSitemapGenerator;
import com.redfin.sitemapgenerator.WebSitemapUrl;
import io.github.gasparbarancelli.blog.post.Post;
import io.github.gasparbarancelli.blog.post.PostData;
import org.springframework.stereotype.Service;

import java.io.File;
import java.net.MalformedURLException;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

@Service
public class SiteMapServiceImpl implements SiteMapService {

    private static final String WEB_PAGE_URL = "https://www.blog.com.br";
    private static final String LOCAL_FOLDER_PATH = "/home/victor/Documents/sitemap";

    private final PostData postData;

    public SiteMapServiceImpl(PostData postData) {
        this.postData = postData;
    }

    @Override
    public List<File> getSiteMap() throws MalformedURLException {
        final var webSitemapGenerator = WebSitemapGenerator.builder(WEB_PAGE_URL,
                new File(LOCAL_FOLDER_PATH))
                .build();
        var allPostList = postData.findAll();
        addUrls(webSitemapGenerator, allPostList);
        return webSitemapGenerator.write();
    }

    /***
     * this method add all the posts in the URL tag in the sitemap file
     */
    private void addUrls(WebSitemapGenerator webSitemapGenerator, List<Post> allPostList) {
        final var DEFAULT_PRIORITY = 0.8;
        final var DEFAULT_CHANGE_FREQUENCY = ChangeFreq.YEARLY;

        allPostList.forEach(post -> {
            var dateParsedFromLocalDate = Date.from(post.getLastModified().atStartOfDay(ZoneId.systemDefault()).toInstant());
            try {
                var urlTag = new WebSitemapUrl.Options(post.getUrl())
                        .lastMod(dateParsedFromLocalDate)
                        .priority(DEFAULT_PRIORITY)
                        .changeFreq(DEFAULT_CHANGE_FREQUENCY)
                        .build();
                webSitemapGenerator.addUrl(urlTag);
            } catch (MalformedURLException e) {
                e.printStackTrace();
            }
        });
    }
}
