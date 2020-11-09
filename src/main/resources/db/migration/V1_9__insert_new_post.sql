insert into POST (ID, TITLE, URL, LAST_MODIFIED, SUMMARY, DESCRIPTION, DESCRIPTION_HTML)
values (
           8,
           'Multithreading com Java - Iniciando com Threads',
           'multithreading-com-java-iniciando-com-threads',
           current_date,
           'Levando em conta a arquitetura multicore presente nos processadores atuais, nossa aplicação é capaz de executar mais de uma tarefa simultaneamente, e o Java desde as suas primeiras versões disponibiliza diversas APIs para trabalhar com paralelismo.',
           'Levando em conta a arquitetura multicore presente nos processadores atuais, nossa aplicação é capaz de executar mais de uma tarefa simultaneamente, e o Java desde as suas primeiras versões disponibiliza diversas APIs para trabalhar com paralelismo.

Nesse artigo veremos três exemplos muito simples de como criar uma Thread em Java, não veremos nada avançado por enquanto, pois estou planejando uma serie de artigos sobre multithreading com Java, que serão postados no futuro.

No exemplo a seguir criamos uma classe chamada *MyThread* que extende *Thread*. Ao extendermos a classe *Thread* obrigatoriamente devemos implementar o método *run*, pois esse é o método que será invocado quando a thread for iniciada. No método *run* vamos percorrer um loop 10 vezes, exibindo no log o identificador da Thread e um número incrementado pelo loop.

```java
class MyThread extends Thread {

    @Override
    public void run() {
        var threadId = Thread.currentThread().getId();

        for (int i = 0; i < 3; i++) {
            System.out.println("Thread Id: " + threadId + ", Value: " + i);
        }
    }

}
```

Agora vamos criar 3 novas Threads, instanciando nosso objeto criado no passo anterior. Também vamos logar no console o identificador da Thread atual, para que possamos visualizar nos logs, que ao inicializarmos as outras 3 Threads, os códigos serão executados simultaneamente em Threads distintas.

``` java
public class Demo1 {

    public static void main(String[] args) {
        System.out.println("Main Thread Id: " + Thread.currentThread().getId());

        new MyThread().start();
        new MyThread().start();
        new MyThread().start();
    }

}
```

Uma outra forma de instanciarmos uma Thread é criando uma classe que implemente a interace *Runnable*, e obrigatoriamente também devemos implementar o método *run*, onde vamos implementar o mesmo loop utilizado no primeiro exemplo.

```java
class MyRunnable implements Runnable {

    @Override
    public void run() {
        var threadId = Thread.currentThread().getId();

        for (int i = 0; i < 10; i++) {
            System.out.println("Thread Id: " + threadId + ", Value: " + i);
        }
    }
}
```

Para testar nossa implementação vamos instanciar a nossa classe desenvolvida no passo anterior, e criar 3 novas Threads passando como argumento no construtor a nossa instancia de *MyRunnable*.

```java
public class Demo2 {

    public static void main(String[] args) {
        System.out.println("Main Thread Id: " + Thread.currentThread().getId());

        var runnable = new MyRunnable();

        new Thread(runnable).start();
        new Thread(runnable).start();
        new Thread(runnable).start();
    }

}
```

Em nosso último exemplo vamos criar 3 novas Threads mas agora vamos utilizar *lambda* e também *method reference* que foram disponibilizados no Java 8.

```java
public class Demo3 {

    public static void main(String[] args) {
        System.out.println("Main Thread ID: " + Thread.currentThread().getId());

        new Thread(new Runnable() {
            @Override
            public void run() {
                loop();
            }
        }).start();

        // Criando uma instancia de Runnable utilizando lambda
        new Thread(() -> loop()).start();

        // Utilizando method reference
        new Thread(Demo3::loop).start();
    }

    private static void loop() {
        var threadId = Thread.currentThread().getId();

        for (int i = 0; i < 3; i++) {
            System.out.println("Thread Id: " + threadId + ", Value: " + i);
        }
    }

}
```

Por fim, segue os logs obtidos ao executar qualquer um dos exemplos exibidos acima.

```log
Main Thread Id: 1
Thread Id: 25, Value: 0
Thread Id: 25, Value: 1
Thread Id: 25, Value: 2
Thread Id: 23, Value: 0
Thread Id: 24, Value: 0
Thread Id: 23, Value: 1
Thread Id: 24, Value: 1
Thread Id: 23, Value: 2
Thread Id: 24, Value: 2
```

O código fonte dessa aplicação esta no https://github.com/gasparbarancelli/java-multithreading/tree/master/src/com/gasparbarancelli/multithreading/startingThreads[repositório] hospedado no GitHub.
', '<div class="paragraph">
<p>Levando em conta a arquitetura multicore presente nos processadores atuais, nossa aplicação é capaz de executar mais de uma tarefa simultaneamente, e o Java desde as suas primeiras versões disponibiliza diversas APIs para trabalhar com paralelismo.</p>
</div>
<div class="paragraph">
<p>Nesse artigo veremos três exemplos muito simples de como criar uma Thread em Java, não veremos nada avançado por enquanto, pois estou planejando uma serie de artigos sobre multithreading com Java, que serão postados no futuro.</p>
</div>
<div class="paragraph">
<p>No exemplo a seguir criamos uma classe chamada <strong>MyThread</strong> que extende <strong>Thread</strong>. Ao extendermos a classe <strong>Thread</strong> obrigatoriamente devemos implementar o método <strong>run</strong>, pois esse é o método que será invocado quando a thread for iniciada. No método <strong>run</strong> vamos percorrer um loop 10 vezes, exibindo no log o identificador da Thread e um número incrementado pelo loop.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-java" data-lang="java">class MyThread extends Thread {

    @Override
    public void run() {
        var threadId = Thread.currentThread().getId();

        for (int i = 0; i &lt; 3; i++) {
            System.out.println("Thread Id: " + threadId + ", Value: " + i);
        }
    }

}</code></pre>
</div>
</div>
<div class="paragraph">
<p>Agora vamos criar 3 novas Threads, instanciando nosso objeto criado no passo anterior. Também vamos logar no console o identificador da Thread atual, para que possamos visualizar nos logs, que ao inicializarmos as outras 3 Threads, os códigos serão executados simultaneamente em Threads distintas.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-java" data-lang="java">public class Demo1 {

    public static void main(String[] args) {
        System.out.println("Main Thread Id: " + Thread.currentThread().getId());

        new MyThread().start();
        new MyThread().start();
        new MyThread().start();
    }

}</code></pre>
</div>
</div>
<div class="paragraph">
<p>Uma outra forma de instanciarmos uma Thread é criando uma classe que implemente a interace <strong>Runnable</strong>, e obrigatoriamente também devemos implementar o método <strong>run</strong>, onde vamos implementar o mesmo loop utilizado no primeiro exemplo.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-java" data-lang="java">class MyRunnable implements Runnable {

    @Override
    public void run() {
        var threadId = Thread.currentThread().getId();

        for (int i = 0; i &lt; 10; i++) {
            System.out.println("Thread Id: " + threadId + ", Value: " + i);
        }
    }
}</code></pre>
</div>
</div>
<div class="paragraph">
<p>Para testar nossa implementação vamos instanciar a nossa classe desenvolvida no passo anterior, e criar 3 novas Threads passando como argumento no construtor a nossa instancia de <strong>MyRunnable</strong>.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-java" data-lang="java">public class Demo2 {

    public static void main(String[] args) {
        System.out.println("Main Thread Id: " + Thread.currentThread().getId());

        var runnable = new MyRunnable();

        new Thread(runnable).start();
        new Thread(runnable).start();
        new Thread(runnable).start();
    }

}</code></pre>
</div>
</div>
<div class="paragraph">
<p>Em nosso último exemplo vamos criar 3 novas Threads mas agora vamos utilizar <strong>lambda</strong> e também <strong>method reference</strong> que foram disponibilizados no Java 8.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-java" data-lang="java">public class Demo3 {

    public static void main(String[] args) {
        System.out.println("Main Thread ID: " + Thread.currentThread().getId());

        new Thread(new Runnable() {
            @Override
            public void run() {
                loop();
            }
        }).start();

        // Criando uma instancia de Runnable utilizando lambda
        new Thread(() -&gt; loop()).start();

        // Utilizando method reference
        new Thread(Demo3::loop).start();
    }

    private static void loop() {
        var threadId = Thread.currentThread().getId();

        for (int i = 0; i &lt; 3; i++) {
            System.out.println("Thread Id: " + threadId + ", Value: " + i);
        }
    }

}</code></pre>
</div>
</div>
<div class="paragraph">
<p>Por fim, segue os logs obtidos ao executar qualquer um dos exemplos exibidos acima.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-log" data-lang="log">Main Thread Id: 1
Thread Id: 25, Value: 0
Thread Id: 25, Value: 1
Thread Id: 25, Value: 2
Thread Id: 23, Value: 0
Thread Id: 24, Value: 0
Thread Id: 23, Value: 1
Thread Id: 24, Value: 1
Thread Id: 23, Value: 2
Thread Id: 24, Value: 2</code></pre>
</div>
</div>
<div class="paragraph">
<p>O código fonte dessa aplicação esta no <a href="https://github.com/gasparbarancelli/java-multithreading/tree/master/src/com/gasparbarancelli/multithreading/startingThreads">repositório</a> hospedado no GitHub.</p>
</div>');

insert into TAG (ID, DESCRIPTION, URL)
values (4, 'Java', 'java');


insert into POST_AUTHOR (ID_POST, ID_AUTHOR) values ( 8, 1 );
insert into POST_TAG (ID_POST, ID_TAG) VALUES ( 8, 4);
