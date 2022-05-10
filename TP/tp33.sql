-- 1. Quels sont les deux derniers chiffres des années de naissance
-- des peintres ?
select annee_naissance % 100 from peintres;
-- 2. Quels sont les prénoms, noms et les durées de vie des peintres
-- qui sont morts avant leur 40ième anniversaire ?
select prenom, nom, annee_mort - annee_naissance from peintres where annee_mort - annee_naissance < 40;
-- 3. ???
SELECT o.nom || ' est exposé au ' || UPPER(m.nom)
FROM oeuvres o JOIN musees m ON o.id_musee = m.id
WHERE LENGTH(o.nom) < 20 AND m.nom LIKE 'Musée%';

-- 4. Quel est le nom complet (prénom et nom en une seule chaîne) des
-- peintres dont le prénom contient un 'a', le nom ne commence pas par
-- 'Ve' et dont l'avant dernière lettre est un 'i'. La colonne de la
-- table doit s'intituler 'nom_complet'.
select prenom || ' ' || nom as nom_complet from peintres where prenom like '%a%' and not nom like 'Ve%' and nom like '%i_';
-- 5. Quelle est l'année de naissance d'un peintre la plus ancienne ?
select * from peintres where annee_naissance = (select min(annee_naissance) from peintres);
-- 6. Quelle est l'année de naissance moyenne des peintres français ?
select avg(annee_naissance) from (select p.*, pa.nom from peintres p join pays pa on p.id_pays = pa.id where pa.nom = 'France');
-- 7. Combien d'oeuvres sont exposées au Musée du Louvre ?
select count(*) from (select o.*, m.nom from oeuvres o join musees m on m.id = o.id_musee where m.nom = 'Musée du Louvre');
-- 8. Quel est le nombre de lettres total des noms des musées qui ne sont pas en France ?

-- 9. ???
SELECT *
FROM villes
WHERE id =
  (SELECT COUNT(*)
   FROM peintres p JOIN pays c ON p.id_pays = c.id
   WHERE c.nom = 'Pays-Bas');

-- 10. Combien de peintres sont nés après l'année moyenne de naissance
-- d'un peintre ?

-- 11. Quel est le nom et l'année de naissance des peintres qui sont
-- nés le plus récemment ?

-- 12. Donner toutes les informations sur les peintres triés par année
--  de naissance croissante ?

-- 13. Donner les noms des musées triés par nombre de lettres décroissant

-- 14. Donner les noms des oeuvres et de leurs peintres triés par date
-- de naissance des peintres dans l'ordre décroissant puis, pour une
-- même date de naissance du peintre, par ordre lexicographique
-- croissant du nom de l'oeuvre

-- 15. Quels sont les cinq derniers peintres morts ?

-- 16. Quels sont, suivant l'ordre lexicographique croissant de leur
-- nom, les troisième, quatrième et cinquième pays ?

-- 17. Quelles sont les oeuvres qui ne sont pas exposées ?

-- Quelles sont les oeuvres qui sont exposées ?
SELECT o.nom, m.nom FROM oeuvres o JOIN musees m ON o.id_musee = m.id;

-- Variante pour : quelles sont les oeuvres qui ne sont pas exposées ?
SELECT * FROM oeuvres
EXCEPT
SELECT o.* FROM oeuvres o JOIN musees m ON o.id_musee = m.id;

-- Donner tous les noms d'oeuvres, exposées ou non, avec le nom
-- de leur musée d'exposition s'il existe et NULL sinon
SELECT o.nom, m.nom FROM oeuvres o JOIN musees m ON o.id_musee = m.id
UNION
SELECT o.nom, NULL FROM oeuvres o WHERE id_musee IS NULL;

-- 18. En utilisant une jointure externe gauche, donner toutes les
-- noms d'oeuvres, exposées ou non, avec le nom de leur musée
-- d'exposition.

-- 19. Quelles sont les oeuvres peintes par un peintre né après 1500, exposées dans
-- un musée dont le nom est formé d'un seul mot ?
-- Avec jointure :

-- 20. Avec produit cartésien :

-- 21. Avec IN :

-- 22. Avec EXISTS

-- 23. Avec COUNT

-- 24. Donner, pour chaque musée, son identifiant et le nombre d'oeuvres
-- qui y sont exposées.
SELECT id_musee, COUNT(id) AS nb_oeuvres
FROM oeuvres
WHERE id_musee IS NOT NULL
GROUP BY id_musee;

-- 25. Donner, pour chaque peintre, son identifiant et son nombre d'oeuvres.

-- 26. Donner, pour chaque peintre ayant au moins une oeuvre, son prénom, son nom
-- et son nombre d'oeuvres.

-- 27. Donner, pour chaque pays, son nom, le nombre de peintres qui en sont
-- originaires et la durée moyenne de vie d'un peintre originaire de ce pays

-- 28. Donner l'identifiant des pays qui comportent au moins deux villes.
SELECT id_pays
FROM villes
GROUP BY id_pays
HAVING COUNT(id) >= 2;

-- 29. Donner le nom des peintres ayant peint au moins 3 toiles, avec ce nombre.

-- Donner le nom des musées qui exposent au moins deux tableaux
-- dont le titre commence par 'L', avec ce nombre de tableaux.
SELECT m.nom, COUNT(o.id) AS nb_oeuvres_commence_par_L
FROM oeuvres o JOIN musees m ON o.id_musee = m.id
WHERE o.nom LIKE 'L%'
GROUP BY o.id_musee
HAVING COUNT(o.id) >= 2;

-- 30. Donner, pour chaque musée dont le nom commence par 'G' et qui
-- expose au moins 2 oeuvres de peintres nés après 1480, son nom et le
-- nombre de peintres nés après 1480 qui y sont exposés.

-- 31. Quel est le nombre maximal d'oeuvres peintes par un même artiste ?

-- 32. Quel est le nombre moyen d'oeuvres dans les musées qui comportent
-- au moins deux oeuvres ?

-- 33. Quel est le nom d'un musée qui expose le moins d'oeuvres ?

-- 34. Quels sont les noms des peintres exposés dans tous les musées parisiens ?
-- On reformule : ce sont les peintres pour lesquels il n'existe pas de musée
-- parisien qui ne les expose pas (c'est-à-dire tel qu'il n'existe pas d'oeuvre
-- de ce peintre dans ce musée)

-- 35. Quels sont les noms des pays dans lesquels tous les musées de ce pays
-- exposent tous les peintres de ce pays ? On reformule : ce sont les pays
-- pour lesquels il n'existe pas de musée de ce pays pour lequel il existe
-- un peintre de ce pays pour lequel il n'existe pas d'oeuvre qui n'est pas exposée
-- dans ce musée.
