create table if not exists Ganre(
	id SERIAL primary key,
	name VARCHAR(60) not NULL
);

create table if not exists Musician(
	id SERIAL primary key,
	name VARCHAR(60) not NULL
);
	
create table if not exists Album(
	id SERIAL primary key,
	name VARCHAR(60) not null,
	year_of_issue DATE not null
);
	
create table if not exists Song(
	id SERIAL primary key,
	name VARCHAR(60) not null,
	duration TIME not NULL,
	album_id INTEGER references Album(id)  
);
	
create table if not exists Collection(
	id SERIAL primary key,
	name VARCHAR(60) not null,
	year_of_issue DATE not NULL
);

create table if not exists CollectionsSongs(
	collection_id INTEGER references Collection(id),
	song_id INTEGER references Song(id)  
);

create table if not exists GanresMusicains(
	id SERIAL primary key,
	ganre_id  INTEGER references Ganre(id),
	musician_id INTEGER references Musician(id)
);

create table if not exists MusiciansAlbums(
	id SERIAL primary key,
	musician_id INTEGER references Musician(id),
	albums_id INTEGER references Album(id)
);