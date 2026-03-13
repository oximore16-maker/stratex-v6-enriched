---
name: prioritize
description: Priorise plusieurs idées ou features selon trois critères objectifs — valeur utilisateur, effort technique, dépendances. S'active quand l'utilisateur a plusieurs idées et ne sait pas laquelle construire en premier, ou quand plusieurs features sont en attente et qu'il faut décider l'ordre. Retourne un classement clair avec les raisons. Passe le relais à explore ou build selon ce que l'utilisateur choisit.
---

<objective>
Transformer l'hésitation entre plusieurs idées en décision claire et argumentée.
Pas de choix au hasard. Pas de choix selon l'humeur.
Un classement objectif basé sur trois critères réels.
</objective>

<when-to-activate>
- "J'ai plusieurs idées, je sais pas par où commencer"
- "Est-ce que je fais X ou Y en premier ?"
- "J'ai une liste de features, dans quel ordre ?"
- Toute situation avec plusieurs options et pas d'ordre évident
</when-to-activate>

<criteria>

## Les trois critères de priorisation

### 1. Valeur utilisateur (1 à 5)
Est-ce que ça résout un vrai problème pour une vraie personne ?

| Score | Signification |
|---|---|
| 5 | Problème douloureux, les gens paient déjà pour le résoudre |
| 4 | Problème réel, gain de temps ou d'argent mesurable |
| 3 | Problème réel mais workaround facile existe |
| 2 | Nice to have, peu d'impact concret |
| 1 | Intéressant mais personne ne le demande |

### 2. Effort technique (1 à 5 — inversé : 5 = facile)
Combien de temps et de complexité pour construire ?

| Score | Signification |
|---|---|
| 5 | Quelques heures, une session Claude Code |
| 4 | Quelques jours, deux ou trois sessions |
| 3 | Une semaine, plusieurs décisions techniques |
| 2 | Plusieurs semaines, architecture complexe |
| 1 | Mois de travail, dépendances externes multiples |

### 3. Dépendances (1 à 5)
Est-ce que ça bloque ou débloque d'autres choses ?

| Score | Signification |
|---|---|
| 5 | D'autres features en dépendent — à faire en premier |
| 4 | Débloque une partie du projet |
| 3 | Neutre — ni bloquant ni débloquant |
| 2 | Dépend d'autre chose qui n'est pas encore fait |
| 1 | Complètement isolé ET dépend de features non construites |

## Calcul de priorité

Score final = Valeur × 0.5 + Effort × 0.3 + Dépendances × 0.2

La pondération reflète la réalité : la valeur utilisateur pèse plus que la facilité technique.

</criteria>

<workflow>

## Étape 1 — Collecter les idées
Lister toutes les idées ou features mentionnées par l'utilisateur.
Si une idée est vague → la reformuler en une phrase claire avant de scorer.

## Étape 2 — Scorer chaque idée
Pour chaque idée, évaluer les trois critères.
Être honnête — ne pas surévaluer pour faire plaisir.
Si l'information manque pour scorer → le dire clairement.

## Étape 3 — Calculer et classer
Appliquer la formule. Classer du score le plus haut au plus bas.
En cas d'égalité → la valeur utilisateur départage.

## Étape 4 — Expliquer le classement
Pas juste les scores — expliquer pourquoi en langage simple.
Ce que l'utilisateur gagne à faire X avant Y.
Ce qu'il risque si il fait Y avant X.

## Étape 5 — Transition
Après validation du classement par l'utilisateur :
- Si la première idée est floue → activer `explore`
- Si la première idée est claire → activer `build`

</workflow>

<rules>
- NEVER classer selon les préférences supposées de l'utilisateur
- NEVER donner un score sans justification
- ALWAYS signaler quand l'information manque pour scorer correctement
- ALWAYS expliquer le classement en langage simple, pas en chiffres bruts
- Si l'utilisateur conteste un score → réévaluer avec son argument, pas par politesse
</rules>

<o>
```
## prioritize — [nombre] idées analysées

### Classement

**1. [Idée] — Score [X]/5**
Valeur : [X]/5 — [raison en une phrase]
Effort : [X]/5 — [raison en une phrase]
Dépendances : [X]/5 — [raison en une phrase]
**Pourquoi en premier :** [explication simple]

**2. [Idée] — Score [X]/5**
Valeur : [X]/5 — [raison en une phrase]
Effort : [X]/5 — [raison en une phrase]
Dépendances : [X]/5 — [raison en une phrase]
**Pourquoi en deuxième :** [ce qui manque pour être premier]

**3. [Idée] — Score [X]/5**
[même format]
**Pourquoi en dernier :** [ce qui bloque ou ce qui manque]

---

### Recommandation
On commence par **[idée 1]**.
[Une phrase sur ce que ça débloque pour la suite.]

Je lance `explore` ou `build` sur [idée 1] ?
```
</o>
