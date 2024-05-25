#!/bin/bash

# Définir les adresses IP ou les noms d'hôte du master et des nodes
MASTER_IP="192.168.1.100"
NODE1_IP="192.168.1.101"
NODE2_IP="192.168.1.102"

# Définir l'utilisateur SSH
SSH_USER="your_ssh_user"

# Fonction pour vérifier la connexion SSH
check_ssh_connection() {
    ssh -o BatchMode=yes -o ConnectTimeout=5 ${SSH_USER}@$1 'exit'
    if [ $? -ne 0 ]; then
        echo "Erreur : Impossible de se connecter à $1 via SSH."
        exit 1
    fi
}

# Fonction pour installer K3s sur le master
install_master() {
    ssh ${SSH_USER}@${MASTER_IP} << EOF
        sudo apt-get update -y
        if [ $? -ne 0 ]; then
            echo "Erreur : Échec de la mise à jour des paquets sur le master."
            exit 1
        fi

        sudo apt-get install -y curl
        if [ $? -ne 0 ]; then
            echo "Erreur : Échec de l'installation de curl sur le master."
            exit 1
        fi

        curl -sfL https://get.k3s.io | sh -
        if [ $? -ne 0 ]; then
            echo "Erreur : Échec de l'installation de K3s sur le master."
            exit 1
        fi

        sleep 10

        K3S_TOKEN=\$(sudo cat /var/lib/rancher/k3s/server/node-token)
        if [ -z "\$K3S_TOKEN" ]; then
            echo "Erreur : Échec de la récupération du token K3s sur le master."
            exit 1
        fi

        echo \$K3S_TOKEN > ~/k3s_token
        echo "K3s master installé et le token est stocké dans ~/k3s_token"
EOF

    if [ $? -ne 0 ]; then
        echo "Erreur : Échec de l'installation de K3s sur le master."
        exit 1
    fi
}

# Fonction pour installer K3s sur un node
install_node() {
    NODE_IP=$1
    MASTER_IP=$2
    TOKEN=$3
    ssh ${SSH_USER}@${NODE_IP} << EOF
        sudo apt-get update -y
        if [ $? -ne 0 ]; then
            echo "Erreur : Échec de la mise à jour des paquets sur le node $NODE_IP."
            exit 1
        fi

        sudo apt-get install -y curl
        if [ $? -ne 0 ]; then
            echo "Erreur : Échec de l'installation de curl sur le node $NODE_IP."
            exit 1
        fi

        curl -sfL https://get.k3s.io | K3S_URL=https://${MASTER_IP}:6443 K3S_TOKEN=${TOKEN} sh -
        if [ $? -ne 0 ]; then
            echo "Erreur : Échec de l'installation de K3s sur le node $NODE_IP."
            exit 1
        fi

        echo "K3s node installé et rejoint le master ${MASTER_IP}"
EOF

    if [ $? -ne 0 ]; then
        echo "Erreur : Échec de l'installation de K3s sur le node $NODE_IP."
        exit 1
    fi
}

# Vérification des connexions SSH
check_ssh_connection ${MASTER_IP}
check_ssh_connection ${NODE1_IP}
check_ssh_connection ${NODE2_IP}

# Installation du master
install_master

# Récupérer le token du master
K3S_TOKEN=$(ssh ${SSH_USER}@${MASTER_IP} "cat ~/k3s_token")
if [ -z "$K3S_TOKEN" ]; then
    echo "Erreur : Échec de la récupération du token K3s du master."
    exit 1
fi

# Installation des nodes
install_node ${NODE1_IP} ${MASTER_IP} ${K3S_TOKEN}
install_node ${NODE2_IP} ${MASTER_IP} ${K3S_TOKEN}

echo "Installation complète : 1 master et 2 nodes ont été configurés."
