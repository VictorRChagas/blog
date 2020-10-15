package io.github.gasparbarancelli.blog.sitemap;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/sitemap.xml")
public class SitemapController {

    private final SitemapService siteMapService;

    public SitemapController(SitemapService siteMapService) {
        this.siteMapService = siteMapService;
    }

    @GetMapping(produces = MediaType.APPLICATION_XML_VALUE)
    public Sitemap xml() {
        return siteMapService.get();
    }

}
