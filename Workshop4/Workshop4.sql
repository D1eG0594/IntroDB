create table if not exists usuario(
	id_number uuid default gen_random_uuid(),
	name varchar(50) not null,
	enail varchar(30) unique,
	phone varchar(50),
	nickname varchar(20) unique not null,
	password varchar(30) not null,
	musical_genre_fk int not null,
	country_fk int not null,
	primary key (id_number),
	foreign key (musical_genre_fk) references musicalgenre(id_genre),
	foreign key (country_fk) references country(code)
);

insert into usuario(name, enail, phone, nickname, password, musical_genre_fk, country_fk) values ('Diego', 'hola@gmail.com', '35165486', 'D1eG0', '123456789', 1, 57);
insert into usuario(name, enail, phone, nickname, password, musical_genre_fk, country_fk) values ('Juan', 'hola1@gmail.com', '35165655', 'Juan54', '12348242', 2, 65);
insert into usuario(name, enail, phone, nickname, password, musical_genre_fk, country_fk) values ('Carlos', 'hola2@gmail.com', '35165987', 'CarlosPro', '12349846', 3, 1);
insert into usuario(name, enail, phone, nickname, password, musical_genre_fk, country_fk) values ('Pepito', 'hola3@gmail.com', '35165632', 'Pepito69', '1234fdgfd', 4, 25);
insert into usuario(name, enail, phone, nickname, password, musical_genre_fk, country_fk) values ('Pepita', 'hola4@gmail.com', '35165752', 'Pepita4', '12345ffdgg', 5, 85);
insert into usuario(name, enail, phone, nickname, password, musical_genre_fk, country_fk) values ('Daniel', 'hola5@gmail.com', '35165854', 'Daniel8', '12345ffasf', 5, 85);
insert into usuario(name, enail, phone, nickname, password, musical_genre_fk, country_fk) values ('Laura', 'hola6@gmail.com', '35167896', 'Laura89', '12345fgregsd', 3, 85);
insert into usuario(name, enail, phone, nickname, password, musical_genre_fk, country_fk) values ('Sara', 'hola7@gmail.com', '35167142', 'Sara85', '12345fkjl', 1, 85);
insert into usuario(name, enail, phone, nickname, password, musical_genre_fk, country_fk) values ('Alejandro', 'hola8@gmail.com', '35168562', 'Alejandro2004', '12345ffd654', 2, 85);
insert into usuario(name, enail, phone, nickname, password, musical_genre_fk, country_fk) values ('Kevin', 'hola9@gmail.com', '3517425', 'Kevin89', '12345ff8462', 1, 85);

create table if not exists channel(
	id_channel serial primary key,
	name varchar(30) not null,
	description varchar(200),
	usuario_fk uuid not null,
	foreign key (usuario_fk) references usuario(id_number)
);


create table if not exists MusicalGenre(
	id_genre serial primary key,
	name varchar(15) not null,
	description varchar(100)
);
insert into musicalgenre (id_genre, name) values('Pop');
insert into musicalgenre (name) values('Rock');
insert into musicalgenre (name) values('Salsa');
insert into musicalgenre (name) values('Vallenato');
insert into musicalgenre (name) values('Piano');



create table if not exists country(
	code int primary key,
	name varchar(25) unique not null
);
insert into country (code, name) values (57,'Colombia');
insert into country (code, name) values (65,'Chile');
insert into country (code, name) values (1,'Estados Unidos');
insert into country (code, name) values (25,'Panama');
insert into country (code, name) values (85,'España');




create table if not exists community (
	id_community serial primary key,
	name varchar(25) unique not null,
	description varchar(200)
);


create table if not exists playlist(
	id_playlist serial primary key,
	name varchar(30) not null,
	likes int default 0,
	usuario_fk uuid not null,
	foreign key (usuario_fk) references usuario(id_number)
);

create table if not exists video(
	id_video serial primary key,
	name varchar(100) not null,
	date_upload int not null,
	likes int default 0,
	dsilikes int default 0,
	usuario_fk uuid not null,
	genre_fk int not null,
	channel_fk int not null,
	foreign key (usuario_fk) references usuario(id_number),
	foreign key (genre_fk) references musicalgenre(id_genre),
	foreign key (channel_fk) references channel(id_channel)
)

create table if not exists comment(
	id_comment serial primary key,
	content varchar(300) not null,
	date_creation varchar(30) not null,
	likes int default 0,
	dislikes int default 0,
	usuario_fk uuid not null,
	video_fk int not null,
	foreign key (usuario_fk) references usuario(id_number),
	foreign key (video_fk) references video(id_video)
)

create table if not exists bankaccount(
	id_account int primary key,
	bank_name varchar(30) not null,
	account_number int not null,
	country_fk int not null,
	usuario_fk uuid not null,
	foreign key (country_fk) references country(code),
	foreign key (usuario_fk) references usuario(id_number)
)


create table if not exists playlist_video_rel(
	playlist_fk int not null,
	video_fk int not null,
	primary key(playlist_fk, video_fk),
	foreign key (playlist_fk) references playlist(id_playlist),
	foreign key (video_fk) references video(id_video)
)

create table if not exists community_user_rel(
	community_fk int not null,
	usuario_fk uuid not null,
	expiration_date varchar(50),
	primary key(community_fk, usuario_fk),
	foreign key (usuario_fk) references usuario(id_number),
	foreign key (community_fk) references community(id_community)
)


create table if not exists subscriber_rel(
	channel_fk int not null,
	usuario_fk uuid not null,
	primary key(channel_fk, usuario_fk),
	foreign key (usuario_fk) references usuario(id_number),
	foreign key (channel_fk) references channel(id_channel)
)



--Selects-----------------------
--1
select video.name as Videos_Colombia 
from video
join usuario u on video.usuario_fk = usuario.id_number 
join country c on usuario.country_fk = country.code
where country.code = 57;

--2
SELECT mg.name AS genre_name, COUNT(v.id_video) AS video_count
FROM video v
JOIN musicalgenre mg ON v.genre_fk = mg.id_genre
GROUP BY mg.name;


--3
SELECT v.*, u.name AS user_name, u.enail AS user_email
FROM video v
JOIN usuario u ON v.usuario_fk = u.id_number
WHERE v.likes > 20;


--4
SELECT DISTINCT c.*
FROM channel c
JOIN subscriber_rel s ON c.id_channel = s.channel_fk
JOIN usuario u ON s.usuario_fk = u.id_number
JOIN country co ON u.country_fk = co.code
WHERE co.name = 'Colombia';

--5
SELECT c.*, u.name AS user_name, v.name AS video_name
FROM comment c
JOIN usuario u ON c.usuario_fk = u.id_number
JOIN video v ON c.video_fk = v.id_video
WHERE c.content LIKE '%ugly%';

--6
SELECT u.*, c.name AS country_name, b.bank_name, mg.name AS preferred_genre
FROM usuario u
LEFT JOIN country c ON u.country_fk = c.code
LEFT JOIN bankaccount b ON u.id_number = b.usuario_fk
LEFT JOIN musicalgenre mg ON u.musical_genre_fk = mg.id_genre
ORDER BY u.enail
LIMIT 3;





