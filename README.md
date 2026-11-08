Ce projet consiste en une recréation (pas toujours très fidèle) de Megaman 1. </br>
Comme vous pouvez le voir au numéro de version, il est loin d'être terminé. </br>
Le projet atteindra sa version 0.1 lorsque le niveau de Bombman sera entièrement jouable. Il y aura dedans tous les ennemis que vous pouviez croiser dans la version originale de ce niveau et toutes les fonctionnalités de base du jeu seront implémentées.</br>

Avant de passer aux descriptions des différentes versions, voici quelques informations importantes.</br>

Ceci est non seulement mon premier projet godot mais également mon premier vrai jeu vidéo. Le code est donc celui d'un informaticien en cours de Master mais pas celui d'un informaticien expérimenté (surtout pas dans le domaine vidéoludique). Mon inexpérience est, selon moi, très visible dans la façon dont j'ai créé mes différents nodes. </br>
Ce projet a avant tout été pour moi l'occasion d'apprendre, et qu'est-ce que j'ai appris! Mais il me reste encore beaucoup à apprendre, donc si vous avez des retours à faire, n'hésitez pas! </br>
Bien sûr, cet apprentissage ne s'est pas fait en étant coupé du monde extérieur ; voici donc une liste des vidéos YouTube et sites internet que j'ai utilisés (la liste n'est pas exhaustive ; j'ai oublié de les noter au fur et à mesure). </br>

Vidéos Youtube : </br>
- 2D Platformer Tutorial In Godot 4 (https://www.youtube.com/watch?v=S2NG6fobarM&list=PLCcur7_Y2zTdKIQ2oM2Ec8MEfeBnAbEXT) : C'est avec les vidéos de cette playlist que j'ai appris les bases de Godot. Comment créer des nœuds, comment créer un personnage jouable, comment animer un personnage, comment créer des tilemaps et des tilesets, comment faire des objets que vous pouvez ramasser, comment changer de scène et comment faire un hud. </br>
- Your Godot Nodes Are Too Connected (https://www.youtube.com/watch?v=lWaLUm3V99Q) : C'est de cette vidéo que vient l'EventBus, ce script global où passent presque tous mes signaux et qui me permet de ne pas avoir à référencer directement les nodes entre eux.
- Dungeon Room Transitions - Godot 4 Intermediate Tutorial (https://www.youtube.com/watch?v=LGNyzw_2_24) : Le système de caméra vient en partie de cette vidéo. Pour être plus précis, c'est la partie déplacement case par case de la caméra.

Sites Internet : </br>
- (Retrouver les sites)

ChatGPT :</br>
Pour être tout à fait honnête, j'ai utilisé ChatGPT dans le cadre de ce projet. Attention cependant! Il n'y a qu'une seule ligne de code qui a été générée par ChatGPT. La voici : var y = lerp(depart.y, arrivee.y, progression) - 4.0 * hauteur_en_plus * progression * (1.0 - progression). Ce bout de code se trouve dans Level_Select_Boss.gd et fait partie de la fonction faisant sauter les boss de leur boîte jusqu'au centre de l'écran. La raison de cette génération fut que je n'arrivais pas à trouver la bonne formule mathématique. N'y arrivant pas après plus d'une heure d'expérimentations et de recherches sur Internet, je me suis permis de poser la question à ChatGPT. </br>
Pour le reste, ChatGPT a été utilisé à deux fins : </br>
1) Pour des raisons pédagogiques : Lorsque mes recherches sur Internet n'ont pas suffi à me permettre de comprendre une partie du fonctionnement de Godot, je me suis permis de poser la question à ChatGPT. </br>
2) Lorsqu'une fonction me paraît trop utile, je me demande toujours si elle n'a pas déjà été créée et implémentée dans Godot. Si, après recherche sur Internet, je ne trouvais pas de preuve de l'existence de cette fonction, je demandais à ChatGPT de me confirmer ou non son existence. Cette habitude me vient d'un cours où l'on devait coder en Python et où, à de nombreuses reprises, j'ai codé des fonctions que j'ai dû effacer le lendemain car une fonction de base de Python faisait déjà la même chose, et souvent en mieux.
Aucun sprite, musique, bruitage et autre n'a été généré par IA. Je les ai tous trouvés sur des sites internet.

En voici la liste.</br>

Sprites : </br>
- The Spriters Resource (https://www.spriters-resource.com/nes/mm/)
- (Retrouver l'autre site)

Musique/Bruitages : </br>
- Khinsider (https://downloads.khinsider.com/game-soundtracks/album/megaman-1-original-soundtrack) </br>
- 101Soundboards.com (https://www.101soundboards.com/boards/10834-mega-man-sounds) </br>

Informations : </br>
- Megaman Fandom (https://megaman.fandom.com/wiki/Mega_Man_Knowledge_Base) : Pour savoir combien de vie avait tel ennemi, les dégâts pris selon le type d'arme, les items et leur taux de drop.
- J'ai également joué à Megaman sur un émulateur afin de répondre à certaines de mes questions. Par exemple : Quelle est la vitesse de Megaman?

Voici maintenant la description des différentes versions du jeu : </br>

Version 0.05 : </br>
-

Version 0.06 : </br>
-

Version 0.07 : </br>
- Ajout du fichier SaveFiles.
- A ajouté ' ' et '©' a la police d'écriture.
- A ajouté le Title Screen.

Version 0.07R : </br>
- Grand rangement.
