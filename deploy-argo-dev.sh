#!/bin/bash

# --- KONFIGURACJA ---
RESOURCE_GROUP="rg-devops-poc01"
CLUSTER_NAME="devops-poc01-test"
CONTEXT="devops-poc01-test"
MANIFEST="argocd-devops-project-dev.yaml"

echo "---------------------------------------------------"
echo "🚀 Rozpoczynam wdrażanie na środowisko: TEST"
echo "---------------------------------------------------"

# 1. Pobranie poświadczeń (overwrite-existing zapewnia świeży token)
echo "🔄 Pobieranie poświadczeń AKS..."
az aks get-credentials --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --overwrite-existing

# 2. Przełączenie kontekstu
echo "🎯 Ustawianie kontekstu na $CONTEXT..."
kubectl config use-context $CONTEXT

# 3. Sprawdzenie czy plik manifestu istnieje
if [ -f "$MANIFEST" ]; then
    echo "📄 Aplikowanie manifestu: $MANIFEST..."
    kubectl apply -f $MANIFEST
    
    if [ $? -eq 0 ]; then
        echo "✅ Sukces: Manifest został zaaplikowany poprawnie."
    else
        echo "❌ Błąd: Wystąpił problem podczas kubectl apply."
        exit 1
    fi
else
    echo "⚠️ Błąd: Nie znaleziono pliku $MANIFEST w bieżącym katalogu!"
    exit 1
fi

echo "---------------------------------------------------"
echo "🏁 Proces zakończony."