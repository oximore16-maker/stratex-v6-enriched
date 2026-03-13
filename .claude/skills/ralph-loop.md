---
name: ralph-loop
description: Boucle autonome qui travaille seule jusqu'à atteindre un objectif précis. S'active quand l'objectif est clair, vérifiable, et nécessite plusieurs itérations successives — faire passer tous les tests, corriger toutes les erreurs TypeScript, atteindre un seuil de performance. Tu définis le critère, ralph-loop tourne seul jusqu'au bout. Maximum 5 tentatives avant d'escalader.
---

<objective>
L'utilisateur définit un objectif clair.
Ralph-loop l'atteint seul — sans validation intermédiaire.
Il s'arrête quand c'est réussi ou quand il a besoin d'aide humaine.
</objective>

<when-to-activate>
- "Fais passer tous les tests"
- "Corrige toutes les erreurs TypeScript"
- "Optimise jusqu'à ce que X soit atteint"
- "Fais tourner ça sans erreur"
- Tout objectif binaire — soit c'est atteint, soit ce n'est pas atteint
</when-to-activate>

<workflow>

## Avant de démarrer

1. Reformuler l'objectif en critère vérifiable :
   - "Tous les tests passent" → `npm test` retourne 0 erreur
   - "Zéro erreur TypeScript" → `npx tsc --noEmit` retourne 0 erreur
   - "Page charge en moins de 2s" → mesure concrète

2. Annoncer le plan :
```
🔄 Ralph-loop activé
Objectif : [critère vérifiable]
Maximum : 5 tentatives
Je démarre — je reviens quand c'est terminé ou si j'ai besoin de toi.
```

3. Attendre confirmation de l'utilisateur — puis tourner seul.

## La boucle

```
Tentative N :
  1. Vérifier l'état actuel — lancer la commande de vérification
  2. Si objectif atteint → SUCCÈS, sortir de la boucle
  3. Si échec → analyser ce qui bloque
  4. Activer stratex-build ou fix selon la nature du problème
  5. Corriger
  6. Retourner à l'étape 1
```

## Règles de la boucle

- Maximum 5 tentatives — pas plus
- Après chaque tentative → noter dans SESSION_STATE.md ce qui a été essayé
- Ne jamais essayer deux fois la même correction — si ça n'a pas marché, changer d'approche
- Si une correction empire les choses → la rollback avant de continuer

## Conditions d'arrêt

**Succès** — objectif atteint, rapport final affiché

**Échec après 5 tentatives** — escalade vers l'utilisateur avec :
- Ce qui a été essayé (5 approches détaillées)
- Ce qui bloque encore
- Recommandation pour la suite

**Blocage humain nécessaire** — si une décision dépasse le code (choix d'architecture, accès externe, credential manquant) → stopper immédiatement et demander

</workflow>

<o>
```
## ralph-loop — Rapport final

### Objectif
[Critère vérifiable défini au départ]

### Résultat
[✅ SUCCÈS / 🚫 ÉCHEC après 5 tentatives]

### Tentatives
1. [Ce qui a été essayé] → [résultat]
2. [Ce qui a été essayé] → [résultat]
...

### État final
[Commande de vérification + résultat actuel]

### Si ÉCHEC — prochaine étape recommandée
[Ce qui nécessite une intervention humaine]
```
</o>
