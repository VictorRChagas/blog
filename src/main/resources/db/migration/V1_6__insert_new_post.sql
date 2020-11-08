insert into POST (ID, TITLE, URL, LAST_MODIFIED, SUMMARY, DESCRIPTION, DESCRIPTION_HTML)
values (
           5,
           'Descobrindo qual processo está escutando determinada porta',
           'descobrindo-qual-processo-esta-escutando-determinada-porta',
           current_date,
           'Vamos utilizar o lsof para descobrir se uma determinada porta está em uso e também qual o processo está escutando a porta em especifico.',
           'Uma porta de rede no Linux nada mais é do que um número que identifica um lado de uma conexão entre dois sistemas. Todos os dispositivos em rede usam números de porta para determinar a qual processo uma mensagem deve ser entregue. O nome de domínio e o endereço IP são como um endereço de rua e os números das portas são como os números dos quartos.

Vamos utilizar o *lsof* para descobrir se uma determinada porta está em uso e também qual o processo está escutando a porta em especifico.

O primeiro passo é atualizarmos a lista das versões de pacotes disponíveis.
```shell
sudo apt update
```

Ao finalizar a atualização dos pacotes, agora podemos instalar o *lsof*.
```shell
sudo apt-get install lsof
```

Agora sim podemos executar o comando que retorna todos os processos que estão escutando uma determinada porta. Como exemplo vamos verificar qual processo está escutando a porta 8080.
```shell
lsof -i tcp:8080
```

O comando executado acima retornou no terminal a seguinte saída.
```shell
COMMAND   PID             USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
java    14921             XXXX   10u  IPv6  49065      0t0  TCP *:http-alt (LISTEN)
```
Podemos verificar que a porta está em uso por um processo Java, o qual tem como PID (identificador do processo) o número 14921.

Para matar o processo que está escutando a porta 8080 basta copiarmos o número do PID obtido no passo anterior e executar o seguinte comando no terminal.
```shell
kill -9 14921
```
', '<div class="paragraph">
<p>Uma porta de rede no Linux nada mais é do que um número que identifica um lado de uma conexão entre dois sistemas. Todos os dispositivos em rede usam números de porta para determinar a qual processo uma mensagem deve ser entregue. O nome de domínio e o endereço IP são como um endereço de rua e os números das portas são como os números dos quartos.</p>
</div>
<div class="paragraph">
<p>Vamos utilizar o <strong>lsof</strong> para descobrir se uma determinada porta está em uso e também qual o processo está escutando a porta em especifico.</p>
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
<p>Ao finalizar a atualização dos pacotes, agora podemos instalar o <strong>lsof</strong>.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo apt-get install lsof</code></pre>
</div>
</div>
<div class="paragraph">
<p>Agora sim podemos executar o comando que retorna todos os processos que estão escutando uma determinada porta. Como exemplo vamos verificar qual processo está escutando a porta 8080.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">lsof -i tcp:8080</code></pre>
</div>
</div>
<div class="paragraph">
<p>O comando executado acima retornou no terminal a seguinte saída.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">COMMAND   PID             USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
java    14921             XXXX   10u  IPv6  49065      0t0  TCP *:http-alt (LISTEN)</code></pre>
</div>
</div>
<div class="paragraph">
<p>Podemos verificar que a porta está em uso por um processo Java, o qual tem como PID (identificador do processo) o número 14921.</p>
</div>
<div class="paragraph">
<p>Para matar o processo que está escutando a porta 8080 basta copiarmos o número do PID obtido no passo anterior e executar o seguinte comando no terminal.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">kill -9 14921</code></pre>
</div>
</div>');

insert into POST_AUTHOR (ID_POST, ID_AUTHOR) values ( 5, 1 );
insert into POST_TAG (ID_POST, ID_TAG) VALUES ( 5, 2 );
