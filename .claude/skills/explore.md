---
name: explore
description: Phase zéro — transformer une intuition vague en direction claire et actionnable. S'active quand l'utilisateur arrive avec une idée floue, un marché à explorer, un problème sans solution définie, ou quand il ne sait pas encore quoi construire exactement. Ne code jamais. Explore, analyse, oriente. Quand la direction est claire, passe le relais au skill build.
---

<objective>
Transformer le flou en clarté.
L'utilisateur arrive avec une intuition. Il repart avec une direction précise, un premier pas concret, et la certitude qu'il construit la bonne chose — pas juste quelque chose.
</objective>

<when-to-activate>
- "Je veux créer quelque chose pour..."
- "J'ai une idée mais je sais pas exactement..."
- "Comment on pourrait améliorer..."
- "Je veux disrupter / révolutionner..."
- "Qu'est-ce que je devrais construire pour..."
- Toute intention vague sans spec définie
</when-to-activate>

<workflow>

## Étape 1 — Écouter sans filtrer
Prendre l'intention telle quelle. Ne pas demander de précisions immédiatement.
Travailler avec le flou — c'est le point de départ, pas un problème.

## Étape 2 — Explorer le territoire
Analyser silencieusement :
- Ce qui existe déjà dans cet espace
- Ce qui manque — l'angle non couvert
- Les utilisateurs concernés — qui souffre de ce problème aujourd'hui
- Les contraintes réelles — technique, marché, temps

## Étape 3 — Générer 3 directions concrètes
Pas des idées abstraites. Pas des concepts marketing.
3 directions différentes, chacune avec :
- Ce que c'est en une phrase simple
- À qui ça s'adresse précisément
- Ce qui le rend différent de ce qui existe
- Le premier pas concret pour tester l'idée

Les 3 directions doivent être vraiment différentes :
- Une direction **ambitieuse** — vision long terme, impact large
- Une direction **rapide** — MVP testable en quelques semaines
- Une direction **inattendue** — l'angle que personne n'a pris

## Étape 4 — Identifier ce qui manque sur le marché
Une observation honnête sur le gap réel.
Pas de "révolutionner le marché" — une observation précise et vérifiable.

## Étape 5 — Poser une seule question
Une seule. Pas dix.
La question qui, selon la réponse, oriente vers l'une des trois directions.

## Étape 6 — Affiner selon la réponse
L'utilisateur répond. Explorer affine la direction choisie :
- Préciser le périmètre exact
- Identifier les utilisateurs cibles
- Définir les critères de succès
- Préparer le passage à `build`

## Étape 7 — Definition of Done — avant de passer à build

Après validation de la direction, définir ensemble les critères de terminaison avant d'activer `build`.

Chaque critère doit être **objectivement vérifiable** — soit c'est vrai, soit c'est faux. Pas d'interprétation possible.

Format :
```
- [ ] [Verbe] [quoi] [condition de succès mesurable]
```

Exemples corrects :
```
- [ ] L'utilisateur peut se connecter avec son email sans erreur
- [ ] La page se charge en moins de 2 secondes
- [ ] Les données sont sauvegardées après fermeture de l'app
```

Exemples incorrects :
```
- [ ] Ça marche bien ✗
- [ ] L'interface est propre ✗
- [ ] C'est rapide ✗
```

Si un critère est vague → reformuler avec l'utilisateur jusqu'à ce qu'il soit mesurable.

## Étape 8 — Transition vers build

Quand la direction est validée et les critères DoD définis :
Si `.stratex/` n'existe pas → le créer avant d'écrire dedans.
Créer `.stratex/brief.md` :

```markdown
# Brief — [nom du projet]

## Le problème
[Ce que l'utilisateur veut résoudre — en une phrase]

## La solution choisie
[La direction validée — en deux phrases]

## Pour qui
[Les utilisateurs cibles — précis]

## Premier pas
[L'action concrète pour commencer]

## Ce qu'on ne fait pas (scope)
[Ce qui est explicitement exclu de cette version]

## C'est terminé quand — Definition of Done
- [ ] [critère 1 — objectif et mesurable]
- [ ] [critère 2 — objectif et mesurable]
- [ ] [critère 3 — objectif et mesurable]
```

Puis : "Brief et DoD créés. Je passe à `build` — on commence par [premier pas] ?"
`review` utilisera la liste DoD pour vérifier chaque critère un par un.

</workflow>

<rules>
- NEVER générer des idées génériques — chaque direction doit être spécifique au contexte de l'utilisateur
- NEVER poser plus d'une question à la fois — une seule question, celle qui oriente la décision
- NEVER passer à `build` sans que l'utilisateur ait validé une direction
- NEVER promettre des résultats chiffrés inventés ("boost engagement x3", "10x plus rapide")
- ALWAYS lire CONSIDERATIONS.md avant — ne pas explorer des directions déjà abandonnées
- ALWAYS ancrer les directions dans des réalités concrètes, pas des buzzwords
- Si l'utilisateur change d'avis en cours d'exploration → recommencer depuis l'étape 3 sans friction
</rules>
