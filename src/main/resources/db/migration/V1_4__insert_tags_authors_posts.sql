insert into TAG (ID, DESCRIPTION)
values (1, 'Java'), (2, 'Angular'), (3, 'MySQL'), (4, 'Docker'), (5, 'Kubernetes');


insert into AUTHOR (ID, NAME, EMAIL)
values (1, 'Gaspar Barancelli Junior', 'gasparbarancelli@gmail.com'),
       (2, 'João Chagas', 'jvrc2000@outlook.com');

insert into POST (ID, TITLE, LAST_MODIFIED, SUMMARY, DESCRIPTION)
values (
    1,
    'Java Spring OAuth2 and Basic Auth Support',
    current_date,
    'The goal of the post is to share an idea of how can we provide the basic authentication and OAuth 2 authentication for the APIs.',
    'Description'
), (
    2,
    'How to Run JMeter Test Plan Via Docker',
    current_date,
    'I decided that my journey to learn to run JMeter is interesting and that’s when I decided to write a blog. So here I am, sharing what I learnt.',
    'Description'
);

insert into POST_AUTHOR (ID_POST, ID_AUTHOR) values ( 1, 1 ), ( 2, 2 );
insert into POST_TAG (ID_POST, ID_TAG) VALUES ( 1, 1 ), ( 2, 1 ), ( 2, 4 );
