<#macro header>
    <div class="header">
        <div class="container">
            Logo
        </div>
    </div>
</#macro>

<#macro footer tags>
    <div class="footer">
        <div class="container">
            <div class="row">
                <div class="col-12 col-lg-4">
                    LOGO
                </div>
                <div class="col-12 col-lg-4">
                    <span>CATEGORIES</span>
                    <ul>
                        <#list tags as tag>
                            <li>${tag.description}</li>
                        </#list>
                    </ul>
                </div>
                <div class="col-12 col-lg-4">
                    <span>ABOUT</span>
                    <ul>
                        <li>BLOG</li>
                        <li>AUTHORS</li>
                        <li>JOBS</li>
                        <li>OUR PATTERNS</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</#macro>
