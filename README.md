<div align="center">

![Recipes Extractor](UI/Icons/rc128.png)

# Recipes Extractor - Alpha 0.1.0

Un addon pour World of Warcraft Classic Era permettant d'extraire et de gérer les données de recettes de métiers de tous les personnages d'un compte.

</div>

<div align="center">

[![Version](https://img.shields.io/badge/version-0.1.0--alpha-orange.svg)](https://github.com/your-repo/recipes-extractor)
[![WoW Classic Era](https://img.shields.io/badge/WoW-Classic%20Era%201.14.x-blue.svg)](https://worldofwarcraft.com)
[![Status](https://img.shields.io/badge/status-Alpha-red.svg)](https://github.com/your-repo/recipes-extractor)

</div>

## 🚀 Fonctionnalités

- **Scan automatique** : Détection automatique des recettes lors de l'ouverture des fenêtres de métiers
- **Données partagées** : Les données sont partagées entre tous les personnages du même compte/royaume
- **Multiple formats d'export** : JSON complet, CSV (tableurs), et format web simplifié
- **Interface complète** : Interface graphique intuitive avec icône distinctive
- **Bouton minimap** : Accès rapide via une icône déplaçable autour de la minimap
- **Statistiques détaillées** : Vue d'ensemble des recettes collectées par personnage et métier
- **Auto-suffisant** : Aucune dépendance externe, installation simple

## 📦 Installation Rapide

1. **Téléchargez l'addon**
2. **Décompressez** le dossier `RecipesExtractor` dans votre dossier `Interface/AddOns/` de WoW Classic Era
3. **Redémarrez** le jeu ou tapez `/reload` en jeu
4. **Vérifiez** que l'addon est activé dans la liste des addons

```
Windows: C:\Program Files (x86)\World of Warcraft\_classic_era_\Interface\AddOns\
Mac: /Applications/World of Warcraft/_classic_era_/Interface/AddOns/
Linux: ~/.wine/drive_c/Program Files (x86)/World of Warcraft/_classic_era_/Interface/AddOns/
```

## 🎮 Utilisation

### Commandes de base

- `/recipes` ou `/rex` - Ouvre l'interface principale
- `/recipes scan` - Scan manuel de tous les métiers
- `/recipes export` - Ouvre l'interface d'export
- `/recipes reset` - Remet à zéro toutes les données
- `/recipes minimap` - Options du bouton minimap
- `/recipes help` - Affiche l'aide complète

### Bouton Minimap

L'addon ajoute un bouton déplaçable autour de la minimap pour un accès rapide :

- **Clic gauche** : Ouvre/ferme l'interface principale
- **Clic droit** : Menu contextuel avec actions rapides
- **Glisser** : Déplace le bouton autour de la minimap
- **Commandes** : `/recipes minimap show/hide/toggle/reset`

### Collecte automatique des données

L'addon collecte automatiquement les données lorsque vous ouvrez vos fenêtres de métiers :

1. **Métiers principaux** : Forgeron, Maroquinerie, Alchimie, Herboristerie, Minage, Couture, Ingénierie, Enchantement
2. **Métiers secondaires** : Premiers soins, Cuisine, Pêche

**Note :** L'enchantement utilise l'interface "Craft" (au lieu de "TradeSkill") mais est automatiquement détecté comme les autres métiers.

### Interface principale

L'interface est organisée en 4 onglets avec une icône distinctive :

#### 1. Vue d'ensemble (Overview)
- Statistiques générales (nombre de personnages, métiers, recettes)
- Répartition par métier avec niveaux moyens
- Instructions d'utilisation

#### 2. Personnages (Characters)
- Liste de tous les personnages scannés
- Détails des métiers et nombre de recettes par personnage
- Date de dernière mise à jour

#### 3. Export
- Export au format JSON (données complètes)
- Export au format CSV (compatible tableurs)
- Export optimisé web

#### 4. Paramètres (Settings)
- Activation/désactivation du scan automatique
- Partage des données entre personnages
- Affichage/masquage du bouton minimap
- Boutons de remise à zéro

## 📤 Formats d'export

### Format JSON
Contient toutes les données détaillées incluant :
- Informations des personnages (nom, royaume, niveau, classe, race)
- Détails des métiers (niveau, niveau maximum)
- Recettes avec réactifs, difficulté, icônes
- Horodatage des dernières mises à jour

### Format CSV
Format tabulaire compatible avec Excel/Google Sheets :
```csv
Character,Realm,Class,Level,Profession,ProfessionLevel,MaxLevel,Recipe,Type,Difficulty,Reagents
```

### Format Web
Format optimisé pour l'intégration web :
- Structure simplifiée
- Données essentielles uniquement
- Compatible avec les APIs web

## 🔧 Intégration web

L'addon génère des données spécialement formatées pour l'intégration web :

### Format Web expliqué
Le format web simplifie les données JSON complètes pour l'intégration sur les sites web :

**Données supprimées :**
- Métadonnées techniques (timestamps détaillés, icônes, type de recette)  
- Informations redondantes (GUID, dates formatées)

**Données conservées :**
- Informations personnage (nom, royaume, niveau, classe, race)
- Métiers avec niveaux actuels
- **Recettes connues par personnage** avec difficulté et réactifs

**Avantage :** Taille réduite de ~70% par rapport au JSON complet, optimisé pour l'affichage web.

### Utilisation
1. Utilisez `/recipes export` ou cliquez sur "Export for Web"
2. Copiez le texte généré (sélection automatique)
3. Collez les données sur votre site web dans la section appropriée
4. Les recettes connues de chaque personnage pourront être affichées sur les fiches de guilde

## ⚙️ Structure des données

### Base de données sauvegardée
```lua
RecipesExtractorDB = {
    version = "0.1.0-alpha",
    characters = {
        ["PersonnageName-RealmName"] = {  -- Clé unique par personnage/royaume
            name = "PersonnageName",
            realm = "RealmName", 
            guid = "player-guid",
            level = 60,
            class = "Warrior",
            race = "Human",
            lastUpdate = timestamp,
            professions = {
                ["Blacksmithing"] = {       -- Recettes spécifiques à ce personnage
                    name = "Blacksmithing",
                    level = 300,
                    maxLevel = 300,
                    lastScan = timestamp,
                    recipes = {
                        ["Recipe Name"] = {   -- Chaque recette connue par ce personnage
                            name = "Recipe Name",
                            type = "optimal",
                            difficulty = "optimal",
                            reagents = { ... },
                            icon = "Interface\\Icons\\...",
                            timestamp = timestamp
                        }
                    }
                }
            }
        }
    },
    settings = {
        autoScan = true,
        shareData = true,
        exportFormat = "json",
        minimapButtonAngle = 0,
        minimapButtonHidden = false
    }
}
```

## 🛠️ Métiers supportés

### Métiers principaux
- **Forgeron** (Blacksmithing) - ID 164
- **Maroquinerie** (Leatherworking) - ID 165  
- **Alchimie** (Alchemy) - ID 171
- **Herboristerie** (Herbalism) - ID 182
- **Minage** (Mining) - ID 186
- **Couture** (Tailoring) - ID 197
- **Ingénierie** (Engineering) - ID 202
- **Enchantement** (Enchanting) - ID 333

### Métiers secondaires
- **Premiers soins** (First Aid) - ID 129
- **Cuisine** (Cooking) - ID 185
- **Pêche** (Fishing) - ID 356

## 🐛 Dépannage

### L'addon ne charge pas
- Vérifiez que le dossier est bien dans `Interface/AddOns/RecipesExtractor/`
- Assurez-vous que le fichier `.toc` est présent
- Vérifiez que l'addon est activé dans la liste des addons

### Aucune donnée collectée
- Ouvrez manuellement vos fenêtres de métiers
- Utilisez `/recipes scan` pour forcer un scan
- Vérifiez les paramètres dans l'onglet Settings

### Bouton minimap absent
```bash
/recipes minimap show
```

### Données manquantes
- Les données sont sauvegardées par personnage/royaume
- Changez de personnage et répétez l'opération
- Utilisez `/recipes reset` et recommencez si nécessaire

### Problèmes de performance
Si l'addon ralentit le jeu :
1. Désactivez le debug dans Config.lua
2. Réduisez la fréquence de scan
3. Utilisez `/reload` pour appliquer les changements

## 🔧 Tests automatisés

L'addon inclut une suite de tests complète :

```bash
/rextest all      # Lance tous les tests
/rextest create   # Crée des données de test
/rextest clear    # Nettoie les données de test
```

## 🗂️ Structure du projet

```
RecipesExtractor/
├── RecipesExtractor.toc          # Métadonnées de l'addon WoW
├── RecipesExtractor.lua          # Point d'entrée principal
├── Config.lua                    # Configuration centralisée
├── README.md                     # Documentation complète
├── CHANGELOG.md                  # Historique des versions
├── LICENSE                       # Licence GPL v3
│
├── Core/                         # Logique métier
│   ├── Database.lua              # Gestion des données sauvegardées
│   ├── ProfessionData.lua        # Constantes et mapping des métiers
│   ├── DataCollector.lua         # Collection automatique des recettes
│   └── DataManager.lua           # Export et génération de statistiques
│
├── UI/                           # Interface utilisateur
│   ├── MainFrame.lua             # Interface principale avec icône
│   ├── ExportFrame.lua           # Interface d'export dédiée
│   ├── MinimapButton.lua         # Bouton minimap
│   └── Icons/                    # Icônes de l'addon ![Icon](UI/Icons/rc32.png)
│       ├── rc32.png              # Icône 32x32
│       ├── rc64.png              # Icône 64x64
│       ├── rc128.png             # Icône 128x128
│       ├── rc256.png             # Icône 256x256
│       └── rc512.png             # Icône 512x512
│
├── Tests/                        # Tests automatisés
│   └── TestSuite.lua             # Suite de tests complète
│
└── Examples/                     # Exemples et documentation
    └── ExampleData.lua           # Exemples de formats de données
```

## 📊 API pour développeurs

### Modules principaux

- `RecipesExtractorDatabase` : Gestion des données sauvegardées
- `RecipesExtractorDataCollector` : Scan des métiers
- `RecipesExtractorDataManager` : Export et statistiques
- `RecipesExtractorUI` : Interface utilisateur
- `RecipesExtractorMinimapButton` : Bouton minimap

### Fonctions utiles

```lua
-- Scan manuel
RecipesExtractorDataCollector:ScanAllProfessions()

-- Export JSON
local jsonData = RecipesExtractorDataManager:GenerateJSONExport()

-- Statistiques
local stats = RecipesExtractorDataManager:GetStatistics()

-- Interface
RecipesExtractorUI:ToggleMainFrame()

-- Minimap
RecipesExtractorMinimapButton:SetVisibility(true)
```

## 🔄 Changelog - Version Alpha 0.1.0

### Fonctionnalités Alpha
- ✅ Scan automatique des métiers lors de l'ouverture des fenêtres
- ✅ Support de tous les métiers Classic Era (primaires et secondaires)
- ✅ Interface graphique complète avec icône distinctive
- ✅ Base de données partagée entre personnages du même compte/royaume
- ✅ Export multiple formats (JSON, CSV, Web)
- ✅ Statistiques détaillées par personnage et métier
- ✅ Commandes slash complètes
- ✅ Gestion des réactifs et difficulté des recettes
- ✅ Format spécial optimisé pour l'intégration web
- ✅ Bouton minimap déplaçable avec menu contextuel
- ✅ Tests automatisés intégrés
- ✅ Installation auto-suffisante (pas de dépendances)

### Bouton Minimap
- **Icône personnalisée** : Utilise les icônes fournies (32x32 à 512x512)
- **Interactions** : Clic gauche (interface), clic droit (menu), glisser (déplacer)
- **Menu contextuel** : Accès rapide aux fonctions principales
- **Position sauvegardée** : Position maintenue entre les sessions
- **Notifications visuelles** : Animation lors des scans de recettes
- **Commandes** : `/recipes minimap show/hide/toggle/reset`
- **Paramètres** : Option dans l'onglet Settings pour masquer/afficher

### Interface avec icône
- **Icône dans l'angle** : Identification visuelle de l'addon
- **Design cohérent** : Style intégré à WoW Classic Era
- **Facilité d'identification** : Reconnaissable parmi les autres addons

## 🚧 Roadmap

### Version Alpha 0.2.0
- [ ] Amélioration des performances
- [ ] Correction des bugs identifiés
- [ ] Optimisation de l'interface
- [ ] Meilleure gestion d'erreurs

### Version Beta 1.0.0
- [ ] Filtres par niveau de difficulté
- [ ] Export automatique programmé
- [ ] Comparaison entre personnages
- [ ] Notifications de nouvelles recettes

### Version 1.0.0 (Release)
- [ ] Support des objets créés par les recettes
- [ ] Calcul des coûts en matériaux
- [ ] Intégration avec d'autres addons
- [ ] Documentation complète utilisateur

## 🤝 Contribution

Les contributions sont les bienvenues ! En tant que version Alpha :
- Signalez les bugs rencontrés
- Proposez des améliorations
- Testez sur différents serveurs
- Partagez vos retours d'expérience

## 📝 Licence

Ce projet est sous licence GPL v3. Voir le fichier LICENSE pour plus de détails.

La licence GPL v3 garantit que :
- ✅ Le code reste libre et open source
- ✅ Toute modification doit être partagée avec la communauté
- ✅ Personne ne peut s'approprier votre travail pour en faire un addon payant
- ✅ Les améliorations profitent à tous les joueurs WoW Classic Era

## 🆘 Support

Pour toute question ou problème :
1. Vérifiez la section Dépannage ci-dessus
2. Consultez les logs d'erreur de WoW (`/console scriptErrors 1`)
3. Utilisez les tests intégrés (`/rextest all`)
4. Ouvrez une issue sur le repository Git

---

**Version :** 0.1.0-alpha  
**Statut :** Phase de test Alpha  
**Compatible :** World of Warcraft Classic Era (1.14.x)  
**Auteur :** yokoul@auberdine.eu  
**Dernière mise à jour :** 24 juillet 2025

### Collecte automatique des données

L'addon collecte automatiquement les données lorsque vous ouvrez vos fenêtres de métiers :

1. **Métiers principaux** : Forgeron, Maroquinerie, Alchimie, Herboristerie, Minage, Couture, Ingénierie
2. **Enchantement** : Utilise l'interface spéciale "Craft"
3. **Métiers secondaires** : Premiers soins, Cuisine, Pêche

### Interface principale

L'interface est organisée en 4 onglets :

#### 1. Vue d'ensemble (Overview)
- Statistiques générales (nombre de personnages, métiers, recettes)
- Répartition par métier avec niveaux moyens
- Instructions d'utilisation

#### 2. Personnages (Characters)
- Liste de tous les personnages scannés
- Détails des métiers et nombre de recettes par personnage
- Date de dernière mise à jour

#### 3. Export
- Export au format JSON (données complètes)
- Export au format CSV (compatible tableurs)
- Export optimisé pour l'intégration web

#### 4. Paramètres (Settings)
- Activation/désactivation du scan automatique
- Partage des données entre personnages
- Affichage/masquage du bouton minimap
- Bouton de remise à zéro

### Formats d'export

#### Format JSON
Contient toutes les données détaillées incluant :
- Informations des personnages (nom, royaume, niveau, classe, race)
- Détails des métiers (niveau, niveau maximum)
- Recettes avec réactifs, difficulté, icônes
- Horodatage des dernières mises à jour

#### Format CSV
Format tabulaire compatible avec Excel/Google Sheets :
```
Character,Realm,Class,Level,Profession,ProfessionLevel,MaxLevel,Recipe,Type,Difficulty,Reagents
```

#### Format Web
Format simplifié et optimisé pour l'intégration web :
- Structure allégée sans métadonnées techniques
- Données essentielles uniquement (nom, difficulté, réactifs)
- Compatible avec les APIs web
- Permet l'affichage des recettes connues par personnage sur les sites de guilde

## Structure des données

### Base de données sauvegardée
```lua
RecipesExtractorDB = {
    version = "1.0.0",
    characters = {
        ["PersonnageName-RealmName"] = {
            name = "PersonnageName",
            realm = "RealmName", 
            guid = "player-guid",
            level = 60,
            class = "Warrior",
            race = "Human",
            lastUpdate = timestamp,
            professions = {
                ["Blacksmithing"] = {
                    name = "Blacksmithing",
                    level = 300,
                    maxLevel = 300,
                    lastScan = timestamp,
                    recipes = {
                        ["Recipe Name"] = {
                            name = "Recipe Name",
                            type = "optimal",
                            difficulty = "optimal",
                            reagents = { ... },
                            icon = "Interface\\Icons\\...",
                            timestamp = timestamp
                        }
                    }
                }
            }
        }
    },
    settings = {
        autoScan = true,
        shareData = true,
        exportFormat = "json"
    }
}
```

## Métiers supportés

### Métiers principaux
- **Forgeron** (Blacksmithing) - ID 164
- **Maroquinerie** (Leatherworking) - ID 165  
- **Alchimie** (Alchemy) - ID 171
- **Herboristerie** (Herbalism) - ID 182
- **Minage** (Mining) - ID 186
- **Couture** (Tailoring) - ID 197
- **Ingénierie** (Engineering) - ID 202
- **Enchantement** (Enchanting) - ID 333

### Métiers secondaires
- **Premiers soins** (First Aid) - ID 129
- **Cuisine** (Cooking) - ID 185
- **Pêche** (Fishing) - ID 356

## Intégration web

L'addon génère des données spécialement formatées pour l'intégration web :

1. Utilisez `/recipes export` ou cliquez sur "Export for Web"
2. Copiez le texte généré
3. Collez les données sur votre site web dans la section appropriée
4. Les données seront automatiquement intégrées aux fiches de vos personnages

## Dépannage

### L'addon ne charge pas
- Vérifiez que le dossier est bien dans `Interface/AddOns/RecipesExtractor/`
- Assurez-vous que le fichier `.toc` est présent
- Vérifiez que l'addon est activé dans la liste des addons

### Aucune donnée collectée
- Ouvrez manuellement vos fenêtres de métiers
- Utilisez `/recipes scan` pour forcer un scan
- Vérifiez les paramètres dans l'onglet Settings

### Données manquantes
- Les données sont sauvegardées par personnage/royaume
- Changez de personnage et répétez l'opération
- Utilisez `/recipes reset` et recommencez si nécessaire

## Développement

### Structure des fichiers
```
RecipesExtractor/
├── RecipesExtractor.toc          # Métadonnées de l'addon
├── RecipesExtractor.lua          # Fichier principal
├── Core/
│   ├── Database.lua              # Gestion de la base de données
│   ├── ProfessionData.lua        # Données des métiers
│   ├── DataCollector.lua         # Collection des données
│   └── DataManager.lua           # Export et statistiques
└── UI/
    ├── MainFrame.lua             # Interface principale
    └── ExportFrame.lua           # Interface d'export
```

### API principale

- `RecipesExtractorDatabase` : Gestion des données sauvegardées
- `RecipesExtractorDataCollector` : Scan des métiers
- `RecipesExtractorDataManager` : Export et statistiques
- `RecipesExtractorUI` : Interface utilisateur

## Licence

Ce projet est sous licence GPL v3. Voir le fichier LICENSE pour plus de détails.

## Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :
- Signaler des bugs
- Proposer des améliorations
- Soumettre des pull requests

## Support

Pour toute question ou problème :
1. Vérifiez la section Dépannage ci-dessus
2. Consultez les logs d'erreur de WoW (`/console scriptErrors 1`)
3. Ouvrez une issue sur le repository Git

---

**Version :** 1.0.0  
**Compatible :** World of Warcraft Classic Era (1.14.x)  
**Auteur :** YourName