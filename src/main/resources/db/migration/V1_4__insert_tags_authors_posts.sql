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
</div>'), (
    2,
    'Habilitando o cache de recursos estáticos do navegador no Spring Boot',
    'habilitando-o-cache-de-recursos-estaticos-do-navegador-no-spring-boot',
    current_date,
    'O cache do navegador melhora a velocidade de carregamento da página do seu site. Você pode definir cabeçalhos de controle de cache para dizer aos navegadores para armazenar recursos estáticos em cache até um determinado período de tempo.',
    'O cache do navegador melhora a velocidade de carregamento da página do seu site. Você pode definir cabeçalhos de controle de cache para dizer aos navegadores para armazenar recursos estáticos em cache até um determinado período de tempo.

A configuração padrão do Spring Boot desabilita o cache do navegador. Mas podemos ativar o armazenamento em cache definindo as seguintes propriedades no arquivo de configuração *application.properties*.

```properties
# Tempo máximo em que a resposta deve ser armazenada em cache, em segundos mas podendo adicionar um sufixo para que seja armazenado em dias
spring.resources.cache.cachecontrol.max-age=365d

# Indica que uma vez que se tornou obsoleto, um cache não deve usar a resposta sem revalidá-lo com o servidor.
spring.resources.cache.cachecontrol.must-revalidate=true

# Indica que a mensagem de resposta é destinada a um único usuário e não deve ser armazenada por um cache compartilhado como por exemplo o CDN.
spring.resources.cache.cachecontrol.cache-private=false

# Indica que o recurso é publico e qualquer cache pode armazenar a resposta
spring.resources.cache.cachecontrol.cache-public=true
```
', '<div class="paragraph">
<p>O cache do navegador melhora a velocidade de carregamento da página do seu site. Você pode definir cabeçalhos de controle de cache para dizer aos navegadores para armazenar recursos estáticos em cache até um determinado período de tempo.</p>
</div>
<div class="paragraph">
<p>A configuração padrão do Spring Boot desabilita o cache do navegador. Mas podemos ativar o armazenamento em cache definindo as seguintes propriedades no arquivo de configuração <strong>application.properties</strong>.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-properties" data-lang="properties"># Tempo máximo em que a resposta deve ser armazenada em cache, em segundos mas podendo adicionar um sufixo para que seja armazenado em dias
spring.resources.cache.cachecontrol.max-age=365d

# Indica que uma vez que se tornou obsoleto, um cache não deve usar a resposta sem revalidá-lo com o servidor.
spring.resources.cache.cachecontrol.must-revalidate=true

# Indica que a mensagem de resposta é destinada a um único usuário e não deve ser armazenada por um cache compartilhado como por exemplo o CDN.
spring.resources.cache.cachecontrol.cache-private=false

# Indica que o recurso é publico e qualquer cache pode armazenar a resposta
spring.resources.cache.cachecontrol.cache-public=true</code></pre>
</div>
</div>');

insert into POST_AUTHOR (ID_POST, ID_AUTHOR) values ( 1, 1 ), (2, 1);
insert into POST_TAG (ID_POST, ID_TAG) VALUES ( 1, 1 ), (2,1);
