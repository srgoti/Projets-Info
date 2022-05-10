
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# NOM :
# Prénom :
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

"""DM n°16."""

import math
import numpy as np
import matplotlib.pyplot as plt

question_00 = """
-- Mettre entre triple guillements vos requêtes SQL.
-- On peut très bien aller à la ligne dans un guillement triple en Python.
SELECT ...
FROM ...
WHERE ...
"""

question_01 = """
select com as "Code commune", dep as "Code département", nom as "Commune" 
from communes 
where nom = 'Dijon';
"""
question_02 = """
select count(*) as "Nombre communes" 
from communes; 
"""
question_03 = """
select count(*) as "Nombre communes Saint-Loup" 
from communes 
where nom = 'Saint-Loup'; 
"""
question_04 = """
select count(*) as "Nombre communes *Saint* \ Saint*" 
from communes 
where nom like '%Saint%' and not nom like 'Saint%';
 """
question_05 = """
select distinct nom as "Noms communes/départements/régions" 
from (
	select nom 
	from communes 
	union select nom from departements d 
	union select nom from regions r 
	order by nom asc
) 
order by nom asc;
 """
question_06 = """
select c.nom as "Nom de commune = nom de son département" 
from communes c 
join departements d on c.dep = d.dep 
where c.nom = d.nom;
 """
question_07 = """
select distinct c.nom as "Nom de commune = nom autre département" 
from communes c 
join departements d on d.nom = c.nom 
except
select c.nom 
from communes c 
join departements d on c.dep = d.dep 
where c.nom = d.nom
;
 """
question_08 = """
select count(*) as "Compte"
from (
	select distinct r.nom
	from regions r 
	join departements d on r.reg = d.reg 
	join communes c on c.dep = d.dep 
	where c.nom = 'Sainte-Marie'
);
 """
question_09 = """
select count(c.nom) * 1.0 / (select count(*) from communes) as "Taux communes au moins 3 mots" 
from communes c 
where c.nom like '%-%-%';
 """
question_10 = """
select c.com as "Code commune", c.dep as "Code département", c.nom as "Nom commune"
from communes c 
except 
select distinct t1.cheflieu, c.dep, c.nom
from (
	select cheflieu 
	from departements 
	union 
	select cheflieu 
	from regions
) t1 
join communes c on c.com = t1.cheflieu;
 """
question_11 = """
select distinct c.com as "Code commune", c.nom as "Nom commune" 
from communes c 
join departements d on c.dep = d.dep 
join regions r on d.cheflieu != r.cheflieu and d.reg = r.reg;
 """
question_12 = """
select c.nom as "Nom commune", d.nom as "Nom département", t1.nom as "Chef-lieu département", r.nom as "Nom région", (
	select c.nom from communes c join departements d on c.com = r.cheflieu
) as "Chef-lieu région" 
from communes c 
join departements d on d.dep = c.dep
join (
	select c.nom, c.com
	from communes c join departements d on c.com = d.cheflieu
) t1 on t1.com = d.cheflieu
join regions r on r.reg = d.reg;
 """
question_13 = """
select distinct nom as "Nom commune" 
from (
	select distinct c.nom, d.reg 
	from communes c 
	join departements d on c.dep = d.dep 
	group by c.nom, d.reg 
	having count(*) > 1 
	order by c.nom, d.reg asc
)
order by nom asc;
 """
question_14 = """
select c.nom as "Nom chef-lieu", d.nom as "Nom département", iif(r.cheflieu = c.com, r.nom, null) as "Nom région ?" 
from communes c 
join departements d on d.cheflieu = c.com 
join regions r on r.reg = d.reg;
 """
question_15 = """
select c.nom as "Nom commune", count(c.nom) as "Nombre communes portant ce nom" 
from communes c 
group by c.nom 
having count(c.nom) >= 2 
order by count(c.nom) desc, c.com asc;
 """
question_16 = """
select sum(pop24 + pop2564 + pop65) as "Nombre habitants" 
from demographie;
 """
question_17 = """
select sum(pop24) * 100 / (sum(pop24 + pop2564 + pop65)) as "Proportion moins de 25 ans" 
from demographie;
 """
question_18 = """
select com as "Code commune", pop24 + pop2564 + pop65 - naissances + deces as "Population précédente" 
from demographie;
 """
question_19 = """
select c.com as "Code commune" 
from communes c 
join demographie d on d.com = c.com 
where d.naissances > (
	select avg(naissances) 
	from demographie
) 
order by c.com asc;
 """
question_20 = """
select c.com as "Code commune", c.dep as "Code département", c.nom as "Nom commune" 
from communes c 
join demographie d on d.com = c.com 
where d.pop24 + d.pop65 + d.pop2564 = 0;
 """
question_21 = """
select c.nom as "Nom commune", dep.nom as "Nom département", pop24 + pop65 + pop2564 as "Population" 
from departements dep 
join communes c on c.dep = dep.dep 
join demographie d  on d.com = c.com
where pop24 is not null and pop65 is not null and pop2564 is not null and pop24 + pop65 + pop2564 >= 1 
order by pop24 + pop65 + pop2564 asc 
limit 19;
 """
question_22 = """
select distinct c.com as "Code commune", c.dep as "Code département", c.nom as "Nom commune", d.pop24 + d.pop65 + d.pop2564 as "Population" 
from communes c 
join demographie d on d.com = c.com 
where length(c.nom) = d.pop24 + d.pop65 + d.pop2564;
 """
question_23 = """
select t1.dep as "Code département", t1.nom as "Nom département"
from communes c 
join (
    select avg(iif(d.naissances = 0, 0, 1)) as nais, avg(iif(d.deces = 0, 0, 1)) as dece, c.com, dep.nom, dep.dep 
    from demographie d 
    join communes c on d.com = c.com 
    join departements dep on dep.dep = c.dep 
    group by dep.dep
) t1 on t1.com = c.com 
where t1.nais = 1.0 and t1.dece = 1.0;
 """
question_24 = """
select r.reg as "Code région", r.cheflieu as "Chef lieu région", r.nom as "Nom région", sum(c1.pop24 + c1.pop65 + c1.pop2564) as "Population", sum(c1.naissances) as "Naissances", sum(c1.deces) as "Deces" 
from regions r 
join departements d on d.reg = r.reg 
join communes c on c.dep = d.dep 
join (select * from demographie) c1 on c1.com = c.com
group by r.nom;
 """
question_25 = """
select r.nom as "Nom région", d.nom as "Nom département" 
from departements d join (
	select max(t1.pop), t1.dep, r.reg 
	from regions r join departements d on r.reg = d.reg join (
		select sum(pop24 + pop65 + pop2564) as pop, d.nom, d.dep 
		from demographie d, communes c, departements d 
		where c.com = d.com and c.dep = d.dep 
		group by d.dep
	) t1 on t1.dep = d.dep
) t2 on t2.dep = d.dep 
join regions r on r.reg = t2.reg;
 """
question_26 = """
select c.nom as "Nom commune", d.pop24 + d.pop65 + d.pop2564 "Population", dep.nom as "Nom département", t3.nom as "Chef-lieu département", t2.c1 as "Popluation chef-lieu" 
from demographie d 
join communes c on c.com = d.com 
join departements dep on dep.dep = c.dep 
join (
	select d.pop24 + d.pop65 + d.pop2564 c1, dep.dep 
	from demographie d 
	join communes c on c.com = d.com 
	join departements dep on dep.cheflieu = c.com 
	where c1 is not null
) t2 on t2.dep = dep.dep 
join (
	select c.nom, d.dep 
	from communes c 
	join departements d on c.com = d.cheflieu
) t3 on t3.dep = dep.dep
where "Population" > t2.c1;
 """
question_27 = """
select t1.reg as "Code région", t1.cheflieu as "Chef-lieu région", t1.nom as "Nom région", t1.c1 * 100 / t2.c1 as "Pourcentage" 
from (
	select r.*, pop24 + pop65 + pop2564 c1 
	from demographie d 
	join communes c on c.com = d.com 
	join departements dep on dep.dep = c.dep 
	join regions r on r.reg = dep.reg
	where c.com = r.cheflieu
) t1, (
	select (sum(d.pop24 + d.pop65 + d.pop2564)) c1, r.reg 
	from demographie d 
	join communes c on c.com = d.com 
	join departements dep on dep.dep = c.dep 
	join regions r on r.reg = dep.reg 
	group by r.reg 
	order by r.reg, dep.dep asc
) t2 
where t1.reg = t2.reg;
 """
question_28 = """
select sum(boulangeries) as "Nombre boulangeries" 
from equipements;
 """
question_29 = """
select avg(pharmacies) as "Moyenne pharmacies" 
from equipements;
 """
question_30 = """
select count(com) as "Nombre communes poissonneries > crèches" 
from equipements 
where poissonneries > creches;
 """
question_31 = """ 
select d.nom as "Nom département", sum(e.lycees) as "Nombre lycées" 
from equipements e 
join communes c on c.com = e.com 
join departements d on c.dep = d.dep 
group by d.dep 
order by "Nombre lycées" desc, d.nom asc;
"""
question_32 = """
select t1.nom as "Nom commune", round(min(t1.habitants * 1.0 / t1.boulangeries)) as "Habitants / boulangerie" 
from (
	select c.nom, e.boulangeries, d.pop24 + d.pop65 + d.pop2564 habitants 
	from communes c join demographie d on d.com = c.com join equipements e on e.com = c.com
) t1;
 """
question_33 = """
select t1.dep as "Code département", t1.reg as "Code région", t1.nom as "Nom département", t1.cheflieu as "Chef-lieu département"
from (
	select min(e.pharmacies) c1, d.nom, d.dep, d.reg, d.cheflieu
	from equipements e 
	join communes c on c.com = e.com 
	join departements d on d.dep = c.dep
	group by d.dep
) t1 
where t1.c1 != 0;
 """
question_34 = """
select nom as "Nom région" 
from (
	select max(t1.poi * 100.0 / t2.p65), t1.nom 
	from (
		select sum(e.poissonneries) poi, r.nom 
		from equipements e 
		join communes c on c.com = e.com
		join departements d on d.dep = c.dep
		join regions r on r.reg = d.reg
		group by r.reg
	) t1, (
		select sum(d.pop65) p65, r.nom 
		from demographie d 
		join communes c on d.com = c.com 
		join departements dep on dep.dep = c.dep 
		join regions r  on dep.reg = r.reg
		group by r.reg
	) t2 
	where t1.nom = t2.nom
);
 """
question_35 = """
select t2.reg as "Code région", t2.cheflieu as "Chef-lieu région", t2.nom as "Nom région"
from (
	select avg(iif (5 * t1.com_w_cre >= t1.com, 1, 0)) as col1, t1.dep, t1.reg, r.nom, r.cheflieu
	from (
		select count(iif (30 * e.creches >= dm.naissances, 1, null)) as com_w_cre, count(c.com) as com, d.dep, r.reg, r.nom, r.cheflieu 
		from equipements e 
		join communes c on c.com = e.com 
		join departements d on d.dep = c.dep 
		join demographie dm on dm.com = c.com
		join regions r on r.reg = d.reg
		group by d.dep
	) t1 
	join regions r on t1.reg = r.reg 
	group by t1.reg
) t2 
where t2.col1 = 1.0;
 """

question_36 = """
select r.reg as "Code région", r.cheflieu as "Chef-lieu région", r.nom as "Nom région", t1.dnom as "Nom département avec le plus de boulangeries", t1.m * 100 / t2.s as "Proportion de boulangeries dans ce département" 
from regions r 
join (
	select max(c1) as m, dnom, rnom, rreg 
	from (
		select sum(e.boulangeries) as c1, d.nom as dnom, r.nom as rnom, r.reg as rreg 
		from equipements e 
		join communes c on e.com = c.com 
		join departements d on d.dep = c.dep 
		join regions r on d.reg = r.reg 
		group by d.dep
	) 
	group by rreg
) as t1 on r.reg = t1.rreg 
join (
	select sum(boulangeries) as s, r.nom as rnom, r.reg as rreg 
	from equipements e 
	join communes c on e.com = c.com 
	join departements d on c.dep = d.dep 
	join regions r on d.reg = r.reg 
	group by r.reg
) as t2 on r.reg = t2.rreg;
"""
