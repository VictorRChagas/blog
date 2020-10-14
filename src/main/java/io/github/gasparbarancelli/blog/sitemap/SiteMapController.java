package io.github.gasparbarancelli.blog.sitemap;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.net.MalformedURLException;
import java.util.List;

@RestController
@RequestMapping("sitemap")
public class SiteMapController {

    private final SiteMapService siteMapService;

    public SiteMapController(SiteMapService siteMapService) {
        this.siteMapService = siteMapService;
    }

    /***
     * this method retuns a XML maping the site and their posts
     * it's used for the improving the indexing of the pages by search engines
     */
    @PostMapping
    public ResponseEntity<List<File>> getSiteMap() throws MalformedURLException {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(siteMapService.getSiteMap());
    }
}
