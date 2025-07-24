# Changelog - Recipes Extractor

## Version 0.1.0-alpha (2025-07-24)

### 🚀 Première version Alpha

#### Fonctionnalités principales
- ✅ Scan automatique des métiers lors de l'ouverture des fenêtres
- ✅ Support de tous les métiers Classic Era (primaires et secondaires)
- ✅ Interface graphique complète avec 4 onglets
- ✅ Base de données partagée entre personnages du même compte/royaume
- ✅ Export multiple formats (JSON, CSV, Web)
- ✅ Statistiques détaillées par personnage et métier
- ✅ Commandes slash complètes
- ✅ Gestion des réactifs et difficulté des recettes
- ✅ Format spécial optimisé pour l'intégration web

#### Interface utilisateur
- ✅ **Icône distinctive** dans l'angle des fenêtres pour identification
- ✅ Design cohérent avec WoW Classic Era
- ✅ 4 onglets : Overview, Characters, Export, Settings
- ✅ Tooltips et aide contextuelle

#### Bouton Minimap
- ✅ **Icône personnalisée** utilisant les icônes fournies (32x32 à 512x512)
- ✅ **Interactions** : Clic gauche (interface), clic droit (menu), glisser (déplacer)
- ✅ **Menu contextuel** : Accès rapide aux fonctions principales
- ✅ **Position sauvegardée** : Position maintenue entre les sessions
- ✅ **Notifications visuelles** : Animation lors des scans de recettes
- ✅ **Commandes** : `/recipes minimap show/hide/toggle/reset`
- ✅ **Paramètres** : Option dans l'onglet Settings pour masquer/afficher

#### Auto-suffisance
- ✅ **Aucune dépendance externe** : Fonctionne sans libraries tierces
- ✅ **Installation simple** : Un seul dossier à copier
- ✅ **Validation intégrée** : Commande `/rexvalidate` pour vérifier l'installation
- ✅ **Tests automatisés** : Suite de tests complète avec `/rextest`

#### Versioning et qualité
- ✅ **Version Alpha 0.1.0** : Première version de test
- ✅ **Cohérence des versions** : TOC, Lua et Config alignés
- ✅ **Documentation complète** : README.md consolidé
- ✅ **Structure organisée** : Architecture modulaire claire

### 🔧 Améliorations techniques

#### Base de données
- Structure optimisée pour la performance
- Migration automatique des versions
- Sauvegarde fiable des paramètres minimap
- Gestion d'erreurs robuste

#### Interface
- Frames avec icônes distinctives
- Positionnement et redimensionnement optimisés
- Gestion des événements UI améliorée
- Animations fluides pour les notifications

#### Export
- 3 formats : JSON (complet), CSV (tableur), Web (intégration web)
- Sélection automatique du texte
- Instructions contextuelles par format
- Validation des données avant export

### 🐛 Corrections

#### Dépendances
- Suppression de la référence LibStub/AceGUI non utilisée
- Code 100% auto-suffisant confirmé
- Validation des dépendances intégrée

#### Versioning
- Alignement des versions dans tous les fichiers
- Cohérence TOC/Lua/Config
- Marquage explicite Alpha

#### Interface
- Positionnement correct des icônes dans les titres
- Espacement ajusté pour l'icône addon
- Tooltips multilingues (français)

### 📝 Documentation

#### Consolidation
- Fusion de tous les .md dans README.md principal
- Suppression des fichiers de documentation séparés
- Structure claire et complète

#### Contenu
- Guide d'installation détaillé
- Commandes et utilisation
- Dépannage et FAQ
- API pour développeurs
- Roadmap de développement

### 🔮 Prochaines versions

#### Alpha 0.2.0 (Prévue)
- [ ] Tests approfondis sur différents serveurs
- [ ] Optimisations de performance
- [ ] Corrections de bugs identifiés
- [ ] Amélioration de la gestion d'erreurs

#### Beta 1.0.0 (Prévue)
- [ ] Filtres avancés par difficulté
- [ ] Export automatique programmé
- [ ] Comparaison entre personnages
- [ ] Notifications de nouvelles recettes

#### Release 1.0.0 (Prévue)
- [ ] Support des objets créés
- [ ] Calcul des coûts en matériaux
- [ ] Intégration avec autres addons
- [ ] Documentation utilisateur finale

---

### Notes de version Alpha

Cette version 0.1.0-alpha représente la première itération stable de l'addon. 
Elle est considérée comme fonctionnelle pour les tests mais peut contenir des bugs.

**Statut** : Phase de test Alpha
**Stabilité** : En cours de validation
**Feedback** : Fortement encouragé

### Installation et test

1. Installez l'addon dans `Interface/AddOns/RecipesExtractor/`
2. Vérifiez l'installation avec `/rexvalidate`
3. Testez les fonctionnalités avec `/rextest create`
4. Rapportez les bugs et suggestions

**Auteur** : yokoul@auberdine.eu  
**Date** : 24 juillet 2025

### Métiers supportés
- **Primaires** : Forgeron, Maroquinerie, Alchimie, Herboristerie, Minage, Couture, Ingénierie, Enchantement
- **Secondaires** : Premiers soins, Cuisine, Pêche

### API disponible
- `RecipesExtractorDatabase` - Gestion des données
- `RecipesExtractorDataCollector` - Collection automatique
- `RecipesExtractorDataManager` - Export et statistiques  
- `RecipesExtractorUI` - Interface utilisateur

### Commandes
- `/recipes` - Interface principale
- `/recipes scan` - Scan manuel
- `/recipes export` - Interface d'export
- `/recipes reset` - Remise à zéro
- `/recipes help` - Aide

## Prochaines versions prévues

### Version 1.1.0
- [ ] Filtres par niveau de difficulté
- [ ] Export automatique programmé
- [ ] Comparaison entre personnages
- [ ] Notifications de nouvelles recettes

### Version 1.2.0
- [ ] Support des objets créés par les recettes
- [ ] Calcul des coûts en matériaux
- [ ] Intégration avec les enchères (si addon Auctioneer présent)
- [ ] Mode mini pour la barre d'action

### Version 2.0.0
- [ ] Support des serveurs privés
- [ ] Export vers base de données externe
- [ ] Synchronisation multi-serveurs
- [ ] API REST pour intégrations tierces
