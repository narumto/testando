#!/bin/bash

# O robô vai procurar se o arquivo "trava_sprint.txt" existe nesta branch
if [ -f "trava_sprint.txt" ]; then
    echo "================================================="
    echo "❌ BLOQUEADO: Esta branch nasceu da Sprint!"
    echo "❌ O arquivo 'trava_sprint.txt' foi detectado."
    echo "================================================="
    exit 1
else
    echo "✅ APROVADO: Branch limpa, pode seguir."
    exit 0
fi

