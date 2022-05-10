-- 1. Donner la ligne correspondant à la commune de nom 'Dijon'.
select com as "Code commune", dep as "Code département", nom as "Commune" 
from communes 
where nom = 'Dijon';
-- 2. Combien y a-t-il de communes en France ?
select count(*) as "Nombre communes" 
from communes;
-- 3. Combien de communes s’appellent 'Saint-Loup' ?
select count(*) as "Nombre communes Saint-Loup" 
from communes 
where nom = 'Saint-Loup';
-- 4. Combien de communes contiennent la suite de lettres 'Saint' dans
-- leur nom, sans que le nom ne commence par cette même suite de
-- lettres ?
select count(*) as "Nombre communes *Saint* \ Saint*" 
from communes 
where nom like '%Saint%' and not nom like 'Saint%';
-- 5. Quels sont, sans doublons, les noms qui sont des noms de
-- communes, de départements ou de régions, dans l'ordre
-- lexicographique croissant ?
select distinct nom as "Noms communes/départements/régions" 
from (
	select nom 
	from communes 
	union 
	select nom 
	from departements d 
	union 
	select nom 
	from regions r
) 
order by nom asc;
-- 6. Quels sont les noms des communes qui portent le même nom que
-- leur département ?
select c.nom as "Nom de commune = nom de son département" 
from communes c 
join departements d on c.dep = d.dep 
where c.nom = d.nom;
-- 7. Quels sont, sans doublons, les noms des communes qui portent le
-- nom d'un département, sans que ce nom de commune soit celui d'une
-- commune qui porte le nom de son département ?
select distinct c.nom as "Nom de commune = nom autre département" 
from communes c 
join departements d on d.nom = c.nom 
except
select c.nom 
from communes c 
join departements d on c.dep = d.dep 
where c.nom = d.nom
;
-- 8. Dans combien de régions différentes existe-t-il une commune
-- s’appelant 'Sainte-Marie' ?
select count(*) as "Compte"
from (
	select distinct r.nom
	from regions r 
	join departements d on r.reg = d.reg 
	join communes c on c.dep = d.dep 
	where c.nom = 'Sainte-Marie'
);
-- 9. Quel est le taux (nombre flottant entre 0 et 1) de communes dont
-- le nom est constitué d'au moins trois mots séparés par des tirets ?
-- On pourra multiplier par 1.0 pour avoir une division flottante. On
-- pourra utiliser le fait qu'en SQLite le booléen `true` est
-- représenté par 1 et le booléen `false` par 0.
select count(c.nom) * 1.0 / (
	select count(*) 
	from communes
) as "Taux communes au moins 3 mots" 
from communes c 
where c.nom like '%-%-%';
-- 10. Quelles sont les communes (tous les attributs) qui ne sont pas
-- des chefs-lieux (de département ou de région) ?
-- chefs-lieux
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
-- 11. Quels sont les codes et noms des communes dont le chef-lieu
-- départemental et le chef-lieu régional ne sont pas les mêmes ?
select distinct c.com as "Code commune", c.nom as "Nom commune" 
from communes c 
join departements d on c.dep = d.dep 
join regions r on d.cheflieu != r.cheflieu and d.reg = r.reg;
-- 12. Donner la table des communes avec comme colonnes : le nom de la
-- commune, le nom du département de cette commune, le nom du
-- chef-lieu du département, le nom de la région de cette commune, le
-- nom du chef-lieu de la région.
select c.nom as "Nom commune", d.nom as "Nom département", t1.nom as "Chef-lieu département", r.nom as "Nom région", (
	select c.nom 
	from communes c 
	join departements d on c.com = r.cheflieu
) as "Chef-lieu région" 
from communes c 
join departements d on d.dep = c.dep
join (
	select c.nom, c.com
	from communes c 
	join departements d on c.com = d.cheflieu
) t1 on t1.com = d.cheflieu
join regions r on r.reg = d.reg;
-- 13. Donner, sans doublons, le nom des communes qui ne sont pas les
-- seules à avoir ce nom au sein d'une même région, dans l'ordre
-- lexicographique croissant.
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
-- 14. Donner les noms de chef-lieu de département avec le nom de ce
-- département et, pour ceux qui sont également chef-lieu de région,
-- le nom de cette région (et NULL) pour les autres.
select c.nom as "Nom chef-lieu", d.nom as "Nom département", iif(r.cheflieu = c.com, r.nom, null) as "Nom région ?" 
from communes c 
join departements d on d.cheflieu = c.com 
join regions r on r.reg = d.reg;
-- 15. Donnez les noms des communes qui sont utilisés par au moins
-- deux communes, ainsi que le nombre de communes utilisant chacun de
-- ces noms. La table sera triée par ordre décroissant suivant le
-- nombre de communes, puis par ordre croissant des codes des
-- communes.
select c.nom as "Nom commune", count(c.nom) as "Nombre communes portant ce nom" 
from communes c 
group by c.nom 
having count(c.nom) >= 2 
order by count(c.nom) desc, c.com asc;
-- 16. Combien y a-t-il d'habitants en France (en 2016) ?
select sum(pop24 + pop2564 + po<link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet"> p65) as "Nombre habitants" 
from demographie;
-- 17. Quelle est la proportion des moins de 25 ans en France, en
-- pourcentage entier.
select sum(pop24) * 100 / (sum(pop24 + pop2564 + pop65)) as "Proportion moins de 25 ans" 
from demographie;
-- 18. Donner, pour chaque commune, le code de la commune et le nombre
-- d'habitants qu'il y avait dans cette commune l'année précédente, en
-- supposant qu'il n'y a eu ni émigration, ni immigration.
select com as "Code commune", pop24 + pop2564 + pop65 - naissances + deces as "Population précédente" 
from demographie;
-- 19. Quels sont, dans l'ordre lexicographique croissant, les codes
-- des communes avec strictement plus de naissances que la moyenne des
-- naissances par commune ?
select c.com as "Code commune" 
from communes c 
join demographie d on d.com = c.com 
where d.naissances > (
	select avg(naissances) 
	from demographie
) 
order by c.com asc;
-- 20. Quelles sont les communes sans aucun habitant ? La table aura
-- les mêmes colonnes que la table `communes`. On pourra utiliser
-- l'étoile préfixée par le nom ou l'alias de la table.
select c.com as "Code commune", c.dep as "Code département", c.nom as "Nom commune" 
from communes c 
join demographie d on d.com = c.com 
where d.pop24 + d.pop65 + d.pop2564 = 0;
-- 21. Quelles sont les 19 communes les moins peuplées, parmi celles
-- qui comportent au moins un habitant renseigné ? On donnera le nom
-- de la commune, le nom de son département et sa population.
select c.nom as "Nom commune", dep.nom as "Nom département", pop24 + pop65 + pop2564 as "Population" 
from departements dep 
join communes c on c.dep = dep.dep 
join demographie d  on d.com = c.com
where pop24 is not null and pop65 is not null and pop2564 is not null and pop24 + pop65 + pop2564 >= 1 
order by pop24 + pop65 + pop2564 asc 
limit 19;
-- 22. Donnez les communes (tous les attributs) ayant autant
-- d’habitants que de lettres (tirets inclus) dans leur nom, avec ce
-- nombre d'habitants.
select distinct c.com as "Code commune", c.dep as "Code département", c.nom as "Nom commune", d.pop24 + d.pop65 + d.pop2564 as "Population" 
from communes c 
join demographie d on d.com = c.com 
where length(c.nom) = d.pop24 + d.pop65 + d.pop2564;
-- 23. Quels sont les codes et noms des départements dans lesquels
-- toutes les communes ont vu au moins une naissance et un décès (si
-- cette valeur est renseignée). On considère que le département de
-- Mayotte vérifie la propriété et doit donc être présent.
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
-- 24. Donner la table des régions, de leur population, du nombre de
-- naissances et du nombre de décès. On souhaite avoir les mêmes
-- colonnes que la table `regions`, avec trois colonnes en plus : une
-- pour la population, une pour les naissances et une pour les décès.
select r.reg as "Code région", r.cheflieu as "Chef lieu région", r.nom as "Nom région", sum(c1.pop24 + c1.pop65 + c1.pop2564) as "Population", sum(c1.naissances) as "Naissances", sum(c1.deces) as "Deces" 
from regions r 
join departements d on d.reg = r.reg 
join communes c on c.dep = d.dep 
join (
	select * 
	from demographie
) c1 on c1.com = c.com
group by r.nom;
-- 25. Écrire une requête renvoyant le nom de la région contenant le
-- département le plus peuplé ainsi que le nom de ce département.
select r.nom as "Nom région", d.nom as "Nom département" 
from departements d 
join (
	select max(t1.pop), t1.dep, r.reg 
	from regions r 
	join departements d on r.reg = d.reg 
	join (
		select sum(pop24 + pop65 + pop2564) as pop, d.nom, d.dep 
		from demographie d, communes c, departements d 
		where c.com = d.com and c.dep = d.dep 
		group by d.dep
	) t1 on t1.dep = d.dep
) t2 on t2.dep = d.dep 
join regions r on r.reg = t2.reg;
-- 26. Donnez la table des communes ayant plus d’habitants que le
-- chef-lieu de leur département. La table aura pour colonnes : le nom
-- de la commune, sa population, le nom du département, le nom du
-- chef-lieu et la population de son chef-lieu.
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
-- 27. Donnez la table des régions en y ajoutant le pourcentage entier
-- de la population de la région habitant dans le chef-lieu de région.
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
-- 28. Combien y a-t-il de boulangeries en France ?
select sum(boulangeries) as "Nombre boulangeries" 
from equipements;
-- 29. Combien y a-t-il, en moyenne, de pharmacies par commune ?
select avg(pharmacies) as "Moyenne pharmacies" 
from equipements;
-- 30. Dans combien de communes y-a-t-il strictement plus de
-- poissonneries que de crèches ?
select count(com) as "Nombre communes poissonneries > crèches" 
from equipements 
where poissonneries > creches;
-- 31. Donner le nombre de lycées par département. On donnera le nom
-- et le nombre de lycées de chaque département, ordonnés par nombre
-- de lycées décroissant puis par nom de département croissant pour
-- l'ordre lexicographique.
select d.nom as "Nom département", sum(e.lycees) as "Nombre lycées" 
from equipements e 
join communes c on c.com = e.com 
join departements d on c.dep = d.dep 
group by d.dep 
order by "Nombre lycées" desc, d.nom asc;
-- 32. Quel est le nom de la commune avec le plus faible nombre
-- d'habitants (connu) par boulangerie ? On donnera le nom de la
-- commune avec le nombre d'habitants par boulangerie (partie
-- entière).
select t1.nom as "Nom commune", round(min(t1.habitants * 1.0 / t1.boulangeries)) as "Habitants / boulangerie" 
from (
	select c.nom, e.boulangeries, d.pop24 + d.pop65 + d.pop2564 habitants 
	from communes c 
	join demographie d on d.com = c.com 
	join equipements e on e.com = c.com
) t1;
-- 33. Quels sont les départements dans lesquels toutes les communes
-- sont dotées d'au moins une pharmacie ?
select t1.dep as "Code département", t1.reg as "Code région", t1.nom as "Nom département", t1.cheflieu as "Chef-lieu département"
from (
	select min(e.pharmacies) c1, d.nom, d.dep, d.reg, d.cheflieu
	from equipements e 
	join communes c on c.com = e.com 
	join departements d on d.dep = c.dep
	group by d.dep
) t1 
where t1.c1 != 0;
-- 34. Quel est le nom de la région ayant le plus de poissonneries par
-- habitant de plus de 65 ans ?
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
-- 35. Quelles sont les régions dont tous les départements ont au
--  moins un cinquième de leurs communes qui ont au moins une crèche
--  pour 30 naissances ?
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
-- 36. Donner la table des régions avec en plus, pour chaque région,
-- le nom du département contenant le plus de boulangeries, et la
-- proportion (en pourcentage entier) de boulangeries de la région qui
-- sont dans ce département.
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
