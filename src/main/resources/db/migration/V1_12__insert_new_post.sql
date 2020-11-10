insert into POST (ID, TITLE, URL, LAST_MODIFIED, SUMMARY, DESCRIPTION, DESCRIPTION_HTML)
values (
           11,
           'Spring Boot com certificado SSL gerado pelo Let`s Encrypt e utilizando Nginx como servidor Web',
           'spring-boot-com-certificado-ssl-gerado-pelo-lets-encrypt-e-utilizando-nginx-como-servidor-web',
           current_date,
           'A Let’s Encrypt é uma autoridade certificadora (AC) gratuita, automatizada e aberta que opera em prol do benefício público. É um serviço provido pela Internet Security Research Group (ISRG).',
           'Antes de iniciarmos as configurações dessas ferramentas vamos a uma breve introdução sobre elas.

=== Let’s Encrypt
====
A https://letsencrypt.org/pt-br/[Let’s Encrypt] é uma autoridade certificadora (AC) gratuita, automatizada e aberta que opera em prol do benefício público. É um serviço provido pela https://www.abetterinternet.org/[Internet Security Research Group (ISRG)].
====
=== Nginx
====
O https://www.nginx.com/[Nginx] é um servidor web open source de alta performance. Oferece recursos de balanceamento de cargas, proxy reverso e streaming, além de ser capaz de gerenciar milhares de conexões simultâneas.
====
=== Spring Boot
====
https://spring.io/projects/spring-boot[Spring Boot] é um framework desenvolvido em Java que facilita o processo de configurações de aplicações que utilizam todo ecossistema do Spring Framework. A ideia principal desse framework é facilitar a vida dos desenvolvedores, fazendo com que não percam mais tempo configurando um projeto e sim gastem seu tempo no desenvolvimento, para isso ele faz um uso do que chamamos de auto configurações.
====

''''''

=== Para seguir este tutorial, você vai precisar dos seguintes pré-requisitos:

. Um servidor Ubuntu na versão 20.04
. Um nome de domínio registrado. Para este tutorial utilizaremos o dominio blog-exemplo.com como exemplo.
. Ambos os registros de DNS a seguir devem estar configurados para o seu servidor.
.. Um registro A com blog-exemplo.com deve ser apontado para o endereço de IP público do seu servidor.
.. Um registro A com www.blog-exemplo.com deve ser apontando para o endereço de IP público do seu servidor.

=== O primeiro passo é instalar o Java 15 e rodar uma aplicação Spring Boot

Vamos efetuar o download do OpenJDK 15
```shell
wget https://download.java.net/java/GA/jdk15.0.1/51f4f36ad4ef43e39d0dfdbaf6549e32/9/GPL/openjdk-15.0.1_linux-x64_bin.tar.gz
```

Agora vamos descompactar o arquivo.
```shell
tar -zxvf openjdk-15.0.1_linux-x64_bin.tar.gz
```

Desenvolvi um projeto em Spring Boot que retorna uma simples pagina web exibindo a data atual, para facilitar deixei os fontes do projeto e o artefato _spring-boot-freemarker-0.0.1-SNAPSHOT.jar_ no github, então agora vamos fazer o download desse projeto.
```shell
git clone https://github.com/gasparbarancelli/spring-boot-freemarker.git
```

Podemos iniciar nossa aplicação em segundo plano, por padrão ela vai responder a porta 8080.
```shell
jdk-15.0.1/bin/java -jar spring-boot-freemarker-0.0.1-SNAPSHOT.jar & disown
```

Depois que nossa aplicação for executada com sucesso, podemos fazer uma chamada http para testar a resposta da requisição.
```shell
curl http://localhost:8080
```

=== O segundo passo é configurar o Nginx como nosso servidor web

Vamos atualizar a lista das versões de pacotes disponíveis e instalar o Nginx.
```shell
sudo apt update
sudo apt install nginx
```

Concluída instalação agora devemos alterar as regras do nosso firewall, permitindo acesso por HTTP e HTTPS.
```shell
sudo ufw allow ''Nginx HTTP''
sudo ufw allow ''Nginx HTTPS''
```

Agora podemos verificar o status do nosso serviço.
```shell
systemctl status nginx
```

Em caso de sucesso o retorno será similar ao log exibido abaixo.
```log
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2020-11-10 10:44:30 UTC; 1h 2min ago
       Docs: man:nginx(8)
    Process: 53500 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
    Process: 53501 ExecStart=/usr/sbin/nginx -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
   Main PID: 53502 (nginx)
      Tasks: 2 (limit: 2010)
     Memory: 3.5M
     CGroup: /system.slice/nginx.service
             ├─53502 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
             └─53503 nginx: worker process

Nov 10 10:44:29 blog-exemplo systemd[1]: Starting A high performance web server and a reverse proxy server...
Nov 10 10:44:30 blog-exemplo systemd[1]: Started A high performance web server and a reverse proxy server.
```

Caso contrario você pode tentar utilizar os seguintes comandos para manipular o Nginx.
```shell
# parar
sudo service nginx stop
# iniciar
sudo service nginx start
# reiniciar
sudo service nginx restart
```

Por fim, vamos configurar o Nginx para redirecionar as requisições para nossa aplicação do Spring Boot.

Vamos editar o seguinte arquivo de configuração do Nginx.
```shell
sudo vim /etc/nginx/sites-available/default
```

Dentro da tag *server* precisamos alterar o valor da propriedade _server_name_ adicionando o valor do nosso domínio, e também devemos adicionar a regra de redirecionamento.
```shell
server {
       ...

        server_name blog-exemplo.com www.blog-exemplo.com;

        location / {
             proxy_pass http://localhost:8080/;
             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
             proxy_set_header X-Forwarded-Proto $scheme;
             proxy_set_header X-Forwarded-Port $server_port;
        }

        ...

}
```

Vamos reiniciar nosso serviço do Nginx para que as configurações sejam aplicadas.
```shell
sudo service nginx restart
```

Ao realizarmos uma requisição para o endereço www.blog-exemplo.com a requisição vai ser recebida pelo Nginx que vai ser redirecionada para o Spring Boot, retornando a data atual como no teste do passo anterior.
```shell
curl www.blog-exemplo.com
```

=== Terceiro passo é a geração do nosso certificado SSL

Então vamos a instalação e configuração do Certbot, ele será responsável  por obter um certificado SSL gratuito para o Nginx.

Execute o seguinte comando para instalação do _certbot_ e também o _python3-certbot-nginx_.
```shell
sudo apt install certbot python3-certbot-nginx
```

O Certbot possui um plug-in para o Nginx, ele é responsável por toda reconfiguração do Nginx para vincular os certificados gerados. Como parâmetro devemos informar que desejamos utilizar o plugin do nginx e também quais os domínio devem ser registrados no certificado SSL, ao executar o comando você deve digitar seu e-mail para ficar vinculado ao certificado.
```shell
sudo certbot --nginx -d blog-exemplo.com -d www.blog-exemplo.com
```

O retorno do comando acima deve ser similar ao seguinte log.

```log
IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/blog-exemplo.com/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/blog-exemplo.com/privkey.pem
   Your cert will expire on 2021-02-08. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot again
   with the "certonly" option. To non-interactively renew *all* of
   your certificates, run "certbot renew"
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let''s Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le
```

Agora com todos os certificados baixados, instalados e carregados. Acesse o site usando https:// e verifique o indicador de segurança do seu navegador. Ele deve indicar que o site está devidamente protegido, normalmente com um ícone de cadeado. Se você testar o servidor usando o SSL, receberá uma classificação A.

Por fim, vamos editar novamente o arquivo de configuração do Nginx, para que todas as requisições feitas por http sejam redirecionadas para https.
```shell
sudo vim /etc/nginx/sites-available/default
```

Encontre a tag *server* que responde a porta 80 e adicione a seguinte configuração.
```shell
server {

    ...

    if ($scheme != "https") {
       return 301 https://$host$request_uri;
    }

    ...

}
```

Feito isso podemos fazer com o que o Nginx recarregue as configurações.
```shell
sudo systemctl reload nginx
```

Agora acesse o site usando http:// e verifique que a requisição será redirecionado para o protocolo https.
', '<div class="paragraph">
<p>Antes de iniciarmos as configurações dessas ferramentas vamos a uma breve introdução sobre elas.</p>
</div>
<div class="sect2">
<h3 id="_lets_encrypt">Let’s Encrypt</h3>
<div class="exampleblock">
<div class="content">
<div class="paragraph">
<p>A <a href="https://letsencrypt.org/pt-br/">Let’s Encrypt</a> é uma autoridade certificadora (AC) gratuita, automatizada e aberta que opera em prol do benefício público. É um serviço provido pela <a href="https://www.abetterinternet.org/">Internet Security Research Group (ISRG)</a>.</p>
</div>
</div>
</div>
</div>
<div class="sect2">
<h3 id="_nginx">Nginx</h3>
<div class="exampleblock">
<div class="content">
<div class="paragraph">
<p>O <a href="https://www.nginx.com/">Nginx</a> é um servidor web open source de alta performance. Oferece recursos de balanceamento de cargas, proxy reverso e streaming, além de ser capaz de gerenciar milhares de conexões simultâneas.</p>
</div>
</div>
</div>
</div>
<div class="sect2">
<h3 id="_spring_boot">Spring Boot</h3>
<div class="exampleblock">
<div class="content">
<div class="paragraph">
<p><a href="https://spring.io/projects/spring-boot">Spring Boot</a> é um framework desenvolvido em Java que facilita o processo de configurações de aplicações que utilizam todo ecossistema do Spring Framework. A ideia principal desse framework é facilitar a vida dos desenvolvedores, fazendo com que não percam mais tempo configurando um projeto e sim gastem seu tempo no desenvolvimento, para isso ele faz um uso do que chamamos de auto configurações.</p>
</div>
</div>
</div>
<hr>
</div>
<div class="sect2">
<h3 id="_para_seguir_este_tutorial_você_vai_precisar_dos_seguintes_pré_requisitos">Para seguir este tutorial, você vai precisar dos seguintes pré-requisitos:</h3>
<div class="olist arabic">
<ol class="arabic">
<li>
<p>Um servidor Ubuntu na versão 20.04</p>
</li>
<li>
<p>Um nome de domínio registrado. Para este tutorial utilizaremos o dominio blog-exemplo.com como exemplo.</p>
</li>
<li>
<p>Ambos os registros de DNS a seguir devem estar configurados para o seu servidor.</p>
<div class="olist loweralpha">
<ol class="loweralpha" type="a">
<li>
<p>Um registro A com blog-exemplo.com deve ser apontado para o endereço de IP público do seu servidor.</p>
</li>
<li>
<p>Um registro A com www.blog-exemplo.com deve ser apontando para o endereço de IP público do seu servidor.</p>
</li>
</ol>
</div>
</li>
</ol>
</div>
</div>
<div class="sect2">
<h3 id="_o_primeiro_passo_é_instalar_o_java_15_e_rodar_uma_aplicação_spring_boot">O primeiro passo é instalar o Java 15 e rodar uma aplicação Spring Boot</h3>
<div class="paragraph">
<p>Vamos efetuar o download do OpenJDK 15</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">wget https://download.java.net/java/GA/jdk15.0.1/51f4f36ad4ef43e39d0dfdbaf6549e32/9/GPL/openjdk-15.0.1_linux-x64_bin.tar.gz</code></pre>
</div>
</div>
<div class="paragraph">
<p>Agora vamos descompactar o arquivo.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">tar -zxvf openjdk-15.0.1_linux-x64_bin.tar.gz</code></pre>
</div>
</div>
<div class="paragraph">
<p>Desenvolvi um projeto em Spring Boot que retorna uma simples pagina web exibindo a data atual, para facilitar deixei os fontes do projeto e o artefato <em>spring-boot-freemarker-0.0.1-SNAPSHOT.jar</em> no github, então agora vamos fazer o download desse projeto.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">git clone https://github.com/gasparbarancelli/spring-boot-freemarker.git</code></pre>
</div>
</div>
<div class="paragraph">
<p>Podemos iniciar nossa aplicação em segundo plano, por padrão ela vai responder a porta 8080.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">jdk-15.0.1/bin/java -jar spring-boot-freemarker-0.0.1-SNAPSHOT.jar &amp; disown</code></pre>
</div>
</div>
<div class="paragraph">
<p>Depois que nossa aplicação for executada com sucesso, podemos fazer uma chamada http para testar a resposta da requisição.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">curl http://localhost:8080</code></pre>
</div>
</div>
</div>
<div class="sect2">
<h3 id="_o_segundo_passo_é_configurar_o_nginx_como_nosso_servidor_web">O segundo passo é configurar o Nginx como nosso servidor web</h3>
<div class="paragraph">
<p>Vamos atualizar a lista das versões de pacotes disponíveis e instalar o Nginx.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo apt update
sudo apt install nginx</code></pre>
</div>
</div>
<div class="paragraph">
<p>Concluída instalação agora devemos alterar as regras do nosso firewall, permitindo acesso por HTTP e HTTPS.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo ufw allow ''Nginx HTTP''
sudo ufw allow ''Nginx HTTPS''</code></pre>
</div>
</div>
<div class="paragraph">
<p>Agora podemos verificar o status do nosso serviço.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">systemctl status nginx</code></pre>
</div>
</div>
<div class="paragraph">
<p>Em caso de sucesso o retorno será similar ao log exibido abaixo.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-log" data-lang="log">● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2020-11-10 10:44:30 UTC; 1h 2min ago
       Docs: man:nginx(8)
    Process: 53500 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
    Process: 53501 ExecStart=/usr/sbin/nginx -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
   Main PID: 53502 (nginx)
      Tasks: 2 (limit: 2010)
     Memory: 3.5M
     CGroup: /system.slice/nginx.service
             ├─53502 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
             └─53503 nginx: worker process

Nov 10 10:44:29 blog-exemplo systemd[1]: Starting A high performance web server and a reverse proxy server...
Nov 10 10:44:30 blog-exemplo systemd[1]: Started A high performance web server and a reverse proxy server.</code></pre>
</div>
</div>
<div class="paragraph">
<p>Caso contrario você pode tentar utilizar os seguintes comandos para manipular o Nginx.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell"># parar
sudo service nginx stop
# iniciar
sudo service nginx start
# reiniciar
sudo service nginx restart</code></pre>
</div>
</div>
<div class="paragraph">
<p>Por fim, vamos configurar o Nginx para redirecionar as requisições para nossa aplicação do Spring Boot.</p>
</div>
<div class="paragraph">
<p>Vamos editar o seguinte arquivo de configuração do Nginx.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo vim /etc/nginx/sites-available/default</code></pre>
</div>
</div>
<div class="paragraph">
<p>Dentro da tag <strong>server</strong> precisamos alterar o valor da propriedade <em>server_name</em> adicionando o valor do nosso domínio, e também devemos adicionar a regra de redirecionamento.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">server {
       ...

        server_name blog-exemplo.com www.blog-exemplo.com;

        location / {
             proxy_pass http://localhost:8080/;
             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
             proxy_set_header X-Forwarded-Proto $scheme;
             proxy_set_header X-Forwarded-Port $server_port;
        }

        ...

}</code></pre>
</div>
</div>
<div class="paragraph">
<p>Vamos reiniciar nosso serviço do Nginx para que as configurações sejam aplicadas.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo service nginx restart</code></pre>
</div>
</div>
<div class="paragraph">
<p>Ao realizarmos uma requisição para o endereço www.blog-exemplo.com a requisição vai ser recebida pelo Nginx que vai ser redirecionada para o Spring Boot, retornando a data atual como no teste do passo anterior.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">curl www.blog-exemplo.com</code></pre>
</div>
</div>
</div>
<div class="sect2">
<h3 id="_terceiro_passo_é_a_geração_do_nosso_certificado_ssl">Terceiro passo é a geração do nosso certificado SSL</h3>
<div class="paragraph">
<p>Então vamos a instalação e configuração do Certbot, ele será responsável  por obter um certificado SSL gratuito para o Nginx.</p>
</div>
<div class="paragraph">
<p>Execute o seguinte comando para instalação do <em>certbot</em> e também o <em>python3-certbot-nginx</em>.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo apt install certbot python3-certbot-nginx</code></pre>
</div>
</div>
<div class="paragraph">
<p>O Certbot possui um plug-in para o Nginx, ele é responsável por toda reconfiguração do Nginx para vincular os certificados gerados. Como parâmetro devemos informar que desejamos utilizar o plugin do nginx e também quais os domínio devem ser registrados no certificado SSL, ao executar o comando você deve digitar seu e-mail para ficar vinculado ao certificado.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo certbot --nginx -d blog-exemplo.com -d www.blog-exemplo.com</code></pre>
</div>
</div>
<div class="paragraph">
<p>O retorno do comando acima deve ser similar ao seguinte log.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-log" data-lang="log">IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/blog-exemplo.com/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/blog-exemplo.com/privkey.pem
   Your cert will expire on 2021-02-08. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot again
   with the "certonly" option. To non-interactively renew *all* of
   your certificates, run "certbot renew"
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let''s Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le</code></pre>
</div>
</div>
<div class="paragraph">
<p>Agora com todos os certificados baixados, instalados e carregados. Acesse o site usando https:// e verifique o indicador de segurança do seu navegador. Ele deve indicar que o site está devidamente protegido, normalmente com um ícone de cadeado. Se você testar o servidor usando o SSL, receberá uma classificação A.</p>
</div>
<div class="paragraph">
<p>Por fim, vamos editar novamente o arquivo de configuração do Nginx, para que todas as requisições feitas por http sejam redirecionadas para https.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo vim /etc/nginx/sites-available/default</code></pre>
</div>
</div>
<div class="paragraph">
<p>Encontre a tag <strong>server</strong> que responde a porta 80 e adicione a seguinte configuração.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">server {

    ...

    if ($scheme != "https") {
       return 301 https://$host$request_uri;
    }

    ...

}</code></pre>
</div>
</div>
<div class="paragraph">
<p>Feito isso podemos fazer com o que o Nginx recarregue as configurações.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo systemctl reload nginx</code></pre>
</div>
</div>
<div class="paragraph">
<p>Agora acesse o site usando http:// e verifique que a requisição será redirecionado para o protocolo https.</p>
</div>
</div>');

insert into POST_AUTHOR (ID_POST, ID_AUTHOR) values ( 11, 1 );
insert into POST_TAG (ID_POST, ID_TAG) VALUES ( 11, 1), ( 11, 2), (11, 4);
