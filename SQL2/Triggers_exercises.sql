Triggers_exercises.sql
/*

*/

--1

create trigger TR1
after insert on Highschooler
for each row
when New.name = 'Friendly'
begin
  insert into Likes 
  select New.ID , Highschooler.ID 
  from Highschooler where Highschooler.grade=New.grade and Highschooler.ID<>New.ID;
end;

--2

create trigger TR1
after insert on Highschooler
for each row
when New.grade is null
begin
  update Highschooler
  set grade = 9
  where Highschooler.ID = New.ID;
end;

|

create trigger TR2
after insert on Highschooler
for each row
when New.grade < 9 or New.grade > 12
begin
  update Highschooler
  set grade = NULL
  where Highschooler.ID = New.ID;
end;


--3

create trigger TR2
after update of grade on Highschooler
for each row
when Old.grade = 12 and New.grade > 12
begin
  delete from Highschooler
  where Highschooler.ID = Old.ID;
end;


--Challenge Level


--1
create trigger TR1
after insert on Friend
for each row
when not exists (select * from Friend where Friend.ID1 = New.ID2 and Friend.ID2 = New.ID1)
begin
  insert into Friend values(New.ID2,New.ID1);
end;

|

create trigger TR2
after delete on Friend
for each row
when exists (select * from Friend where Friend.ID1 = Old.ID2 and Friend.ID2 = Old.ID1)
begin
  delete from Friend
  where Friend.ID1 = Old.ID2 and Friend.ID2 = Old.ID1;
end;

--2


create trigger TR2
after update of grade on Highschooler
for each row
when  New.grade > 12
begin
  delete from Highschooler
  where Highschooler.ID = Old.ID;
end;

|

create trigger TR1
after update of grade on Highschooler
for each row
when  (select grade from Highschooler where grade = old.grade+1)
begin
  update Highschooler
  set grade = grade+1
  where Highschooler.ID in (select ID2 from Friend where ID1=Old.ID);
end;


--3

create trigger TR2
after update of ID2 on Likes
for each row
when exists (select * from Friend where ID1=Old.ID2 and ID2=New.ID2) and Old.ID1=New.ID1
begin
  delete from Friend
  where (Friend.ID1 = Old.ID2 and Friend.ID2=New.ID2) or (Friend.ID1 = New.ID2 and Friend.ID2=Old.ID2);
end;










