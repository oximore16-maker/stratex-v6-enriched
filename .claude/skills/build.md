---
name: build
description: Pipeline d'implémentation complet pour une feature ou correction. S'active quand l'utilisateur veut construire quelque chose de concret — nouvelle feature, page, composant, intégration. Crée la spec, décompose en tâches, implémente, valide. Délègue à @stratex-build pour l'exécution.
---

<objective>
Transformer une intention en code fonctionnel, validé, et prêt à merger.
Zéro tâche flottante. Zéro code non testé livré.
</objective>

<workflow>

## Étape 1 — Spec
Si `.stratex/` n'existe pas → le créer avant d'écrire dedans.
Créer `.stratex/spec.md` avec :
- Objectif en une phrase
- Périmètre exact (ce qui est inclus, ce qui est exclu)
- Fichiers cibles
- Critères d'acceptance (ACs) — chaque AC est vérifiable objectivement

## Étape 2 — Tâches
Créer `.stratex/tasks.md` avec :
- Maximum 20 tâches par session
- Chaque tâche = 15 à 30 minutes
- Format : `- [ ] [verbe] [quoi] [où]`
- Exemple : `- [ ] Créer le composant LoginForm dans src/components/auth/`

## Étape 3 — Validation du plan
Présenter spec.md + tasks.md à l'utilisateur.
Attendre confirmation avant d'activer @stratex-build.

## Étape 4 — Exécution
Activer @stratex-build avec la spec et les tâches.
@stratex-build exécute, valide, rend compte.

## Étape 5 — Review
Activer le skill `review` automatiquement.
Si score ≥ 90 → activer skill `git` pour commit.
Si score < 90 → @stratex-build corrige, review à nouveau.

**Safeguard boucle :** si la même dimension score 0 sur deux reviews consécutives → stopper immédiatement. Présenter à l'utilisateur : la dimension bloquante, ce qui a été tenté, et pourquoi ça ne progresse pas. L'utilisateur décide de la suite.

</workflow>

<constraints>
- NEVER commencer l'implémentation sans spec validée
- NEVER déclarer terminé sans avoir activé `review`
- Si la feature est trop large pour 20 tâches → la découper en plusieurs sessions
- Toujours lire CONSIDERATIONS.md avant de créer la spec
- Si `.stratex/brief.md` existe → le lire avant de créer spec.md — spec.md formalise le brief, ne le remplace pas et ne le répète pas indépendamment
</constraints>
