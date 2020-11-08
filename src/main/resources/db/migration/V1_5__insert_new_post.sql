insert into TAG (ID, DESCRIPTION, URL)
values (2, 'Linux', 'linux');

insert into POST (ID, TITLE, URL, LAST_MODIFIED, SUMMARY, DESCRIPTION, DESCRIPTION_HTML)
values (
           4,
           'Redirecionar requisições da porta 80 para 8080',
           'redirecionar-requisicoes-da-porta-80-para-8080',
           current_date,
           'Utilizando iptables vamos modificar as regras do nosso firewall, liberando acesso as portas 80 e 8080 e por fim adicionando uma regra de redirecionamento das requisições.',
           'Utilizando *https://pt.wikipedia.org/wiki/Iptables[iptables]* vamos modificar as regras do nosso firewall, liberando acesso as portas 80 e 8080 e por fim adicionando uma regra de redirecionamento das requisições.

Libera acesso a porta 80.
```shell
iptables -A INPUT -i eth0 -p tcp --dport 80 -j ACCEPT
```

Liberar acesso a 8080.

```shell
iptables -A INPUT -i eth0 -p tcp --dport 8080 -j ACCEPT
```

Redireciona o trafego recebido na porta 80 para a porta 8080.

```shell
iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080
```
',
        '<div class="paragraph">
<p>Utilizando <strong><a href="https://pt.wikipedia.org/wiki/Iptables">iptables</a></strong> vamos modificar as regras do nosso firewall, liberando acesso as portas 80 e 8080 e por fim adicionando uma regra de redirecionamento das requisições.</p>
</div>
<div class="paragraph">
<p>Libera acesso a porta 80.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">iptables -A INPUT -i eth0 -p tcp --dport 80 -j ACCEPT</code></pre>
</div>
</div>
<div class="paragraph">
<p>Liberar acesso a 8080.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">iptables -A INPUT -i eth0 -p tcp --dport 8080 -j ACCEPT</code></pre>
</div>
</div>
<div class="paragraph">
<p>Redireciona o trafego recebido na porta 80 para a porta 8080.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080</code></pre>
</div>
</div>');

insert into POST_AUTHOR (ID_POST, ID_AUTHOR) values ( 4, 1 );
insert into POST_TAG (ID_POST, ID_TAG) VALUES ( 4, 2 );
