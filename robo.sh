#!/bin/bash

echo "🤖 Robô Segurança analisando o histórico da branch..."

# Pega todos os commits que estão na sprint, mas não estão na main
COMMITS_SPRINT=$(git rev-list main..sprint)

if [ -z "$COMMITS_SPRINT" ]; then
    echo "✅ APROVADO: A sprint está igual à main, sem risco."
    exit 0
fi

ACHOU_ERRO=0

# Vasculha a árvore genealógica da branch atual procurando sujeira da sprint
for COMMIT in $COMMITS_SPRINT; do
    # O git merge-base pergunta: "Esse commit da sprint é ancestral da branch atual?"
    if git merge-base --is-ancestor $COMMIT HEAD 2>/dev/null; then
        ACHOU_ERRO=1
        break
    fi
done

if [ $ACHOU_ERRO -eq 1 ]; then
    echo "❌ BLOQUEADO: Detectei que esta branch herdou o histórico da 'sprint'!"
    echo "Por favor, recrie sua branch de alterações a partir da 'main'."
    exit 1
else
    echo "✅ APROVADO: Histórico limpo! Nenhuma sujeira da sprint encontrada."
    exit 0
fi