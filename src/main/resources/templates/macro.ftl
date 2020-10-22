<#macro header>
    <nav class="header">
        <div class="row">
            <div class="col-6">
                <p class="ml-2 m-0">Logo</p>
            </div>
            <div class="col-6">
                <div class="col-10 d-inline-block text-right" style="border-right: 1px solid black;">
                    <p class="d-inline-block m-0 mr-3">
                        <a>Log in</a> / <a>Join</a>
                    </p>
                    <p>Login Icon</p>
                </div>
                <div class="col-1 d-inline-block">
                    <p>Search Icon</p>
                </div>
            </div>
            <div class="container">
                <div class="col-12 text-center">
                    <span class="p-1">Spring Boot</span>
                    <span class="p-1">Micro Services</span>
                    <span class="p-1">Data Strucutres</span>
                    <span class="p-1">Algorithms</span>
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
