Views_ex.sql

--Core

--

create trigger LateRatingUpdate
instead of update of title on LateRating
for each row
when Old.mID=New.mID
begin
  update Movie
  set title = New.title
  where mID = Old.mID;
end;

--

create trigger LateRatingStarUpdate
instead of update of stars on LateRating
for each row
when Old.mID=New.mID and New.RatingDate=Old.RatingDate
begin
  update Rating
  set stars = New.stars
  where mID = Old.mID
  and RatingDate=Old.RatingDate;
end;

--

create trigger LateRatingmIDUpdate
instead of update of mID on LateRating
for each row
begin
  update Movie
  set mID = New.mID
  where mID = Old.mID;
  update Rating
  set mID = New.mID
  where mID = Old.mID;
end;


--

create trigger HighlyRatedDelete
instead of delete on HighlyRated
for each row
begin
  delete from Rating
  where mID = Old.mID
  and stars > 3;
end;


--

create trigger HighlyRatedDelete
instead of delete on HighlyRated
for each row
begin
  update Rating
  set stars = 3
  where mID = Old.mID
  and stars > 3;
end;



--Challenge Level

--
XXX

create trigger LateRatingUpdate
instead of update of mID, title, stars on LateRating
for each row
when Old.RatingDate=New.RatingDate
begin
  update Rating
  set mID=New.mID,
      stars=New.stars
  where mID=Old.mID and RatingDate=Old.RatingDate;
  update Movie
  set title = New.title,
      mID=New.mID
  where mID = Old.mID;
end;




create trigger LateRatingUpdate
instead of update of mID, title, stars on LateRating
for each row
when Old.RatingDate=New.RatingDate
begin
  update Rating
  set stars=New.stars
  where mID=Old.mID and RatingDate=Old.RatingDate;
  update Rating
  	set mID=New.mID
  where mID=Old.mID;
  update Movie
  set title = New.title,
      mID=New.mID
  where mID = Old.mID;
end;

--

create trigger HighlyRatedInsert
instead of insert on HighlyRated
for each row
when exists (select * from Movie where mID=New.mID and title=New.title)
begin
  insert into Rating values (201, New.mID, 5, null);
end;

--

create trigger NoRatingInsert
instead of insert on NoRating
for each row
when exists (select * from Movie where mID=New.mID and title=New.title)
begin
  delete from Rating
  	where mID=New.mID;
end;


--Extra Practice

create trigger NoRatingDelete
instead of delete on NoRating
for each row
when exists (select * from Movie where mID=Old.mID and title=Old.title)
begin
  delete from Movie where mID=Old.mID;
end;


--

create trigger NoRatingDelete
instead of delete on NoRating
for each row
when exists (select * from Movie where mID=Old.mID and title=Old.title)
begin
  insert into Rating values (201, Old.mID, 1, null);
end;




