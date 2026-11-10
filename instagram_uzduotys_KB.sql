-- =====================================================
-- Instagram duomenų bazė: 40 SQL užduočių
-- Prieš vykdant reikia įkelti duomenų bazę iš instagram.sql
-- =====================================================

USE instagram;

-- 1 užduotis
-- Užduotis: Parodykite visų patvirtintų (is_verified = 1) vartotojų vartotojo vardus ir
-- pilnus vardus bei pavardes.
-- Rezultato pavyzdys (pirmos 5 iš 9 eil.):
-- +----------------------+----------------------+
-- | username             | full_name            |
-- +----------------------+----------------------+
-- | jkazlauskaite28      | Jurgita Kazlauskaitė |
-- | aurbonas76           | Arnas Urbonas        |
-- | vzukauskas32         | Vytautas Žukauskas   |
-- | lvaitkus90           | Lukas Vaitkus        |
-- | laura_jankauskaite39 | Laura Jankauskaitė   |
-- +----------------------+----------------------+
select 
username,
full_name
from users 
where is_verified=1;

-- 2 užduotis
-- Užduotis: Suskaičiuokite, kiek vartotojų turi privačią paskyrą (is_private = 1).
-- Rezultato pavyzdys (viso 1 eil.):
-- +---------------+
-- | private_users |
-- +---------------+
-- |            29 |
-- +---------------+
select 
count(id) as private_users 
from users 
where is_private=1;

-- 3 užduotis
-- Užduotis: Suraskite visus įrašus, kurių vietovė yra „Trakai“. Išveskite įrašo ID,
-- autoriaus ID ir aprašymą.
-- Rezultato pavyzdys (pirmos 5 iš 55 eil.):
-- +----+---------+--------------------------+
-- | id | user_id | caption                  |
-- +----+---------+--------------------------+
-- |  3 |      71 | Rytinė kava ☕           |
-- | 19 |     142 | Savaitgalio nuotykiai 🏞️ |
-- | 32 |     161 | Geriausia kompanija ❤️   |
-- | 33 |     117 | Rytinė kava ☕           |
-- | 37 |      64 | Rytinė kava ☕           |
-- +----+---------+--------------------------+
select 
id,
user_id,
caption
from posts
where location = 'Trakai';

-- 4 užduotis
-- Užduotis: Išveskite įrašus, kurie surinko daugiau nei 35 patiktukus. Parodykite įrašo ID,
-- autoriaus ID ir patiktukų skaičių.
-- Rezultato pavyzdys (pirmos 5 iš 227 eil.):
-- +----+---------+-------------+
-- | id | user_id | likes_count |
-- +----+---------+-------------+
-- |  6 |     200 |          41 |
-- |  8 |     114 |          45 |
-- |  9 |      81 |          37 |
-- | 16 |      41 |          45 |
-- | 24 |      32 |          43 |
-- +----+---------+-------------+
select 
id,
user_id,
likes_count
from posts
where likes_count>35;

-- 5 užduotis
-- Užduotis: Suraskite reels, kurių trukmė yra nuo 30 iki 45 sekundžių (imtinai) ir kuriuose
-- naudojamas garsas „Lo-fi morning“.
-- Rezultato pavyzdys (pirmos 5 iš 20 eil.):
-- +-----+---------+---------------+--------------+
-- | id  | user_id | audio_name    | duration_sec |
-- +-----+---------+---------------+--------------+
-- |  16 |     165 | Lo-fi morning |           40 |
-- |  24 |      23 | Lo-fi morning |           43 |
-- |  51 |      37 | Lo-fi morning |           44 |
-- | 129 |     122 | Lo-fi morning |           40 |
-- | 132 |     177 | Lo-fi morning |           37 |
-- +-----+---------+---------------+--------------+
select 
id,
user_id,
audio_name,
duration_sec
from reels
where duration_sec between 30 and 45 
and audio_name= 'Lo-fi morning';

-- 6 užduotis
-- Užduotis: Išveskite vartotojus, kurių vartotojo vardas prasideda raide „m“. Parodykite
-- vartotojo ID, vartotojo vardą ir el. paštą.
-- Rezultato pavyzdys (pirmos 5 iš 19 eil.):
select 
id,
username,
email
from users
where username like 'm%'
order by id;
-- +----+----------------------+----------------------------------+
-- | id | username             | email                            |
-- +----+----------------------+----------------------------------+
-- | 16 | mstankeviciute93     | mstankeviciute93@example.com     |
-- | 24 | mbutkute63           | mbutkute63@example.com           |
-- | 38 | migle_kazlauskaite71 | migle_kazlauskaite71@example.com |
-- | 49 | mvaitkus34           | mvaitkus34@example.com           |
-- | 56 | mpetrauskas85        | mpetrauskas85@example.com        |
-- +----+----------------------+----------------------------------+

-- 7 užduotis
-- Užduotis: Suraskite įrašus, kurie neturi aprašymo (caption yra NULL), bet turi nurodytą
-- vietovę (location nėra NULL).
-- Rezultato pavyzdys (pirmos 5 iš 43 eil.):
select 
id,
user_id,
location
from posts
where caption is null 
and location is not null;
-- +----+---------+--------------+
-- | id | user_id | location     |
-- +----+---------+--------------+
-- | 12 |     178 | Kaunas       |
-- | 35 |      89 | Palanga      |
-- | 48 |      33 | Palanga      |
-- | 52 |      84 | Trakai       |
-- | 76 |     141 | Druskininkai |
-- +----+---------+--------------+

-- 8 užduotis
-- Užduotis: Išveskite komentarus, kurie yra atsakymai į kitus komentarus (parent_comment_id
-- nėra NULL) ir surinko bent 3 patiktukus.
-- Rezultato pavyzdys (pirmos 5 iš 225 eil.):
select 
id,
user_id,
parent_comment_id,
content,
likes_count
from comments
where parent_comment_id is not null 
and likes_count>=3;

-- +-----+---------+-------------------+----------------------+-------------+
-- | id  | user_id | parent_comment_id | content              | likes_count |
-- +-----+---------+-------------------+----------------------+-------------+
-- |  24 |     113 |                22 | Taip, rekomenduoju!  |           3 |
-- |  37 |     137 |                36 | Ačiū už gerą žodį ❤️ |           9 |
-- |  63 |      49 |                61 | Būtinai nuvažiuok!   |           5 |
-- | 107 |       2 |               103 | Ačiū už gerą žodį ❤️ |           8 |
-- | 127 |     142 |               123 | Haha, ačiū 😄        |           3 |
-- +-----+---------+-------------------+----------------------+-------------+

-- 9 užduotis
-- Užduotis: Parodykite 10 naujausių įrašų: įrašo ID, autoriaus ID ir sukūrimo datą.
-- Rezultato pavyzdys (pirmos 5 iš 10 eil.):
select 
id,
user_id,
created_at
from posts
order by created_at desc
limit 10;
-- +-----+---------+---------------------+
-- | id  | user_id | created_at          |
-- +-----+---------+---------------------+
-- | 482 |     180 | 2026-09-26 19:36:16 |
-- | 136 |     145 | 2026-09-26 12:34:42 |
-- |  38 |     158 | 2026-09-26 05:23:54 |
-- | 833 |     100 | 2026-09-25 14:00:50 |
-- | 334 |     182 | 2026-09-24 05:27:53 |
-- +-----+---------+---------------------+

-- 10 užduotis
-- Užduotis: Suraskite 5 reels, kurie turi daugiausiai peržiūrų. Parodykite reel ID, aprašymą
-- ir peržiūrų skaičių.
-- Rezultato pavyzdys (viso 5 eil.):
select 
id,
caption,
views_count
from reels
order by views_count desc
limit 5;

-- +-----+-------------------------------+-------------+
-- | id  | caption                       | views_count |
-- +-----+-------------------------------+-------------+
-- | 539 | Kelionių akimirkos ✈️          |     1238788 |
-- | 491 | Mano diena per 30 sekundžių ⏱️ |      154988 |
-- | 305 | Gamtos garsai 🌿              |       82718 |
-- | 176 | Šuniukas žaidžia 🐶           |       53344 |
-- | 466 | Recepto gidas 🍳              |       17643 |
-- +-----+-------------------------------+-------------+

-- 11 užduotis
-- Užduotis: Išveskite 5 seniausiai užsiregistravusius vartotojus. Parodykite vartotojo vardą
-- ir registracijos datą.
-- Rezultato pavyzdys (viso 5 eil.):
select 
username,
created_at
from users
order by created_at
limit 5;
-- +-------------------------+---------------------+
-- | username                | created_at          |
-- +-------------------------+---------------------+
-- | ieva_jankauskaite23     | 2024-04-23 01:00:59 |
-- | abalciunas82            | 2024-04-30 22:29:35 |
-- | astankevicius60         | 2024-05-03 19:00:24 |
-- | tomas_urbonas63         | 2024-05-06 21:52:32 |
-- | vytautas_stankevicius18 | 2024-05-10 05:25:40 |
-- +-------------------------+---------------------+

-- 12 užduotis
-- Užduotis: Išveskite įrašus, užimančius 6–10 vietas pagal patiktukų skaičių. Lygybės atveju
-- rikiuokite pagal įrašo ID.
-- Rezultato pavyzdys (viso 5 eil.):
select 
id,
user_id,
likes_count
from posts
order by likes_count desc, id
limit 5, 5;

-- +-----+---------+-------------+
-- | id  | user_id | likes_count |
-- +-----+---------+-------------+
-- |  97 |     145 |          45 |
-- |  98 |     147 |          45 |
-- | 115 |     194 |          45 |
-- | 135 |      82 |          45 |
-- | 142 |      13 |          45 |
-- +-----+---------+-------------+

-- 13 užduotis
-- Užduotis: Parodykite 3 ilgiausius reels, kuriuose naudojamas garsas „Summer beat“.
-- Rezultato pavyzdys (viso 3 eil.):
select 
id,
user_id,
audio_name,
duration_sec
from reels
where audio_name = 'Summer beat'
order by duration_sec desc
limit 3;
-- +-----+---------+-------------+--------------+
-- | id  | user_id | audio_name  | duration_sec |
-- +-----+---------+-------------+--------------+
-- | 568 |       3 | Summer beat |           89 |
-- | 119 |      72 | Summer beat |           87 |
-- | 141 |      14 | Summer beat |           85 |
-- +-----+---------+-------------+--------------+

-- 14 užduotis
-- Užduotis: Išveskite 10 komentarų, surinkusių daugiausiai patiktukų. Jei patiktukų skaičius
-- vienodas, pirmenybę teikite naujesniems komentarams.
-- Rezultato pavyzdys (pirmos 5 iš 10 eil.):
select 
id,
content,
likes_count,
created_at
from comments
order by likes_count desc, created_at desc
limit 10;
-- +------+---------------------+-------------+---------------------+
-- | id   | content             | likes_count | created_at          |
-- +------+---------------------+-------------+---------------------+
-- | 4046 | Tobula! ✨          |          12 | 2026-09-28 07:55:51 |
-- | 3249 | Šaunuolis! 💪       |          12 | 2026-09-28 06:37:52 |
-- | 4133 | Žinoma, susitinkam! |          12 | 2026-09-28 05:42:03 |
-- | 4442 | Sony A7 III         |          12 | 2026-09-28 05:14:25 |
-- |  258 | Labai graži vieta!  |          12 | 2026-09-27 22:16:07 |
-- +------+---------------------+-------------+---------------------+


-- =====================================================
-- 3 DALIS (15–22 UŽDUOTYS)
-- =====================================================

-- 15 užduotis
-- Užduotis: Suskaičiuokite, kiek įrašų sukurta kiekvienoje vietovėje (įrašus be vietovės
-- praleiskite). Rezultatą išrikiuokite pagal įrašų skaičių mažėjimo tvarka.
-- Rezultato pavyzdys (pirmos 5 iš 10 eil.):
select 
location,
count(*) as post_cnt
from posts
where location is not null
group by location
order by post_cnt desc;
-- +-----------+----------+
-- | location  | post_cnt |
-- +-----------+----------+
-- | Palanga   |       60 |
-- | Birštonas |       58 |
-- | Trakai    |       55 |
-- | Vilnius   |       52 |
-- | Klaipėda  |       50 |
-- +-----------+----------+

-- 16 užduotis
-- Užduotis: Apskaičiuokite vidutinę reels trukmę pagal naudojamą garsą (audio_name).
-- Rezultatą suapvalinkite iki vienos dešimtosios dalies.
-- Rezultato pavyzdys (pirmos 5 iš 8 eil.):
select 
audio_name,
round(avg(duration_sec),1) as avg_duration
from reels
group by audio_name
order by avg_duration desc;
-- +---------------+--------------+
-- | audio_name    | avg_duration |
-- +---------------+--------------+
-- | Dance floor   |         48.4 |
-- | Summer beat   |         48.4 |
-- | Night drive   |         47.9 |
-- | Chill vibes   |         47.5 |
-- | Lo-fi morning |         47.3 |
-- +---------------+--------------+

-- 17 užduotis
-- Užduotis: Suraskite vartotojus, kurie yra sukūrę daugiau nei 8 įrašus. Parodykite
-- vartotojo ID ir įrašų skaičių.
-- Rezultato pavyzdys (pirmos 5 iš 12 eil.):
select 
user_id,
count(*) as post_cnt
from posts
group by user_id
having post_cnt >8
order by post_cnt desc;

-- +---------+----------+
-- | user_id | post_cnt |
-- +---------+----------+
-- |     153 |       11 |
-- |     158 |       11 |
-- |     167 |       11 |
-- |     179 |       10 |
-- |      58 |        9 |
-- +---------+----------+

-- 18 užduotis
-- Užduotis: Raskite 5 vartotojus, kurių reels iš viso surinko daugiausiai peržiūrų.
-- Rezultato pavyzdys (viso 5 eil.):
select 
user_id,
sum(views_count) as total_views
from reels
group by user_id
order by total_views desc
limit 5;
-- +---------+-------------+
-- | user_id | total_views |
-- +---------+-------------+
-- |     152 |     1240871 |
-- |     110 |      157171 |
-- |      32 |       87313 |
-- |     170 |       54272 |
-- |      86 |       21858 |
-- +---------+-------------+

-- 19 užduotis
-- Užduotis: Suskaičiuokite, kiek įrašų buvo sukurta kiekvieną 2026 m. mėnesį.
-- Rezultato pavyzdys (pirmos 5 iš 9 eil.):
select 
month(created_at) as month_no,
count(*) as post_cnt
from posts 
where year(created_at)=2026
group by month_no
order by month_no;

-- +----------+----------+
-- | month_no | post_cnt |
-- +----------+----------+
-- |        1 |       88 |
-- |        2 |       81 |
-- |        3 |       88 |
-- |        4 |       96 |
-- |        5 |       90 |
-- +----------+----------+

-- 20 užduotis
-- Užduotis: Suskaičiuokite, kiek komentarų yra paliekama po įrašais ir kiek po reels.
-- Rezultate turi būti rodomas objekto tipas ir komentarų skaičius.
-- Rezultato pavyzdys (viso 2 eil.):
select 
case 
    when reel_id is not null then 'Reel'
    when post_id is not null then 'Įrašas'
    end as target_type,
count(*) as comment_cnt
from comments
group by target_type
order by comment_cnt;

-- +-------------+-------------+
-- | target_type | comment_cnt |
-- +-------------+-------------+
-- | Reel        |        2067 |
-- | Įrašas      |        3399 |
-- +-------------+-------------+

-- 21 užduotis
-- Užduotis: Suskaičiuokite, kiek yra vartotojų kiekvienoje kategorijoje pagal patvirtinimo
-- (is_verified) ir paskyros privatumo (is_private) požymius.
-- Rezultato pavyzdys (viso 4 eil.):
select 
is_verified,
is_private,
count(*) as user_cnt
from users
group by is_verified,is_private
order by user_cnt;
-- +-------------+------------+----------+
-- | is_verified | is_private | user_cnt |
-- +-------------+------------+----------+
-- |           1 |          1 |        1 |
-- |           1 |          0 |        8 |
-- |           0 |          1 |       28 |
-- |           0 |          0 |      163 |
-- +-------------+------------+----------+

-- 22 užduotis
-- Užduotis: Apskaičiuokite vidutinį įrašų patiktukų skaičių kiekvienoje vietovėje,
-- įtraukdami tik tas vietoves, kuriose yra ne mažiau kaip 45 įrašai.
-- Rezultato pavyzdys (pirmos 5 iš 8 eil.):
select 
location,
count(*) as post_cnt,
round(avg(likes_count),2) as avg_likes
from posts
where location is not null
group by location
having post_cnt>45
order by avg_likes desc;

-- +--------------+----------+-----------+
-- | location     | post_cnt | avg_likes |
-- +--------------+----------+-----------+
-- | Palanga      |       60 |     23.15 |
-- | Klaipėda     |       50 |     22.76 |
-- | Trakai       |       55 |     22.35 |
-- | Druskininkai |       48 |     22.17 |
-- | Kaunas       |       49 |     22.16 |
-- +--------------+----------+-----------+

-- 23 užduotis
-- Užduotis: Išveskite 10 pirmųjų įrašų kartu su jų autoriaus vartotojo vardu. Parodykite
-- įrašo ID, autoriaus vartotojo vardą ir vietovę.
-- Rezultato pavyzdys (pirmos 5 iš 10 eil.):
select 
p.id,
u.username,
p.location
from posts as p
left join users as u
on p.user_id=u.id
limit 10;

-- +----+--------------------+----------+
-- | id | username           | location |
-- +----+--------------------+----------+
-- |  1 | mpetrauskaite58    | NULL     |
-- |  2 | lpaulauskaite32    | Palanga  |
-- |  3 | aurbonas11         | Trakai   |
-- |  4 | arnas_paulauskas29 | NULL     |
-- |  5 | jstankeviciute48   | Kaunas   |
-- +----+--------------------+----------+


-- 24 užduotis
-- Užduotis: Parodykite 10 pirmųjų komentarų, paliktų po įrašais: komentaro tekstą,
-- komentatoriaus vartotojo vardą ir įrašo aprašymą.
-- Rezultato pavyzdys (pirmos 5 iš 10 eil.):
select 
c.id,
u.username as commenter,
c.content,
p.caption as post_caption
from comments as c
left join users as u
on c.user_id=u.id
left join posts as p
on c.post_id=p.id
order by c.id
limit 10;

-- +----+------------------------+-----------------------------+-----------------------+
-- | id | commenter              | content                     | post_caption          |
-- +----+------------------------+-----------------------------+-----------------------+
-- |  1 | giedre_vaitkute65      | Aš irgi ten buvau, nuostabu | Skanus desertas 🍰    |
-- |  2 | emilija_butkute40      | Puiku! 🔥                   | Tiesiog gera diena 😊 |
-- |  3 | spaulauskaite68        | Kaip skaniai atrodo 🤤      | Tiesiog gera diena 😊 |
-- |  4 | antanas_stankevicius34 | Ei, susitinkam savaitgalį?  | Rytinė kava ☕        |
-- |  5 | mbutkus47              | Sony A7 III                 | Rytinė kava ☕        |
-- +----+------------------------+-----------------------------+-----------------------+

-- 25 užduotis
-- Užduotis: Suraskite vartotojus, kurie nėra įkėlę nė vieno reel. Parodykite vartotojo ID ir
-- vartotojo vardą.
-- Rezultato pavyzdys (pirmos 5 iš 11 eil.):
select 
u.id,
u.username
from users as u
left join reels as r
on u.id=r.user_id
where r.user_id is null
order by u.id;


-- +-----+------------------------+
-- | id  | username               |
-- +-----+------------------------+
-- |   9 | ejankauskaite35        |
-- |  48 | rvaitkute66            |
-- |  56 | mpetrauskas85          |
-- |  74 | mindaugas_jankauskas14 |
-- | 104 | jzukauskas7            |
-- +-----+------------------------+

-- 26 užduotis
-- Užduotis: Parodykite kiekvieno vartotojo įrašų skaičių (įskaitant vartotojus, kurie neturi
-- įrašų). Išveskite 10 vartotojų, turinčių mažiausiai įrašų.
-- Rezultato pavyzdys (pirmos 5 iš 10 eil.):
select 
u.id,
u.username,
count(p.user_id) as post_cnt
from users as u
left join posts as p
on u.id=p.user_id
group by u.id, u.username
order by post_cnt, u.id, u.username
limit 10;

-- +-----+------------------------+----------+
-- | id  | username               | post_cnt |
-- +-----+------------------------+----------+
-- |   7 | austeja_petrauskaite13 |        0 |
-- | 162 | lkazlauskaite59        |        0 |
-- |  28 | antanas_stankevicius71 |        1 |
-- |  29 | rbutkute63             |        1 |
-- | 151 | lina_vaitkute46        |        1 |
-- +-----+------------------------+----------+

-- 27 užduotis
-- Užduotis: Suraskite 10 vartotojų, turinčių daugiausiai sekėjų. Parodykite vartotojo ID,
-- vartotojo vardą ir sekėjų skaičių.
-- Rezultato pavyzdys (pirmos 5 iš 10 eil.):
select 
u.id,
u.username,
count(f.follower_id) as followers_cnt
from users as u
left join followers as f
on u.id=f.following_id
group by u.id, u.username
order by followers_cnt desc, u.id, u.username
limit 10;
-- +-----+----------------------+---------------+
-- | id  | username             | followers_cnt |
-- +-----+----------------------+---------------+
-- |  37 | vilma_petrauskaite48 |            38 |
-- |  36 | jonas_stankevicius73 |            37 |
-- | 113 | ieva_stankeviciute17 |            37 |
-- |  31 | ijankauskas28        |            36 |
-- |  71 | aurbonas11           |            36 |
-- +-----+----------------------+---------------+

-- 28 užduotis
-- Užduotis: Suraskite komentarus, kuriuos vartotojai paliko po savo paties įrašais.
-- Parodykite komentaro ID, vartotojo vardą, komentaro tekstą ir įrašo ID.
-- Rezultato pavyzdys (pirmos 5 iš 20 eil.):
select 
c.id,
u.username,
c.content,
c.post_id
from comments as c
left join users as u
on u.id=c.user_id
join posts as p 
on c.post_id=p.id
where c.user_id = p.user_id
order by c.id;
-- +-----+----------------------+------------------------+---------+
-- | id  | username             | content                | post_id |
-- +-----+----------------------+------------------------+---------+
-- | 134 | rstankeviciute47     | Kaip skaniai atrodo 🤤 |      46 |
-- | 366 | azukauskas31         | Labai stilinga         |     114 |
-- | 405 | ekazlauskas43        | Šaunuolis! 💪          |     127 |
-- | 486 | astankevicius81      | Super! 👏              |     151 |
-- | 559 | paulius_petrauskas16 | Nuostabūs kadrai       |     171 |
-- +-----+----------------------+------------------------+---------+


-- 29 užduotis
-- Užduotis: Išveskite 10 atsakymų į komentarus kartu su pirminiu komentaru. Parodykite
-- atsakymo ID ir tekstą bei pirminio komentaro ID ir tekstą.
-- Rezultato pavyzdys (pirmos 5 iš 10 eil.):
select 
c.id as replay_id,
c.content as replay_text,
c.parent_comment_id as parent_id,
	(select content
	from comments
	where id=c.parent_comment_id) as parent_text
from comments as c
where c.parent_comment_id is not null 
limit 10;
-- +----------+----------------------+-----------+----------------------------+
-- | reply_id | reply_text           | parent_id | parent_text                |
-- +----------+----------------------+-----------+----------------------------+
-- |        5 | Sony A7 III          |         4 | Ei, susitinkam savaitgalį? |
-- |       12 | Dėkui labai!         |        11 | Spalvos tiesiog nerealios  |
-- |       21 | Sony A7 III          |        19 | Kur tai nufotografuota?    |
-- |       24 | Taip, rekomenduoju!  |        22 | Laukiu daugiau!            |
-- |       29 | Ačiū už gerą žodį ❤️ |        28 | Klasika 😂                 |
-- +----------+----------------------+-----------+----------------------------+

-- 30 užduotis
-- Užduotis: Išveskite 10 įrašų, kuriuos palaikino vartotojas, kurio ID yra 1. Parodykite
-- įrašo ID, aprašymą ir autoriaus vartotojo vardą.
-- Rezultato pavyzdys (pirmos 5 iš 10 eil.):
select 
p.id,
p.caption,
u.username as author
from post_likes as pl
left join posts as p
on pl.post_id=p.id
left join users as u
on u.id=p.user_id
where pl.user_id=1
limit 10;

-- +----+-------------------------+-----------------------+
-- | id | caption                 | author                |
-- +----+-------------------------+-----------------------+
-- |  8 | Vasaros prisiminimai ☀️ | vytautas_petrauskas59 |
-- | 14 | NULL                    | kpetrauskaite72       |
-- | 23 | Miesto šviesos 🌃       | lina_vaitkute46       |
-- | 26 | Žiema atėjo ❄️           | aiste_zukauskaite89   |
-- | 41 | Namų jaukumas 🕯️        | kzukauskas51          |
-- +----+-------------------------+-----------------------+

-- 31 užduotis
-- Užduotis: Suraskite 10 porų vartotojų, kurie seka vienas kitą (abipusis sekimas).
-- Kiekviena pora turi būti pateikta tik vieną kartą.
-- Rezultato pavyzdys (pirmos 5 iš 10 eil.):
select 
u1.username as user_a,
u2.username as user_b
from followers as f
join users as u1
on u1.id=f.following_id
join users as u2
on u2.id=f.follower_id
where (f.following_id,f.follower_id)
in ( select follower_id, following_id
	from followers)
and u1.id>u2.id
order by user_a , user_b
limit 10;


-- +-----------------+---------------------+
-- | user_a          | user_b              |
-- +-----------------+---------------------+
-- | jvaitkus18      | lina_butkute41      |
-- | jkazlauskaite28 | egle_jankauskaite21 |
-- | aurbonas76      | ipaulauskaite30     |
-- | aurbonas76      | azukauskas25        |
-- | aurbonas76      | andrius_urbonas61   |
-- +-----------------+---------------------+

-- 32 užduotis
-- Užduotis: Raskite 5 vartotojus, kurių reels palaikino daugiausiai skirtingų vartotojų.
-- Parodykite vartotojo vardą ir unikalių žmonių, palaikinusių jo reels, skaičių.
-- Rezultato pavyzdys (viso 5 eil.):
select 
u.id,
u.username,
count(distinct rl.user_id) as unique_likers
from reels as r
join users as u
on r.user_id=u.id
join reel_likes as rl
on r.id = rl.reel_id
group by u.id,u.username
order by unique_likers desc
limit 5;
-- +-----+---------------------+---------------+
-- | id  | username            | unique_likers |
-- +-----+---------------------+---------------+
-- |  72 | ruta_kazlauskaite32 |           158 |
-- |  87 | mbutkus47           |           152 |
-- | 169 | rjankauskas61       |           151 |
-- |  53 | dainius_vaitkus42   |           147 |
-- | 164 | jpetrauskas14       |           144 |
-- +-----+---------------------+---------------+

-- 33 užduotis
-- Užduotis: Išveskite 10 įrašų, kurių patiktukų skaičius yra didesnis už visų įrašų
-- patiktukų vidurkį.
-- Rezultato pavyzdys (pirmos 5 iš 10 eil.):
select 
id,
user_id,
likes_count
from posts 
where likes_count >
	(
	select avg(likes_count)
    from posts 
	)
order by likes_count desc, id 
limit 10;
-- +----+---------+-------------+
-- | id | user_id | likes_count |
-- +----+---------+-------------+
-- |  8 |     114 |          45 |
-- | 16 |      41 |          45 |
-- | 28 |      40 |          45 |
-- | 37 |      64 |          45 |
-- | 55 |      85 |          45 |
-- +----+---------+-------------+

-- 34 užduotis
-- Užduotis: Suraskite įrašus, kurių niekas nėra palaikinęs (jų nėra lentelėje post_likes).
-- Parodykite įrašo ID, autoriaus ID ir aprašymą.
-- Rezultato pavyzdys (pirmos 5 iš 27 eil.):
select 
p.id,
p.user_id,
caption
from posts as p
left join post_likes as pl
on p.id=pl.post_id
where pl.post_id is null;

-- +-----+---------+--------------------------+
-- | id  | user_id | caption                  |
-- +-----+---------+--------------------------+
-- |  19 |     142 | Savaitgalio nuotykiai 🏞️ |
-- |  22 |     120 | Tiesiog gera diena 😊    |
-- |  74 |      63 | Senamiesčio gatvelės 🏛️  |
-- |  77 |     167 | Geriausia kompanija ❤️   |
-- | 128 |     155 | Savaitgalio nuotykiai 🏞️ |
-- +-----+---------+--------------------------+

-- 35 užduotis
-- Užduotis: Išveskite 10 reels, kurių peržiūrų skaičius yra didesnis už to paties autoriaus
-- visų reels peržiūrų vidurkį.
-- Rezultato pavyzdys (pirmos 5 iš 10 eil.):
select 
id,
user_id,
views_count
from reels
where views_count >
	(
	select avg(views_count)
    from reels
	)
order by views_count desc, id 
limit 10;
-- +-----+---------+-------------+
-- | id  | user_id | views_count |
-- +-----+---------+-------------+
-- | 539 |     152 |     1238788 |
-- | 491 |     110 |      154988 |
-- | 305 |      32 |       82718 |
-- | 176 |     170 |       53344 |
-- | 466 |     151 |       17643 |
-- +-----+---------+-------------+

-- 36 užduotis
-- Užduotis: Parodykite 10 vartotojų, turinčių daugiausiai turinio (įrašų ir reels kartu).
-- Išveskite vartotojo vardą, įrašų skaičių ir reels skaičių.
-- Rezultato pavyzdys (pirmos 5 iš 10 eil.):
select 
u.username,
count(distinct p.id) as post_cnt,
count(distinct r.id) as reel_cnt
from users as u
left join posts as p
on u.id=p.user_id
left join reels as r
on u.id=r.user_id
group by u.username
order by (post_cnt + reel_cnt) desc 
limit 10 ;
-- +-----------------+----------+----------+
-- | username        | post_cnt | reel_cnt |
-- +-----------------+----------+----------+
-- | ijankauskas28   |        8 |        7 |
-- | ekazlauskas43   |        9 |        6 |
-- | rstankevicius18 |       10 |        5 |
-- | istankevicius3  |        9 |        5 |
-- | mpaulauskas64   |        8 |        6 |
-- +-----------------+----------+----------+

-- 37 užduotis
-- Užduotis: Raskite 10 vartotojų, kurie seka daugiau žmonių, nei vidutiniškai seka vienas
-- vartotojas. Parodykite vartotojo vardą ir sekamų žmonių skaičių.
-- Rezultato pavyzdys (pirmos 5 iš 10 eil.):
select 
u.username,
count(f.following_id) as following_cnt
from users as u
join followers as f
on u.id=f.follower_id
group by u.username
having following_cnt>(
	select avg(cnt)
    from (
		select count(*) as cnt
		from followers
    group by follower_id ) as vid_nauja
    )
order by following_cnt desc, u.username
limit 10;


-- +------------------------+---------------+
-- | username               | following_cnt |
-- +------------------------+---------------+
-- | giedre_petrauskaite20  |            45 |
-- | jurgita_paulauskaite54 |            45 |
-- | dpaulauskaite98        |            45 |
-- | vytautas_vaitkus60     |            45 |
-- | austeja_butkute98      |            45 |
-- +------------------------+---------------+

-- 38 užduotis
-- Užduotis: Suraskite 10 vartotojų, kurie yra palaikinę bent vieną savo paties įrašą.
-- Parodykite vartotojo ID ir vartotojo vardą.
-- Rezultato pavyzdys (pirmos 5 iš 10 eil.):
select 
distinct u.id,
u.username
from users as u
join  posts as p
on u.id=p.user_id
join post_likes as pl
on pl.post_id=p.id
where pl.user_id=u.id
order by u.id
limit 10;
-- +----+-----------------------+
-- | id | username              |
-- +----+-----------------------+
-- |  2 | jkazlauskaite28       |
-- |  3 | aurbonas76            |
-- |  6 | austeja_balciunaite47 |
-- |  9 | ejankauskaite35       |
-- | 11 | rokas_butkus51        |
-- +----+-----------------------+

-- 39 užduotis
-- Užduotis: Suskaičiuokite, kiek komentarų iš viso buvo paliekta po patvirtintų (is_verified
-- = 1) vartotojų įrašais.
-- Rezultato pavyzdys (viso 1 eil.):
select 
count(distinct c.id) as coment_on_verified
from comments as c
join posts as p
on p.id=c.post_id
join users as u
on p.user_id=u.id
where u.is_verified =1;
-- +----------------------------+
-- | comments_on_verified_posts |
-- +----------------------------+
-- |                        160 |
-- +----------------------------+

-- 40 užduotis
-- Užduotis: Raskite kiekvieno vartotojo naujausią įrašą. Parodykite autoriaus ID, įrašo ID
-- ir sukūrimo datą; išveskite pirmų 10 vartotojų rezultatus.
-- Rezultato pavyzdys (pirmos 5 iš 10 eil.):
select 
u.id as user_id ,
p.id as latest_post_id,
p.created_at
from users as u
left join posts as p
on u.id=p.user_id
where p.created_at =
	(select 
		max(p2.created_at)
    from posts as p2
    where u.id =p2.user_id
	)
order by u.id
limit 10;
-- +---------+----------------+---------------------+
-- | user_id | latest_post_id | created_at          |
-- +---------+----------------+---------------------+
-- |       1 |            863 | 2026-02-26 22:54:06 |
-- |       2 |            205 | 2026-05-10 17:16:21 |
-- |       3 |            748 | 2026-09-10 18:08:27 |
-- |       4 |            370 | 2026-07-29 01:50:18 |
-- |       5 |            147 | 2026-09-16 19:42:08 |
-- +---------+----------------+---------------------+

