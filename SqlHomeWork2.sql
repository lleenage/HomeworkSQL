--Задача номер 1
insert into Musician(name) values
	('Марта'),
	('Джон'),
	('Стив'),
	('Шон');

insert into Ganre(name) values
	('Рок'),
	('Поп'),
	('Кантри');

insert into Album(name, year_of_issue) 
	values('Весна', '2002-09-27'),
	('Осень', '2019-02-19'),
	('Лето', '2005-10-13'),
	('Зима', '2007-11-20');

insert into Song(name, duration, album_id) values
	('Лунный Свет', '00:02:45', '3'),
	('Тень', '00:03:21', '1'),
	('Лучи', '00:03:03', '3'),
	('Тьма', '00:02:56', '1'),
	('Любовь', '00:03:09', '2'),
	('Сон', '00:01:56', '1'),
	('Мечта', '00:04:01', '2'),
	('Хомяк', '00:12:03', '4'),
	('Собакен', '00:22:03', '4'),
	('Рыбка', '00:01:03', '4'); 

insert into Song(name, duration, album_id) values
	('Sea song', '00:01:03', '3');	
	
update song 
set name = 'Мой собакен'
where id = 9;

insert into Collection(name, year_of_issue) values
	('Утро', '2014-01-13'),
	('Обед', '2010-05-24'),
	('Вечер', '1998-10-07'),
	('Ночь', '2000-01-01'),
	('Мой кот', '2018-09-07');

insert into GanresMusicains(ganre_id, musician_id) values
	('1', '4'),
	('2', '4'),
	('3', '1'),
	('2', '3');

insert into MusiciansAlbums(musician_id, albums_id) values
	('1', '3'),
	('2', '2'),
	('4', '3'),
	('3', '1');

insert into CollectionsSongs(collection_id, song_id) values
	('4', '1'),
	('1', '2'),
	('2', '3'),
	('3', '4'),
	('4', '5'),
	('2', '6'),
	('1', '7');
 
--Задача 2
--1.Название и продолжительность самого длительного трека.
select name, duration 
from Song   
order by duration desc 
limit 1;

--2.Название треков, продолжительность которых не менее 3,5 минут.
select name 
from Song
where duration >= '00:03:30';

--3.Названия сборников, вышедших в период с 2018 по 2020 год включительно.
select name
from Collection
where year_of_issue between '2018-01-01' and '2020-12-31';

--4.Исполнители, чьё имя состоит из одного слова.
select name
from Musician
where LENGTH(name) - LENGTH(REPLACE(name, ' ', '')) = 0;

--5.Название треков, которые содержат слово «мой» или «my».
select name
from Song s 
where "name" ilike 'мой %' or
	"name" ilike 'my %' or 
	"name" ilike '% мой' or 
	"name" like '% my' or
	"name" ilike '% my %' or
	"name" ilike '% мой %' or
	"name" ilike 'my' or
	"name" ilike 'мой'; 

--Задача номер 3
--1.Количество исполнителей в каждом жанре.
select ganre_id, count(*)
from  ganresmusicains g 
group by ganre_id;

--2.Количество треков, вошедших в альбомы 2019–2020 годов.
select count(*) from  song s 
join  album a on s.album_id = a.id 
where a.year_of_issue between '2019-01-01' and '2020-01-01';

--3.Средняя продолжительность треков по каждому альбому.
select album_id, avg(duration) from  song 
group by album_id;

--4.Все исполнители, которые не выпустили альбомы в 2020 году.
SELECT m.name from musician m /* Получаем имена исполнителей */
WHERE m.name NOT IN ( /* Где имя исполнителя не входит в вложенную выборку */
    SELECT m1.name 
    from musician m1 /* Получаем имена исполнителей */
    JOIN musiciansalbums m2 ON m1.id = m2.musician_id
    JOIN album a ON m2.albums_id = a.id /* Объединяем с таблицей альбомов */
    WHERE year_of_issue between '2020-01-01' and '2020-12-31' /* Где год альбома равен 2020 */
);

--5.Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
SELECT DISTINCT c.name /* Имена сборников */
FROM collection c /* Из таблицы сборников */
JOIN collectionssongs c2 ON c.id = c2.collection_id /* Объединяем с промежуточной таблицей между сборниками и треками */
JOIN song s ON c2.song_id = s.id /* Объединяем с треками */
JOIN album a ON s.album_id = a.id /* Объединяем с альбомами */
JOIN musiciansalbums m2 ON a.id = m2.albums_id /* Объединяем с промежуточной таблицей между альбомами и исполнителями */
JOIN musician m ON m2.musician_id = m.id /* Объединяем с исполнителями */
WHERE m.name = 'Марта'; /* Где имя исполнителя равно определенному шаблону имени */

--Задача номер 4
--1.Названия альбомов, в которых присутствуют исполнители более чем одного жанра. 
select a.name from album a
left join musiciansalbums m2 on a.id = m2.albums_id 
left join musician m on m2.musician_id = m.id 
left join ganresmusicains g2 on m.id = g2.musician_id 
left join ganre g on g2.ganre_id = g.id 
group by a.name
having count(g.name) > 1;

--2.Наименования треков, которые не входят в сборники.
select s.name from song s 
left join collectionssongs c2 on s.id = c2.song_id
where c2.collection_id is null;

--3.Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
select m.name from musician m 
join musiciansalbums m2 on m.id = m2.musician_id 
join album a on m2.albums_id = a.id 
join song s on a.id = s.album_id 
where s.duration = (
	select min(s.duration) from song s 
	join musiciansalbums ma on s.album_id = ma.albums_id
);

--4.Названия альбомов, содержащих наименьшее количество треков.
select a.name from album a 
join song s on a.id = s.album_id
group by a.name
having count(s.name) = (
	select count(s2.id) from song s2 
	group by s2.album_id
	order by 1
	limit 1
);
