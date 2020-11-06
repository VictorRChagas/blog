insert into TAG (ID, DESCRIPTION, URL)
values (1, 'Spring', 'spring');


insert into AUTHOR (ID, NAME, EMAIL)
values (1, 'Gaspar Barancelli Junior', 'gasparbarancelli@gmail.com'),
       (2, 'João Chagas', 'jvrc2000@outlook.com');


insert into POST (ID, TITLE, URL, LAST_MODIFIED, SUMMARY, DESCRIPTION, DESCRIPTION_HTML)
values (
    1,
    'Ativando a compactação GZip no Spring Boot',
    'ativando-a-compactacao-gzip-no-spring-boot',
    current_date,
    'A compressão GZip é uma forma muito simples e eficaz de economizar largura de banda e melhorar a velocidade do seu site.',
    'A compressão GZip é uma forma muito simples e eficaz de economizar largura de banda e melhorar a velocidade do seu site.

Ele reduz o tempo de resposta do seu site ao compactar os recursos e enviá-los aos clientes.

A compressão GZip é desabilitada por padrão no Spring Boot. Para ativá-lo, adicione as seguintes propriedades ao seu arquivo de configuração *application.properties*

```properties
# Ativar compressão de resposta
server.compression.enabled=true

# A lista separada por vírgulas de tipos MIME que devem ser compactados
server.compression.mime-types=text/html,text/xml,text/plain,text/css,text/javascript,application/javascript,application/json

# Compacte a resposta apenas se o tamanho da resposta for de pelo menos 1 KB
server.compression.min-response-size=1024
```

Observe que a compactação GZip tem uma pequena sobrecarga. Portanto, adicione a propriedade *min-response-size* para dizer ao servidor de boot do Spring para compactar a resposta apenas se o tamanho for maior do que o valor fornecido.

', '<div class="paragraph">
<p>A compressão GZip é uma forma muito simples e eficaz de economizar largura de banda e melhorar a velocidade do seu site.</p>
</div>
<div class="paragraph">
<p>Ele reduz o tempo de resposta do seu site ao compactar os recursos e enviá-los aos clientes.</p>
</div>
<div class="paragraph">
<p>A compressão GZip é desabilitada por padrão no Spring Boot. Para ativá-lo, adicione as seguintes propriedades ao seu arquivo de configuração <strong>application.properties</strong></p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-properties" data-lang="properties"># Ativar compressão de resposta
server.compression.enabled=true

# A lista separada por vírgulas de tipos MIME que devem ser compactados
server.compression.mime-types=text/html,text/xml,text/plain,text/css,text/javascript,application/javascript,application/json

# Compacte a resposta apenas se o tamanho da resposta for de pelo menos 1 KB
server.compression.min-response-size=1024</code></pre>
</div>
</div>
<div class="paragraph">
<p>Observe que a compactação GZip tem uma pequena sobrecarga. Portanto, adicione a propriedade <strong>min-response-size</strong> para dizer ao servidor de boot do Spring para compactar a resposta apenas se o tamanho for maior do que o valor fornecido.</p>
</div>');

insert into POST_AUTHOR (ID_POST, ID_AUTHOR) values ( 1, 1 );
insert into POST_TAG (ID_POST, ID_TAG) VALUES ( 1, 1 );
