# Installation Automatisée d'un Cluster Kubernetes avec K3s

Ce script Bash automatise le processus d'installation d'un cluster Kubernetes avec K3s sur trois machines Linux (une pour le maître et deux pour les nœuds).

---

## Prérequis

Assurez-vous que chaque machine répond aux prérequis suivants :
- Système d'exploitation Linux pris en charge (Ubuntu, Debian, CentOS, etc.)
- Connexion Internet
- Espace disque suffisant
- Configuration réseau correcte (avec des adresses IP statiques recommandées)

---

## Utilisation

1. Téléchargez le script `install_cluster.sh` sur chaque machine.
2. Modifiez les variables `MASTER_IP`, `NODE1_IP`, `NODE2_IP` et `K3S_TOKEN` dans le script avec les valeurs appropriées pour votre configuration.
3. Donnez les permissions d'exécution au script : `chmod +x install_cluster.sh`.
4. Exécutez le script en tant qu'utilisateur avec les droits d'administration sur chaque machine : `./install_cluster.sh`.

---

## Variables

- `MASTER_IP`: Adresse IP du nœud maître.
- `NODE1_IP`: Adresse IP du premier nœud.
- `NODE2_IP`: Adresse IP du deuxième nœud.
- `K3S_TOKEN`: Token d'accès du cluster Kubernetes.

---

## Contributions

Les contributions sont les bienvenues ! Si vous trouvez des problèmes ou souhaitez apporter des améliorations, n'hésitez pas à ouvrir une pull request ou une issue.

---

## Support

Pour toute question ou problème, n'hésitez pas à me contacter.

---

## Remerciements

Merci d'utiliser ce script d'installation automatisée d'un cluster Kubernetes avec K3s !

