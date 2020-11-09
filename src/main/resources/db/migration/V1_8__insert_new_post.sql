insert into POST (ID, TITLE, URL, LAST_MODIFIED, SUMMARY, DESCRIPTION, DESCRIPTION_HTML)
values (
           7,
           'Utilize o Docker sem Sudo',
           'utilize-o-docker-sem-sudo',
           current_date,
           'Quando instalamos o Docker um grupo de usuário com o nome docker é criado, portanto apenas usuários que pertencem a esse grupo ou que seja o usuário root podem executar comandos Docker.',
           'Quando instalamos o Docker um grupo de usuário com o nome docker é criado, portanto apenas usuários que pertencem a esse grupo ou que seja o usuário root podem executar comandos Docker.

Para que não tenhamos que digitar sudo a cada comando docker a ser executado com o usuário logado, podemos adicionar nosso usuário ao grupo docker.
```shell
sudo usermod -aG docker ${USER}
```

Caso queira adicionar outro usuário ao grupo docker execute o seguinte comando.
```
sudo usermod -aG docker username
```

Agora conecte novamente no servidor e execute o seguinte comando para inscrever o usuário logado ao grupo.
```shell
su - ${USER}
```', '<div class="paragraph">
<p>Quando instalamos o Docker um grupo de usuário com o nome docker é criado, portanto apenas usuários que pertencem a esse grupo ou que seja o usuário root podem executar comandos Docker.</p>
</div>
<div class="paragraph">
<p>Para que não tenhamos que digitar sudo a cada comando docker a ser executado com o usuário logado, podemos adicionar nosso usuário ao grupo docker.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo usermod -aG docker ${USER}</code></pre>
</div>
</div>
<div class="paragraph">
<p>Caso queira adicionar outro usuário ao grupo docker execute o seguinte comando.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code>sudo usermod -aG docker username</code></pre>
</div>
</div>
<div class="paragraph">
<p>Agora conecte novamente no servidor e execute o seguinte comando para inscrever o usuário logado ao grupo.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">su - ${USER}</code></pre>
</div>
</div>');


insert into POST_AUTHOR (ID_POST, ID_AUTHOR) values ( 7, 1 );
insert into POST_TAG (ID_POST, ID_TAG) VALUES ( 7, 3);
