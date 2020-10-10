package io.github.gasparbarancelli.blog.sitemap;

import java.io.File;
import java.net.MalformedURLException;
import java.util.List;

public interface SiteMapService {

    List<File> getSiteMap() throws MalformedURLException;
}
