<div class="container">
    <header>
        <a href="">
            DZONE > Big Data Zone > Language Integrated Queries In Ballerina
        </a>
    </header>
    <section>
        <h2>${post.title}</h2>
        <p>
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt
            ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
            laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit
            in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
            cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        </p>
    </section>
    <section>
        <img> by Mohanadarshan Vivekanandalingam · Oct. 16, 20 · Big Data Zone · Analysis
    </section>
    <section>
        <h2>Introduction</h2>
        <p>
            Data processing is one of the critical components of enterprise integration. Even though there are various approaches to process data, query expressions are usually considered the go-to approach. Language integrated queries specify the logic in SQL-like syntax to process the data/events, and they are easy to write and understand due to the simplicity of the syntax. The Ballerina programming language provides first-class support to write queries for data processing. In this article, we will discuss the query language support in Ballerina with some examples.

            As of now, language integrated queries are supported for iterator implementations such as an array, map, stream, and table. There are two kinds of integrated queries that can be written in Ballerina — query expression, which allows generating a list, table, string or XML; stream and query action, which executes a set of statements for each element of the iterator.
        </p>
        <h2>Query Expressions</h2>
        <p>
            Query expressions contain a set of clauses similar to SQL to process the data. Query expressions must start with the `from` clause and can perform various operations such as filter, join, sort, limit, and projection. There are various SQL like clauses to perform these operations.

            Query Clauses

            `from` clause - Defines an input source/iterator
            `where` clause - Defines a filtering condition
            `let` clause - Defines a variable that could be used in the subsequent clauses
            `join` clause - Defines an input source/iterator for joining purposes. It performs an inner or left outer equijoin.
            `order by` clause - Defines the sorting logic
            `limit` clause - Limits the number of elements passed to the next clause
            `select` clause - Performs the projection. Outputs a list, table, string, XML, or stream.
            `on conflict` clause - Allows only for a query expression that constructs a table with a key sequence to avoid duplicates
        </p>
    </section>
</div>
