package io.github.gasparbarancelli.blog.sitemap;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlElementWrapper;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Collections;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@JacksonXmlRootElement(localName = "urlset")
public class Sitemap implements Serializable {

    @JacksonXmlProperty(localName = "url")
    @JacksonXmlElementWrapper(useWrapping = false)
    private final Set<SitemapUrl> urls = new HashSet<>();

    @Deprecated
    public Sitemap() {

    }

    private Sitemap(@NotNull Set<SitemapUrl> urls) {
        this.urls.addAll(Objects.requireNonNull(urls, "urls must not be null"));
    }

    public static Sitemap of(@NotNull Set<SitemapUrl> urls) {
        return new Sitemap(urls);
    }

    public Set<SitemapUrl> getUrls() {
        return Collections.unmodifiableSet(urls);
    }

}
