insert into POST (ID, TITLE, URL, LAST_MODIFIED, SUMMARY, DESCRIPTION, DESCRIPTION_HTML)
values (
           9,
           'Removendo acentuações e sinais gráficos de uma String',
           'removendo-acentuacoes-e-sinais-graficos-de-uma-string',
           current_date,
           'Utilizando expressão regular podemos remover as acentuações e sinais gráficos de uma String em Java.',
           'Utilizando expressão regular podemos remover as acentuações e sinais gráficos de uma String em Java.

Em versões do Java 7+ podemos utilizar o atributo *InCombiningDiacriticalMarks* na expressão regular, onde ira remover somente acentos e gráficos.

```java
public static String removeAccentsAfterJava7(String value) {
        String normalizer = Normalizer.normalize(value, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(normalizer).replaceAll("");
}
```

Para versões do Java anteriores a 7, também podemos utilizar expressão regular, mas agora removendo todos caracteres não ASCII.

```java
public static String removeAccentsBeforeJava7(String value) {
    String normalizer = Normalizer.normalize(value, Normalizer.Form.NFD);
    Pattern pattern = Pattern.compile("[^\\p{ASCII}]");
    return pattern.matcher(normalizer).replaceAll("");
}
```

Por fim, vamos realizar um pequeno teste fazendo uma chamada para os dois métodos citados anteriormente, passando como argumento uma String contendo diversos caracteres com acentuação.

```java
public static void main(String[] args) {
    String teste = "ÁÉÍÓÚÃÕÂÊÎÔÛÀÈÌÒÙ";
    System.out.println(removeAccentsAfterJava7(teste));
    System.out.println(removeAccentsBeforeJava7(teste));
}
```

Segue o resultado obtido na execução dos dois métodos, removendo com sucesso todos as acentuações dos caracteres.

```log
AEIOUAOAEIOUAEIOU
AEIOUAOAEIOUAEIOU
```
', '<div class="paragraph">
<p>Utilizando expressão regular podemos remover as acentuações e sinais gráficos de uma String em Java.</p>
</div>
<div class="paragraph">
<p>Em versões do Java 7+ podemos utilizar o atributo <strong>InCombiningDiacriticalMarks</strong> na expressão regular, onde ira remover somente acentos e gráficos.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-java" data-lang="java">public static String removeAccentsAfterJava7(String value) {
        String normalizer = Normalizer.normalize(value, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(normalizer).replaceAll("");
}</code></pre>
</div>
</div>
<div class="paragraph">
<p>Para versões do Java anteriores a 7, também podemos utilizar expressão regular, mas agora removendo todos caracteres não ASCII.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-java" data-lang="java">public static String removeAccentsBeforeJava7(String value) {
    String normalizer = Normalizer.normalize(value, Normalizer.Form.NFD);
    Pattern pattern = Pattern.compile("[^\\p{ASCII}]");
    return pattern.matcher(normalizer).replaceAll("");
}</code></pre>
</div>
</div>
<div class="paragraph">
<p>Por fim, vamos realizar um pequeno teste fazendo uma chamada para os dois métodos citados anteriormente, passando como argumento uma String contendo diversos caracteres com acentuação.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-java" data-lang="java">public static void main(String[] args) {
    String teste = "ÁÉÍÓÚÃÕÂÊÎÔÛÀÈÌÒÙ";
    System.out.println(removeAccentsAfterJava7(teste));
    System.out.println(removeAccentsBeforeJava7(teste));
}</code></pre>
</div>
</div>
<div class="paragraph">
<p>Segue o resultado obtido na execução dos dois métodos, removendo com sucesso todos as acentuações dos caracteres.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-log" data-lang="log">AEIOUAOAEIOUAEIOU
AEIOUAOAEIOUAEIOU</code></pre>
</div>
</div>');

insert into POST_AUTHOR (ID_POST, ID_AUTHOR) values ( 9, 1 );
insert into POST_TAG (ID_POST, ID_TAG) VALUES ( 9, 4);
