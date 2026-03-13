---
name: prompt-creator
description: Génère le meilleur prompt possible pour une tâche complexe et mal définie avant de l'exécuter. S'active quand la demande est floue mais technique, quand l'utilisateur sait ce qu'il veut mais pas comment le formuler, ou quand une tâche complexe mérite d'être précisément cadrée avant d'être lancée. Complément d'explore — explore travaille sur le quoi, prompt-creator travaille sur le comment.
---

<objective>
Transformer une demande floue en instruction précise et optimisée.
Claude optimise son propre point d'entrée avant d'agir.
Résultat : une exécution plus juste, moins d'allers-retours, meilleur résultat final.
</objective>

<when-to-activate>
- Tâche technique complexe formulée de façon vague
- "Je sais ce que je veux mais je sais pas comment le dire"
- Tâche qui a déjà échoué une fois — reformuler avant de réessayer
- Tâche impliquant plusieurs contraintes à respecter simultanément
</when-to-activate>

<difference-with-explore>
`explore` → tu as une intuition métier, on cherche la direction produit
`prompt-creator` → tu as une direction technique, on optimise l'instruction avant d'exécuter
</difference-with-explore>

<workflow>

## Étape 1 — Analyser la demande
Identifier ce qui est flou, ce qui manque, ce qui est contradictoire.

## Étape 2 — Construire le prompt optimal
Un bon prompt pour Claude Code contient :
- **Contexte** — ce qui existe déjà, les contraintes du projet
- **Objectif précis** — ce qu'on veut atteindre, pas comment y arriver
- **Contraintes** — ce qu'il ne faut pas faire, les limites
- **Critère de succès** — comment on sait que c'est réussi
- **Format de sortie** — ce qu'on attend comme livrable

## Étape 3 — Soumettre à validation

```
✍️ Prompt-creator — voici le prompt optimisé pour ta tâche :

---
[Le prompt généré — complet et précis]
---

Ce prompt est-il correct ? Je l'exécute tel quel ou tu veux ajuster quelque chose ?
```

## Étape 4 — Exécuter après validation
Une fois validé → activer le skill approprié (build, oneshot, ralph-loop) avec ce prompt comme instruction de départ.

</workflow>

<what-makes-a-good-prompt>
**Spécifique** — pas "améliore les performances" mais "réduis le temps de chargement de la page d'accueil sous 2 secondes"

**Contextualisé** — inclure les fichiers concernés, le framework, les contraintes existantes

**Délimité** — ce qui est dans le périmètre, ce qui n'y est pas

**Vérifiable** — on sait objectivement si c'est réussi ou non
</what-makes-a-good-prompt>

<rules>
- NEVER exécuter sans validation du prompt par l'utilisateur
- ALWAYS expliquer pourquoi chaque partie du prompt a été formulée ainsi
- Si l'utilisateur modifie le prompt → accepter sans résistance, reformuler si incohérence détectée
</rules>
