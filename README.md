# Script d'Installation d'un Cluster K3s

Ce dépôt contient un script permettant d'automatiser l'installation d'un cluster K3s avec un nœud maître et deux nœuds de travail en utilisant SSH.

## Prérequis

Avant d'exécuter le script, assurez-vous que les prérequis suivants sont respectés :

1. **Accès SSH** : La machine exécutant le script doit avoir un accès SSH aux nœuds maître et aux nœuds de travail sans nécessiter de mot de passe. Cela peut être configuré en utilisant des clés SSH.

2. **Configuration des Clés SSH** : Si vous n'avez pas configuré de clés SSH, suivez ces étapes :
   - Générez une nouvelle paire de clés SSH sur votre machine locale :
     ```bash
     ssh-keygen -t rsa -b 4096 -C "votre_email@example.com"
     ```
   - Copiez la clé publique sur chaque nœud (remplacez `votre_utilisateur_ssh` et `ip_du_noeud` en conséquence) :
     ```bash
     ssh-copy-id votre_utilisateur_ssh@ip_du_noeud
     ```

3. **Configuration du Réseau** : Assurez-vous que tous les nœuds sont accessibles depuis la machine exécutant le script.

## Utilisation

1. **Cloner le Dépôt** :
    ```bash
    git clone https://github.com/votre_nom_utilisateur/installation-cluster-k3s.git
    cd installation-cluster-k3s
    ```

2. **Modifier le Script** :
    - Ouvrez le script `install_k3s_cluster.sh` dans un éditeur de texte.
    - Mettez à jour les variables suivantes avec les valeurs appropriées :
      - `MASTER_IP` : Adresse IP ou nom d'hôte du nœud maître.
      - `NODE1_IP` : Adresse IP ou nom d'hôte du premier nœud de travail.
      - `NODE2_IP` : Adresse IP ou nom d'hôte du deuxième nœud de travail.
      - `SSH_USER` : Nom d'utilisateur SSH utilisé pour se connecter aux nœuds.

3. **Exécuter le Script** :
    ```bash
    chmod +x install_k3s_cluster.sh
    ./install_k3s_cluster.sh
    ```

4. **Vérification de l'Installation** :
    - Après l'exécution du script, vérifiez que K3s est installé et fonctionne sur tous les nœuds.
    - Vous pouvez vérifier l'état du service K3s sur chaque nœud :
      ```bash
      ssh votre_utilisateur_ssh@ip_du_maitre 'sudo systemctl status k3s'
      ssh votre_utilisateur_ssh@ip_du_noeud1 'sudo systemctl status k3s-agent'
      ssh votre_utilisateur_ssh@ip_du_noeud2 'sudo systemctl status k3s-agent'
      ```

## Détails du Script

Le script `install_k3s_cluster.sh` effectue les étapes suivantes :

1. **Vérification de la Connexion SSH** : Vérifie la connectivité SSH vers tous les nœuds.
2. **Installation du Nœud Maître** :
    - Met à jour les listes de paquets et installe `curl`.
    - Installe K3s sur le nœud maître.
    - Récupère le token K3s et le stocke pour une utilisation ultérieure.
3. **Installation des Nœuds de Travail** :
    - Met à jour les listes de paquets et installe `curl` sur chaque nœud de travail.
    - Joins chaque nœud de travail au nœud maître en utilisant le token K3s récupéré.

## Gestion des Erreurs

Le script inclut une gestion des erreurs pour s'assurer que chaque étape est terminée avec succès. Si une erreur survient, le script affichera un message d'erreur et s'arrêtera.


## Contribuer

Les contributions sont les bienvenues ! N'hésitez pas à ouvrir une issue ou à soumettre une pull request avec des améliorations ou des corrections de bugs.

## Contact

Pour toute question ou suggestion, n'hésitez pas à ouvrir une issue ou à contacter [H@ckthus](mailto:hackthus@gmail.com).

