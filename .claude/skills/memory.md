---
name: memory
description: Gère la mémoire du projet — met à jour CLAUDE.md, CONSIDERATIONS.md, et compresse SESSION_STATE.md. S'active automatiquement en fin de session, quand SESSION_STATE.md dépasse 150 lignes, ou quand l'utilisateur change de contexte. Transforme chaque erreur en règle. Transforme chaque leçon en mémoire permanente.
---

<objective>
Faire en sorte que la prochaine session commence plus intelligente que celle-ci.
Zéro perte d'information utile. Zéro surcharge de contexte inutile.
</objective>

<workflow>

## Mode FIN DE SESSION — mise à jour complète

### 1. Analyser la session
- Quelles décisions ont été prises ?
- Quelles erreurs ont été rencontrées ?
- Quels patterns ont bien fonctionné ?
- Quelles conventions ont émergé ?

### 2. Mettre à jour CONSIDERATIONS.md
Format de chaque entrée :
```
## [Date] — [Sujet]
**Contexte :** [pourquoi cette situation s'est posée]
**Ce qu'on a appris :** [la leçon concrète]
**Règle pour la prochaine fois :** [l'instruction actionnable]
```

### 3. Mettre à jour CLAUDE.md
- Ajouter dans "Leçons apprises" les nouvelles règles comportementales
- Mettre à jour la section projet si la stack a changé
- Maximum 400 lignes — compresser si dépassé

### 4. Compresser SESSION_STATE.md
- Supprimer les logs verbeux des étapes terminées
- Garder : décisions clés, état courant, fichiers modifiés, prochaine étape
- Objectif : -40% minimum

## Mode COMPRESSION — SESSION_STATE.md > 150 lignes

1. Identifier ce qui est redondant ou terminé
2. Résumer les étapes passées en une ligne chacune
3. Conserver intégralement : erreurs non résolues, décisions en attente, prochaine étape
4. Réécrire SESSION_STATE.md compressé

</workflow>

<constraints>
- NEVER supprimer une décision non encore implémentée
- NEVER supprimer les erreurs non résolues
- NEVER modifier CLAUDE.md dans la section "Identité" — elle définit ce qu'est STRATEX, jamais touchée
- La section "Routing" peut être modifiée uniquement si une remontée critique le justifie — toujours avec une note explicite sur ce qui a changé et pourquoi
- Chaque erreur rencontrée = une règle ajoutée = une régression évitée à l'avenir
</constraints>

<o>
```
## memory — Rapport

### Mode : [Fin de session / Compression]

### CONSIDERATIONS.md
[N] nouvelles entrées ajoutées

### CLAUDE.md
[N] règles ajoutées dans "Leçons apprises"

### SESSION_STATE.md
Avant : [N] lignes → Après : [N] lignes ([X]% de compression)

### Prochaine session
[Ce que STRATEX sait maintenant qu'il ne savait pas avant]
```
</o>

---

## Mode remontée critique — leçons qui contredisent la stratégie

Quand une leçon de session contredit une décision existante dans CLAUDE.md :

### Détection

Comparer chaque leçon avec les décisions documentées dans :
- CLAUDE.md — règles de routing et comportements
- CONSIDERATIONS.md — décisions passées
- `.stratex/brief.md` — décisions de la session en cours

Si une leçon dit le contraire d'une règle existante → remontée critique activée.

### Format de la remontée critique

```
🔴 Remontée critique — décision à réévaluer

Décision existante : [ce qui était écrit dans CLAUDE.md ou CONSIDERATIONS.md]
Leçon contradictoire : [ce que la session vient de prouver]
Recommandation : [modifier la règle / abandonner la décision / adapter]

Action : CLAUDE.md mis à jour avec la nouvelle règle
Ancienne règle archivée dans CONSIDERATIONS.md avec la date et la raison
```

### Règle absolue

Une leçon qui contredit une règle existante **remplace** cette règle.
L'usage réel a toujours raison sur la théorie.
CLAUDE.md doit refléter ce qui fonctionne — pas ce qu'on pensait qui allait fonctionner.

---

## Alimentation automatique de CONVENTIONS.md

En fin de session, identifier les décisions de style et de structure prises pendant le travail et les ajouter à CONVENTIONS.md.

### Ce qui mérite d'être une convention

- Nommage de fichiers ou de fonctions décidé pendant la session
- Structure de dossiers choisie
- Pattern de gestion d'erreurs utilisé
- Façon d'organiser les composants
- Toute décision répétée plus d'une fois dans la session

### Ce qui ne doit pas être une convention

- Décisions ponctuelles liées à un cas particulier
- Expérimentations non validées
- Corrections de bugs — ce sont des leçons pour CONSIDERATIONS.md, pas des conventions

### Format d'entrée dans CONVENTIONS.md

```
## [Catégorie — Nommage / Structure / Patterns / Tests]
- [La convention en une phrase courte et actionnable]
  Ajouté le [date] — [contexte en une phrase]
```
