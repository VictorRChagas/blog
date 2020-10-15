package io.github.gasparbarancelli.blog.sitemap;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.Objects;

@JacksonXmlRootElement(localName = "url")
public class SitemapUrl implements Serializable {

    @JacksonXmlProperty
    private String loc;

    @JacksonXmlProperty
    private LocalDate lastmod;

    @JacksonXmlProperty
    private String changefreq;

    @JacksonXmlProperty
    private Double priority;

    @Deprecated
    public SitemapUrl() {
    }

    private SitemapUrl(
            @NotNull String loc,
            @NotNull LocalDate lastmod,
            @NotNull String changefreq,
            @NotNull Double priority) {
        this.loc = Objects.requireNonNull(loc, "loc must not be null");
        this.lastmod = Objects.requireNonNull(lastmod, "lastmod must not be null");
        this.changefreq = Objects.requireNonNull(changefreq, "changefreq must not be null");
        this.priority = Objects.requireNonNull(priority, "priority must not be null");
    }

    public static SitemapUrl of(
            @NotNull String loc,
            @NotNull LocalDate lastmod,
            @NotNull String changefreq,
            @NotNull Double priority) {
        return new SitemapUrl(loc, lastmod, changefreq, priority);
    }

    public String getLoc() {
        return loc;
    }

    public LocalDate getLastmod() {
        return lastmod;
    }

    public String getChangefreq() {
        return changefreq;
    }

    public Double getPriority() {
        return priority;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SitemapUrl sitemap = (SitemapUrl) o;
        return Objects.equals(loc, sitemap.loc);
    }

    @Override
    public int hashCode() {
        return Objects.hash(loc);
    }

}
