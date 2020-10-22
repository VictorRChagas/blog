insert into TAG (ID, DESCRIPTION, URL)
values (1, 'Java', 'java'),
       (2, 'Angular', 'angular'),
       (3, 'MySQL', 'mysql'),
       (4, 'Docker', 'docker'),
       (5, 'Kubernetes', 'kubernetes');


insert into AUTHOR (ID, NAME, EMAIL)
values (1, 'Gaspar Barancelli Junior', 'gasparbarancelli@gmail.com'),
       (2, 'João Chagas', 'jvrc2000@outlook.com');


insert into POST (ID, TITLE, URL, LAST_MODIFIED, SUMMARY, DESCRIPTION, DESCRIPTION_HTML)
values (
    1,
    'Java Spring OAuth2 and Basic Auth Support',
    'java-spring-oauth2-and-basic-auth-support',
    current_date,
    'The goal of the post is to share an idea of how can we provide the basic authentication and OAuth 2 authentication for the APIs.',
    '= Hello, AsciiDoc!
Doc Writer <doc@example.com>

An introduction to http://asciidoc.org[AsciiDoc].

== First Section

* item 1
* item 2

[source,ruby]
puts "Hello, World!"',
'<div id="preamble">
<div class="sectionbody">
<div class="paragraph">
<p>An introduction to <a href="http://asciidoc.org">AsciiDoc</a>.</p>
</div>
</div>
</div>
<div class="sect1">
<h2 id="_first_section">First Section</h2>
<div class="sectionbody">
<div class="ulist">
<ul>
<li>
<p>item 1</p>
</li>
<li>
<p>item 2</p>
</li>
</ul>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-ruby" data-lang="ruby">puts "Hello, World!"</code></pre>
</div>
</div>
</div>
</div>

Process finished with exit code 0
'
), (
    2,
    'How to Run JMeter Test Plan Via Docker',
    'how-to-run-jmeter-teste-plan-via-docker',
    current_date,
    'I decided that my journey to learn to run JMeter is interesting and that’s when I decided to write a blog. So here I am, sharing what I learnt.',
    '= Hello, AsciiDoc!
Doc Writer <doc@example.com>

An introduction to http://asciidoc.org[AsciiDoc].

== First Section

* item 1
* item 2

[source,ruby]
puts "Hello, World!"',
    '<div id="preamble">
    <div class="sectionbody">
    <div class="paragraph">
    <p>An introduction to <a href="http://asciidoc.org">AsciiDoc</a>.</p>
    </div>
    </div>
    </div>
    <div class="sect1">
    <h2 id="_first_section">First Section</h2>
    <div class="sectionbody">
    <div class="ulist">
    <ul>
    <li>
    <p>item 1</p>
    </li>
    <li>
    <p>item 2</p>
    </li>
    </ul>
    </div>
    <div class="listingblock">
    <div class="content">
    <pre class="highlight"><code class="language-ruby" data-lang="ruby">puts "Hello, World!"</code></pre>
    </div>
    </div>
    </div>
    </div>

    Process finished with exit code 0
    '
);

insert into POST_AUTHOR (ID_POST, ID_AUTHOR) values ( 1, 1 ), ( 2, 2 );
insert into POST_TAG (ID_POST, ID_TAG) VALUES ( 1, 1 ), ( 2, 1 ), ( 2, 4 );
