Le projet suivant est une recréation (pas toujours très fidèle) de Megaman 1 à l'aide du moteur de jeu Godot.<br/>
Tous les sprites, musiques et bruitages ont été récupérés sur Internet.<br/>
Vous pourrez retrouver les sites et vidéos que j'ai utilisés et regardés plus bas.<br/>
Le code est entièrement de moi (à l'exception d'une ligne)<br/>

Disclaimer : J'ai utilisé ChatGPT. Cet outil a eu deux utilisations différentes.<br/>
1) La résolution de bug. Lorsque je ne parvenais pas à résoudre les bugs en moins de 15 ou 30 minutes, j'ai utilisé ChatGPT pour m'aider à les résoudre. D'abord en lui fournissant les résultats des prints puis, si ça ne me permettait pas de résoudre les bugs, une partie du code.
2) Pour apprendre. Même après avoir regardé plusieurs vidéos youtube ou pages du forum Godot, je ne parvenais pas à comprendre une fonctionnalité de Godot ; je me permettais alors de demander à ChatGPT une explication.
Pour finir, comme écrit plus haut, il y a une ligne qui n'est pas de moi mais de ChatGPT. Elle se trouve dans Level_Select_Boss.gd.<br/>
La voici : var y = lerp(depart.y, arrivee.y, progression) - 4.0 * hauteur_en_plus * progression * (1.0 - progression)<br/>
N'arrivant pas a trouver la bonne formule mathématique, je l'ai demandé a ChatGPT. Il y a cependant une explication complète dans le fichier. Cette explication est de moi.<br/>

Sprites:<br/>
-https://www.spriters-resource.com/nes/mm/ <br/>
-Retrouver le site

Musiques et Bruitages :<br/>
-Retrouver le site

Maintenant voici une présentation des différentes versions.<br/>
(Pour la 0.05 et la 0.06, les listes ne sont pas exhaustives. J'ai oublié de les noter au fur.)<br/>

Version 0.05 :<br/>
- Niveau de BombMan entièrement recréé.
- Personnage de Megaman ajouté.
- Animations de Megaman Man ajoutées. (Il en manque comme celle lorsqu'il se prend un coup).
- Système de points de vie et d'énergie ajouté.
- Système de mort partiellement ajouté.
- Menu ajouté.
- Toutes les armes de Megaman ont été ajoutées à l'exception de l'Hyper Bomb et du Magnet Beam 
- L'ennemi Sniper Joe a été ajouté.
- Les échelles ont été ajoutées.
- Les pics ont été ajoutés.
- Les Death Zones ont été ajoutées.
- Le système de caméra a été ajouté.
- Les portes ont été ajoutées. (Elles ne bloquent pas encore Megaman)

Version 0.06 :<br/>
-Menu de sélection des niveaux ajoutés. (Peu importe le choix, le jeu vous mettra dans le niveau de Bombman)
-Système de sauvegarde ajouté (mais pas finalisé).
