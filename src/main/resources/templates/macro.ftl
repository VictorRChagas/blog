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
