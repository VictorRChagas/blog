<#macro header>
    <nav class="header">
        <div class="container">
            <div class="row">
                <div class="col-6">
                    <a href="/">
                        <img src="img/icon_64.png" width="64px" height="64px" alt="Logo"/>
                        <span class="title">Blog</span>
                    </a>
                </div>
            </div>
        </div>
    </nav>

</#macro>

<#macro footer tags>
    <div class="footer">
        <div class="container">
            <div class="row">
                <div class="col-12 col-lg-4">
                    <img src="img/icon_128.png" width="128px" height="128px" alt="Logo"/>
                </div>
                <div class="col-12 col-lg-4">
                    <span>TAGS</span>
                    <ul>
                        <#list tags as tag>
                            <li>
                                <a href="/tag/${tag.url}">
                                    ${tag.description}
                                </a>
                            </li>
                        </#list>
                    </ul>
                </div>
                <div class="col-12 col-lg-4">
                    <span>ABOUT</span>
                    <ul>
                        <li>
                            <a href="/development">
                                BLOG
                            </a>
                        </li>
                        <li>
                            <a href="/development">
                                AUTHORS
                            </a>
                        </li>
                        <li>
                            <a href="/development">
                                JOBS
                            </a>
                        </li>
                        <li>
                            <a href="/development">
                                OUR PATTERNS
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</#macro>

<#macro page title description keywords css...>
    <#import "spring.ftl" as spring />
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <title>${title}</title>
        <base href="http://gasparbarancelli.com/" />
        <link rel="stylesheet" type="text/css" href="<@spring.url 'webjars/css-reset/2.5.1/reset.min.css'/>" />
        <link rel="stylesheet" type="text/css" href="<@spring.url 'css/font.css'/>" />
        <link rel="stylesheet" type="text/css" href="<@spring.url 'webjars/bootstrap/4.5.2/css/bootstrap.min.css'/>" />
        <link rel="stylesheet" type="text/css" href="<@spring.url 'css/base.css'/>" />
        <#list css as cssImport>
            <link rel="stylesheet" type="text/css" href="<@spring.url 'css/${cssImport}.css'/>" />
        </#list>

        <script src="<@spring.url 'webjars/jquery/3.5.1/jquery.min.js'/>" type="text/javascript"></script>
        <script src="<@spring.url 'webjars/bootstrap/4.5.2/js/bootstrap.min.js'/>" type="text/javascript"></script>

        <meta property="og:site_name" content="Blog - Gaspar Barancelli ">
        <meta property="og:title" content="${title}" />
        <meta property="og:description" content="${description}" />
        <meta property="og:image" itemprop="image" content="http://gasparbarancelli.com/img/icon_64.png">
        <meta property="og:type" content="website" />
        <meta property="og:updated_time" content="1440432930" />
        <meta name="Description" content="${description}">
        <meta name="keywords" content="${keywords}"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <meta name="robots" content="index, follow">
        <meta http-equiv="Content-Language" content="pt-br"/>
        <link rel="canonical" href="http://gasparbarancelli.com/${springMacroRequestContext.getRequestUri()}"/>
        <title>${title}</title>
    </head>
    <body>
    <@header />
    <div class="container">
        <#nested>
    </div>
    <@footer tags />
    <script src="js/index.js" type="text/javascript"></script>
    </body>
    </html>
</#macro>
