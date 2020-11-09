insert into POST (ID, TITLE, URL, LAST_MODIFIED, SUMMARY, DESCRIPTION, DESCRIPTION_HTML)
values (
           6,
           'Instalando o Docker no Ubuntu',
           'instalando-o-docker-no-ubuntu',
           current_date,
           'Iremos instalar a versão mais recente do Docker, mas para isso temos que conectar no repositório oficial do Docker e não do repositório oficial do Ubuntu.',
           'Iremos instalar a versão mais recente do Docker, mas para isso temos que conectar no repositório oficial do Docker e não do repositório oficial do Ubuntu.

O primeiro passo é atualizarmos a lista das versões de pacotes disponíveis.
```shell
sudo apt update
```

Ao finalizar a atualização dos pacotes podemos, vamos instalar alguns pacotes que são pré-requisitos para que o apt seja capaz de usar pacotes HTTPS:
```shell
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```

Devemos adicionar a chave https://gnupg.org/[GPG] para o repositório oficial do Docker.
```shell
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

Use o seguinte comando para configurar o repositorio estável do Docker às fontes do APT.
```shell
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
```

Devemos atualizar novamente a lista das versões de pacotes disponíveis.
```shell
sudo apt update
```

Agora sim podemos finalmente instalar o Docker.
```shell
sudo apt install docker-ce
```

Para visualizar o status do serviço Docker execute o seguinte comando.
```shell
sudo systemctl status docker
```

', '<div class="paragraph">
<p>Iremos instalar a versão mais recente do Docker, mas para isso temos que conectar no repositório oficial do Docker e não do repositório oficial do Ubuntu.</p>
</div>
<div class="paragraph">
<p>O primeiro passo é atualizarmos a lista das versões de pacotes disponíveis.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo apt update</code></pre>
</div>
</div>
<div class="paragraph">
<p>Ao finalizar a atualização dos pacotes podemos, vamos instalar alguns pacotes que são pré-requisitos para que o apt seja capaz de usar pacotes HTTPS:</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo apt install apt-transport-https ca-certificates curl software-properties-common</code></pre>
</div>
</div>
<div class="paragraph">
<p>Devemos adicionar a chave <a href="https://gnupg.org/">GPG</a> para o repositório oficial do Docker.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -</code></pre>
</div>
</div>
<div class="paragraph">
<p>Use o seguinte comando para configurar o repositorio estável do Docker às fontes do APT.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"</code></pre>
</div>
</div>
<div class="paragraph">
<p>Devemos atualizar novamente a lista das versões de pacotes disponíveis.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo apt update</code></pre>
</div>
</div>
<div class="paragraph">
<p>Agora sim podemos finalmente instalar o Docker.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo apt install docker-ce</code></pre>
</div>
</div>
<div class="paragraph">
<p>Para visualizar o status do serviço Docker execute o seguinte comando.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo systemctl status docker</code></pre>
</div>
</div>');

insert into TAG (ID, DESCRIPTION, URL)
values (3, 'Docker', 'docker');

insert into POST_AUTHOR (ID_POST, ID_AUTHOR) values ( 6, 1 );
insert into POST_TAG (ID_POST, ID_TAG) VALUES ( 6, 2 ), (6, 3);
