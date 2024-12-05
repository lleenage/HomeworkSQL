--Задача номер 4(не обязательно)
--1.Названия альбомов, в которых присутствуют исполнители более чем одного жанра. 
select m.name from musician m 
join musiciansalbums m2 on m2.musician_id = m.id 
join album a on m2.albums_id = a.id 
join ganresmusicains g2 on g2.musician_id = m.id 
join ganre g on g2.ganre_id = g.id 
group by m.name
having count(m.name) > 1

--2.Наименования треков, которые не входят в сборники.
select s.name, c2.collection_id from song s 
left join collectionssongs c2 on s.id = c2.song_id 
left join collection c on c2.collection_id = c.id
where s.album_id = null 

--3.Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
select m.name from musician m 
right join musiciansalbums m2 on m.id = m2.musician_id 
right join song s on m2.albums_id = s.album_id 
order by duration 
limit 1

--4.Названия альбомов, содержащих наименьшее количество треков.
select a.name, s.name, min(s.album_id)  from album a 
join song s on a.id = s.album_id
group by a.name, s.name
order by min
limit 1