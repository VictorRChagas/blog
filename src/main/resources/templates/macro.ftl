<#macro header>
    <nav class="header">
        <div class="container">
            <div class="row">
                <div class="col-6">
                    <a href="/">
                        <img src="img/icon_64.png" alt="Logo"/>
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
                    <img src="img/icon_128.png" alt="Logo"/>
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

<#macro page title css>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <title>${title}</title>
        <base href="http://localhost:8080/" />
        <link rel="stylesheet" type="text/css" href="webjars/css-reset/2.5.1/reset.min.css" />
        <link rel="stylesheet" type="text/css" href="css/font.css" />
        <link rel="stylesheet" type="text/css" href="webjars/bootstrap/4.5.2/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/base.css" />
        <link rel="stylesheet" type="text/css" href="css/${css}.css" />
        <script src="webjars/jquery/3.5.1/jquery.min.js" type="text/javascript"></script>
        <script src="webjars/bootstrap/4.5.2/js/bootstrap.min.js" type="text/javascript"></script>
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
