#!/bin/bash



# Déclaration des variables
MASTER_IP="192.168.1.1"  # Remplacez par l'adresse IP de votre nœud maître
NODE1_IP="192.168.1.2"   # Remplacez par l'adresse IP de votre premier nœud
NODE2_IP="192.168.1.3"   # Remplacez par l'adresse IP de votre deuxième nœud
K3S_TOKEN=""             # Remplacez par le token d'accès du cluster

# Fonction pour installer K3s sur un nœud
install_k3s() {
    local IP_ADDRESS=$1
    curl -sfL https://get.k3s.io | K3S_URL="https://${MASTER_IP}:6443" K3S_TOKEN="${K3S_TOKEN}" sh -
}

# Installation sur le nœud maître
install_k3s "$MASTER_IP"

# Installation sur les nœuds
install_k3s "$NODE1_IP"
install_k3s "$NODE2_IP"

# Vérification de la connexion
echo "Nœuds ajoutés au cluster :"
kubectl get nodes
