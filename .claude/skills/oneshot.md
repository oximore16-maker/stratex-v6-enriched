---
name: oneshot
description: Exécute une tâche précise et bien définie de bout en bout sans validation intermédiaire. S'active quand l'utilisateur dit "fais-le directement", "sans m'interrompre", "livre-moi le résultat final". La tâche doit être claire et délimitée. Oneshot planifie, exécute, valide, et rend compte — en une seule passe.
---

<objective>
Une instruction claire en entrée.
Un résultat complet et validé en sortie.
Zéro interruption entre les deux.
</objective>

<when-to-activate>
- "Fais-le directement"
- "Sans m'interrompre"
- "Livre-moi le résultat"
- "Fais tout en une fois"
- Tâches précises et bien délimitées où l'utilisateur fait confiance à STRATEX
</when-to-activate>

<pre-flight>
Avant de démarrer, vérifier que la tâche est éligible à oneshot :

✅ Éligible :
- Tâche bien définie avec périmètre clair
- Résultat vérifiable objectivement
- Pas de décision d'architecture impliquée
- Pas d'accès externe nécessaire (API tierce, credentials)

🚫 Non éligible — revenir en mode standard :
- Tâche vague ou ambiguë
- Décision technologique importante impliquée
- Impact irréversible sur la production
- Dépendances non résolues

Si non éligible → expliquer pourquoi et proposer explore ou build à la place.
</pre-flight>

<workflow>

## Annonce et validation du plan

```
⚡ Oneshot — plan de la tâche

Tâche : [reformulation en une phrase claire]
Étapes : [liste des étapes — 3 à 7 maximum]
Durée estimée : [X étapes, aucune interruption une fois confirmé]

Je démarre dès ta confirmation — je reviens uniquement avec le résultat complet.
Tu confirmes ?
```

Attendre le "oui" de l'utilisateur — c'est la seule validation.
Une fois confirmé → exécution sans interruption jusqu'au bout.

## Exécution — mode non-interactif

1. Lire tous les fichiers concernés d'abord — jamais agir à l'aveugle
2. `stratex-build` s'exécute en mode non-interactif — la Phase 2 de validation est couverte par la confirmation initiale de `oneshot`, pas de validation intermédiaire supplémentaire
3. Valider après chaque étape — si quelque chose échoue → corriger immédiatement via `fix`, ne pas interrompre l'utilisateur
4. Review finale automatique avant de rendre compte

## Condition d'interruption

Oneshot peut s'interrompre dans un seul cas : si une décision imprévue dépasse le périmètre annoncé.

```
⚡ Oneshot — interruption nécessaire
Situation imprévue : [ce qui s'est passé]
Décision requise : [ce que l'utilisateur doit choisir]
Une fois décidé, oneshot reprend.
```

</workflow>

<o>
```
## oneshot — Terminé

### Tâche
[Ce qui était demandé]

### Ce qui a été fait
[Liste des fichiers créés/modifiés]

### Validation
[Résultats des tests/checks]

### Livraison
[Prêt à merger / commit créé / résultat disponible]
Si review GO → `git` s'active automatiquement — commit inclus dans la livraison.
```
</o>
