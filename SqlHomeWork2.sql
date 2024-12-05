--Задача номер 1
insert into Musician(name)
values('Марта')

insert into Musician(name)
values('Джон')

insert into Musician(name)
values('Стив')

insert into Musician(name)
values('Шон')

insert into Ganre(name)
values('Рок')

insert into Ganre(name)
values('Поп')

insert into Ganre(name)
values('Кантри')

insert into Album(name, year_of_issue)
values('Весна', '2002-09-27')

insert into Album(name, year_of_issue)
values('Осень', '2019-02-19')

insert into Album(name, year_of_issue)
values('Лето', '2005-10-13')

insert into Album(name, year_of_issue)
values('Зима', '2007-11-20')

insert into Song(name, duration, album_id)
values('Свет', '00:02:45', '3')

--delete from Song 
--where id = 3

insert into Song(name, duration, album_id)
values('Тень', '00:03:21', '1')
 
insert into Song(name, duration, album_id)
values('Тьма', '00:02:56', '1')

insert into Song(name, duration, album_id)
values('Лучи', '00:03:03', '3')

insert into Song(name, duration, album_id)
values('Любовь', '00:03:09', '2')

insert into Song(name, duration)
values('Сосиска', '00:01:56')

insert into Song(name, duration, album_id)
values('Мечта', '00:04:01', '2')

insert into Collection(name, year_of_issue)
values('Утро', '2014-01-13')

insert into Collection(name, year_of_issue)
values('Обед', '2010-05-24')

insert into Collection(name, year_of_issue)
values('Вечер', '1998-10-07')

insert into Collection(name, year_of_issue)
values('Ночь', '2000-01-01')

insert into GanresMusicains(ganre_id, musician_id)
values('1', '4')

insert into GanresMusicains(ganre_id, musician_id)
values('2', '4')

insert into GanresMusicains(ganre_id, musician_id)
values('3', '1')

insert into GanresMusicains(ganre_id, musician_id)
values('2', '3')

insert into MusiciansAlbums(musician_id, albums_id)
values('1', '3')

insert into MusiciansAlbums(musician_id, albums_id)
values('2', '2')

insert into MusiciansAlbums(musician_id, albums_id)
values('4', '3')

insert into MusiciansAlbums(musician_id, albums_id)
values('3', '1')

insert into CollectionsSongs(collection_id, song_id)
values('4', '9')

insert into CollectionsSongs(collection_id, song_id)
values('1', '8')

insert into CollectionsSongs(collection_id, song_id)
values('2', '7')

insert into CollectionsSongs(collection_id, song_id)
values('3', '6')

insert into CollectionsSongs(collection_id, song_id)
values('4', '5')

insert into CollectionsSongs(collection_id, song_id)
values('2', '4')

insert into CollectionsSongs(collection_id, song_id)
values('1', '8')

insert into Collection(name, year_of_issue)
values('Мой кот', '2018-09-07')

insert into Song(name, duration, album_id)
values('Хомяк', '00:12:03', '4')

insert into Song(name, duration, album_id)
values('Собакен', '00:22:03', '4')

--Задача 2
--1.Название и продолжительность самого длительного трека.
select name, duration 
from Song   
order by duration desc 
limit 1

--2.Название треков, продолжительность которых не менее 3,5 минут.
select name, duration 
from Song
where duration >= '00:03:30'

--3.Названия сборников, вышедших в период с 2018 по 2020 год включительно.
select name
from Collection
where year_of_issue between '2018-01-01' and '2020-12-31' 

--4.Исполнители, чьё имя состоит из одного слова.
select name
from Musician
where LENGTH(name) - LENGTH(REPLACE(name, ' ', '')) = 0

--5.Название треков, которые содержат слово «мой» или «my».
select name
from Song s 
where "name" like '%my%' or "name" like '%мой%'

--Задача номер 3
--1.Количество исполнителей в каждом жанре.
select ganre_id, count(*)
from  ganresmusicains g 
group by ganre_id 

--2.Количество треков, вошедших в альбомы 2019–2020 годов.
select count(*) from  song s 
join  album a on s.album_id = a.id 
where a.year_of_issue between '2019-01-01' and '2020-01-01'

--3.Средняя продолжительность треков по каждому альбому.
select album_id, avg(duration) from  song 
group by album_id

--4.Все исполнители, которые не выпустили альбомы в 2020 году.
select m.name from musician m
join album a on m.id = a.id
WHERE year_of_issue not between '2020-01-01' and '2020-12-31'

--5.Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
select a.name from musician m
join album a on m.id = a.id
where m.name = 'Марта'
