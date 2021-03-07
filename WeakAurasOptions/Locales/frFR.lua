if not WeakAuras.IsCorrectVersion() then return end

if not(GetLocale() == "frFR") then
  return
end

local L = WeakAuras.L

-- WeakAuras/Options
	--[[Translation missing --]]
	L[" and |cFFFF0000mirrored|r"] = " and |cFFFF0000mirrored|r"
	L["-- Do not remove this comment, it is part of this trigger: "] = "-- Ne retirez pas ce commentaire, il fait partie de ce déclencheur : "
	--[[Translation missing --]]
	L[" rotated |cFFFF0000%s|r degrees"] = " rotated |cFFFF0000%s|r degrees"
	L["% of Progress"] = "% de progression"
	L["%i auras selected"] = "%i auras sélectionnées"
	L["%i Matches"] = "%i Correspondances"
	L["%s - Option #%i has the key %s. Please choose a different option key."] = "%s - L'option #%i est attribuée à la touche %s. Veuillez choisir une touche différente."
	L["%s %s, Lines: %d, Frequency: %0.2f, Length: %d, Thickness: %d"] = "%s %s, Lignes : %d, Fréquence : %0.2f, Longueur : %d, Epaisseur : %d"
	L["%s %s, Particles: %d, Frequency: %0.2f, Scale: %0.2f"] = "%s %s, Particules : %d, Fréquence : %0.2f, Échelle : %0.2f"
	L["%s Alpha: %d%%"] = "%s opacité : %d%%"
	L["%s Color"] = "%s Couleur"
	--[[Translation missing --]]
	L["%s Default Alpha, Zoom, Icon Inset, Aspect Ratio"] = "%s Default Alpha, Zoom, Icon Inset, Aspect Ratio"
	L["%s Inset: %d%%"] = "%s Insérer: %d%%"
	--[[Translation missing --]]
	L["%s is not a valid SubEvent for COMBAT_LOG_EVENT_UNFILTERED"] = "%s is not a valid SubEvent for COMBAT_LOG_EVENT_UNFILTERED"
	L["%s Keep Aspect Ratio"] = "%s Conserver les proportions"
	L["%s total auras"] = "%s auras au total"
	L["%s Zoom: %d%%"] = "%s Zoom: %d%%"
	L["%s, Border"] = "%s, Bordure"
	L["%s, Offset: %0.2f;%0.2f"] = "%s, Décaler: %0.2f;%0.2f"
	L["%s, offset: %0.2f;%0.2f"] = "%s, décaler: %0.2f;%0.2f"
	L["%s|cFFFF0000custom|r texture with |cFFFF0000%s|r blend mode%s%s"] = "%s|cFFFF0000custom|r texture avec |cFFFF0000%s|r mode fusionné%s%s"
	L["(Right click to rename)"] = "(Clique droit pour renommer)"
	--[[Translation missing --]]
	L["|c%02x%02x%02x%02xCustom Color|r"] = "|c%02x%02x%02x%02xCustom Color|r"
	--[[Translation missing --]]
	L["|cFFE0E000Note:|r This sets the description only on '%s'"] = "|cFFE0E000Note:|r This sets the description only on '%s'"
	L["|cFFE0E000Note:|r This sets the URL on all selected auras"] = "|cFFE0E000Note:|r Ceci définit l'URL sur toutes les auras sélectionnées"
	--[[Translation missing --]]
	L["|cFFE0E000Note:|r This sets the URL on this group and all its members."] = "|cFFE0E000Note:|r This sets the URL on this group and all its members."
	L["|cFFFF0000Automatic|r length"] = "|cFFFF0000Automatic|r longueur"
	L["|cFFFF0000default|r texture"] = "|cFFFF0000default|r texture"
	L["|cFFFF0000desaturated|r "] = "|cFFFF0000desaturated|r"
	--[[Translation missing --]]
	L["|cFFFF0000Note:|r The unit '%s' is not a trackable unit."] = "|cFFFF0000Note:|r The unit '%s' is not a trackable unit."
	L["|cFFffcc00Anchors:|r Anchored |cFFFF0000%s|r to frame's |cFFFF0000%s|r"] = "|cFFffcc00Ancrages :|r Ancré |cFFFF0000%s|r au cadre de |cFFFF0000%s|r"
	L["|cFFffcc00Anchors:|r Anchored |cFFFF0000%s|r to frame's |cFFFF0000%s|r with offset |cFFFF0000%s/%s|r"] = "|cFFffcc00Ancrages :|r Ancré |cFFFF0000%s|r au cadre de ... |cFFFF0000%s|r avec un décalage de |cFFFF0000%s/%s|r"
	L["|cFFffcc00Anchors:|r Anchored to frame's |cFFFF0000%s|r"] = "|cFFffcc00Ancrages :|r Ancré au cadre de |cFFFF0000%s|r"
	L["|cFFffcc00Anchors:|r Anchored to frame's |cFFFF0000%s|r with offset |cFFFF0000%s/%s|r"] = "|cFFffcc00Ancrages :|r Ancré au cadre de ... |cFFFF0000%s|r avec un décalage de |cFFFF0000%s/%s|r"
	L["|cFFffcc00Extra Options:|r"] = "|cFFffcc00Options supplémentaires :|r"
	L["|cFFffcc00Extra:|r %s and %s %s"] = "|cFFffcc00Extra:|r %s et %s %s"
	--[[Translation missing --]]
	L["|cFFffcc00Font Flags:|r |cFFFF0000%s|r and shadow |c%sColor|r with offset |cFFFF0000%s/%s|r%s%s"] = "|cFFffcc00Font Flags:|r |cFFFF0000%s|r and shadow |c%sColor|r with offset |cFFFF0000%s/%s|r%s%s"
	--[[Translation missing --]]
	L["|cFFffcc00Font Flags:|r |cFFFF0000%s|r and shadow |c%sColor|r with offset |cFFFF0000%s/%s|r%s%s%s"] = "|cFFffcc00Font Flags:|r |cFFFF0000%s|r and shadow |c%sColor|r with offset |cFFFF0000%s/%s|r%s%s%s"
	--[[Translation missing --]]
	L["|cFFffcc00Format Options|r"] = "|cFFffcc00Format Options|r"
	L["1 Match"] = "1 Correspondance"
	L["A 20x20 pixels icon"] = "Une icône de 20x20 pixels."
	L["A 32x32 pixels icon"] = "Une icône de 32x32 pixels."
	L["A 40x40 pixels icon"] = "Une icône de 40x40 pixels."
	L["A 48x48 pixels icon"] = "Une icône de 48x48 pixels."
	L["A 64x64 pixels icon"] = "Une icône de 64x64 pixels."
	L["A group that dynamically controls the positioning of its children"] = "Un groupe qui contrôle dynamiquement le positionnement de ses enfants"
	L["A Unit ID (e.g., party1)."] = "Un identifiant d'unité (par.ex., groupe1)"
	L["Actions"] = "Actions"
	L["Add"] = "Ajouter"
	L["Add %s"] = "Ajouter %s"
	L["Add a new display"] = "Ajouter un nouvel affichage"
	L["Add Condition"] = "Ajouter une Condition"
	L["Add Entry"] = "Ajouter une entrée"
	L["Add Extra Elements"] = "Ajouter des éléments supplémentaires"
	L["Add Option"] = "Ajouter Option"
	L["Add Overlay"] = "Ajouter un Overlay"
	L["Add Property Change"] = "Ajouter un Changement de Propriété"
	--[[Translation missing --]]
	L["Add Snippet"] = "Add Snippet"
	L["Add Sub Option"] = "Ajouter un sous-option"
	L["Add to group %s"] = "Ajouter au groupe %s"
	L["Add to new Dynamic Group"] = "Ajouter à un nouveau groupe dynamique"
	L["Add to new Group"] = "Ajouter à un nouveau groupe"
	L["Add Trigger"] = "Ajouter déclencheur"
	L["Additional Events"] = "Événements supplémentaires"
	L["Addon"] = "Addon"
	L["Addons"] = "Addons"
	L["Advanced"] = "Avancé"
	L["Align"] = "Aligner"
	L["Alignment"] = "Alignement"
	L["All of"] = "Tous vos"
	L["Allow Full Rotation"] = "Permettre une rotation complète"
	L["Alpha"] = "Opacité"
	L["Anchor"] = "Ancrage"
	L["Anchor Point"] = "Point d'ancrage"
	L["Anchored To"] = "Ancré à"
	L["And "] = "Et"
	L["and aligned left"] = "et alignés à gauche"
	L["and aligned right"] = "et alignés à droite"
	--[[Translation missing --]]
	L["and rotated left"] = "and rotated left"
	--[[Translation missing --]]
	L["and rotated right"] = "and rotated right"
	L["and Trigger %s"] = "et Déclencheur %s"
	--[[Translation missing --]]
	L["and with width |cFFFF0000%s|r and %s"] = "and with width |cFFFF0000%s|r and %s"
	L["Angle"] = "Angle"
	L["Animate"] = "Animer"
	L["Animated Expand and Collapse"] = "Expansion et réduction animés"
	L["Animates progress changes"] = "Animer les changement de progression"
	--[[Translation missing --]]
	L["Animation End"] = "Animation End"
	--[[Translation missing --]]
	L["Animation Mode"] = "Animation Mode"
	L["Animation relative duration description"] = [=[La durée de l'animation par rapport à la durée du graphique, exprimée en fraction (1/2), pourcentage (50%), ou décimal (0.5).
|cFFFF0000Note :|r si un graphique n'a pas de progression (déclencheur d'événement sans durée définie, aura sans durée, etc), l'animation ne jouera pas.

|cFF4444FFPar exemple :|r
Si la durée de l'animation est définie à |cFF00CC0010%|r, et le déclencheur du graphique est une amélioration qui dure 20 secondes, l'animation de début jouera pendant 2 secondes.
Si la durée de l'animation est définie à |cFF00CC0010%|r, et le déclencheur du graphique n'a pas de durée définie, aucune d'animation de début ne jouera (mais elle jouerait si vous aviez spécifié une durée en secondes).
]=]
	L["Animation Sequence"] = "Séquence d'animation"
	--[[Translation missing --]]
	L["Animation Start"] = "Animation Start"
	L["Animations"] = "Animations"
	L["Any of"] = "Un de"
	L["Apply Template"] = "Appliquer le modèle"
	L["Arcane Orb"] = "Orbe d'arcane"
	L["At a position a bit left of Left HUD position."] = "Une position à gauche de la Position ATH Gauche."
	L["At a position a bit left of Right HUD position"] = "Une position à droite de la Position ATH Droite."
	L["At the same position as Blizzard's spell alert"] = "À la même position que l'alerte de sort de Blizzard."
	--[[Translation missing --]]
	L[ [=[Aura is
Off Screen]=] ] = [=[Aura is
Off Screen]=]
	L["Aura Name"] = "Nom de l'aura"
	L["Aura Name Pattern"] = "Modèle de Nom de l'Aura"
	L["Aura Type"] = "Type de l'aura"
	L["Aura(s)"] = "Aura(s)"
	L["Author Options"] = "Options de l'Auteur"
	L["Auto-Clone (Show All Matches)"] = "Clonage Automatique (Afficher tous les résultats)"
	L["Auto-cloning enabled"] = "Auto-clonage activé"
	L["Automatic"] = "Automatique"
	--[[Translation missing --]]
	L["Automatic length"] = "Automatic length"
	L["Backdrop Color"] = "Couleur de Fond"
	L["Backdrop in Front"] = "Fond Devant"
	L["Backdrop Style"] = "Style de Fond"
	--[[Translation missing --]]
	L["Background"] = "Background"
	L["Background Color"] = "Couleur de fond"
	--[[Translation missing --]]
	L["Background Inner"] = "Background Inner"
	L["Background Offset"] = "Décalage du Fond "
	L["Background Texture"] = "Texture d'arrière plan"
	L["Bar Alpha"] = "Opacité de la barre"
	L["Bar Color"] = "Couleur de barre"
	L["Bar Color Settings"] = "Paramètres de la barre de couleur"
	L["Bar Texture"] = "Texture de barre"
	L["Big Icon"] = "Grande icône"
	L["Blend Mode"] = "Mode du fusion"
	L["Blue Rune"] = "Rune bleue"
	L["Blue Sparkle Orb"] = "Orbe pétillant bleu"
	L["Border"] = "Encadrement"
	L["Border %s"] = "Encadrement %s"
	L["Border Anchor"] = "Ancrage de l'encadrement"
	L["Border Color"] = "Couleur de l'encadrement"
	L["Border in Front"] = "Bordure Devant"
	L["Border Inset"] = "Encart Fond"
	L["Border Offset"] = "Décalage Bordure"
	L["Border Settings"] = "Paramètres de l'encadrement"
	L["Border Size"] = "Taille de l'encadrement"
	L["Border Style"] = "Style d'encadrement"
	L["Bottom"] = "Bas"
	L["Bottom Left"] = "Bas gauche"
	L["Bottom Right"] = "Bas droit"
	L["Bracket Matching"] = "Crochet Correspondant"
	--[[Translation missing --]]
	L["Browse Wago, the largest collection of auras."] = "Browse Wago, the largest collection of auras."
	L["Can be a Name or a Unit ID (e.g. party1). A name only works on friendly players in your group."] = "Peut être un nom ou un identifiant d'unité (par.ex..groupe1).Un nom ne fonctionne que sur les joueurs amicaux de votre groupe"
	--[[Translation missing --]]
	L["Can be a UID (e.g., party1)."] = "Can be a UID (e.g., party1)."
	L["Cancel"] = "Annuler"
	--[[Translation missing --]]
	L["Cast by Player Character"] = "Cast by Player Character"
	--[[Translation missing --]]
	L["Cast by Players"] = "Cast by Players"
	L["Center"] = "Centre"
	L["Chat Message"] = "Message dans le chat"
	--[[Translation missing --]]
	L["Chat with WeakAuras experts on our Discord server."] = "Chat with WeakAuras experts on our Discord server."
	L["Check On..."] = "Vérifier sur..."
	--[[Translation missing --]]
	L["Check out our wiki for a large collection of examples and snippets."] = "Check out our wiki for a large collection of examples and snippets."
	L["Children:"] = "Enfant :"
	L["Choose"] = "Choisir"
	L["Class"] = "Classe"
	L["Clip Overlays"] = "Superposition de l'attache "
	--[[Translation missing --]]
	L["Clipped by Progress"] = "Clipped by Progress"
	L["Close"] = "Fermer"
	L["Collapse"] = "Réduire"
	L["Collapse all loaded displays"] = "Réduire tous les affichages chargés"
	L["Collapse all non-loaded displays"] = "Réduire tous les affichage non-chargés"
	--[[Translation missing --]]
	L["Collapsible Group"] = "Collapsible Group"
	L["color"] = "couleur"
	L["Color"] = "Couleur"
	L["Column Height"] = "Hauteur de colonne"
	L["Column Space"] = "Espace de colonne"
	L["Columns"] = "Colonnes"
	L["Combinations"] = "Combinaisons"
	L["Combine Matches Per Unit"] = "Combiner toutes les Correspondances Par Unité"
	L["Common Text"] = "Texte commun"
	L["Compare against the number of units affected."] = "Comparer contre le nombre d'unités affectées."
	--[[Translation missing --]]
	L["Compatibility Options"] = "Compatibility Options"
	L["Compress"] = "Compresser"
	L["Condition %i"] = "Condition %i"
	L["Conditions"] = "Conditions"
	--[[Translation missing --]]
	L["Configure what options appear on this panel."] = "Configure what options appear on this panel."
	L["Constant Factor"] = "Facteur constant"
	L["Control-click to select multiple displays"] = "Ctrl-clic pour sélectionner plusieurs affichages"
	L["Controls the positioning and configuration of multiple displays at the same time"] = "Contrôle la position et la configuration de plusieurs affichages en même temps"
	L["Convert to New Aura Trigger"] = "Convertir au nouveau déclencheur d'aura"
	L["Convert to..."] = "Convertir en..."
	L["Cooldown Edge"] = "Marge de la Recharge "
	L["Cooldown Settings"] = "Paramètres du temps de recharge"
	L["Cooldown Swipe"] = "Balayage du temps de recharge"
	L["Copy"] = "Copier"
	L["Copy settings..."] = "Copier les paramètres..."
	L["Copy to all auras"] = "Copier toutes les auras"
	--[[Translation missing --]]
	L["Could not parse '%s'. Expected a table."] = "Could not parse '%s'. Expected a table."
	L["Count"] = "Compte"
	L["Counts the number of matches over all units."] = "Comptes de tout le nombre de correspondances sur toutes les unités."
	L["Creating buttons: "] = "Création de boutons :"
	L["Creating options: "] = "Création d'options :"
	L["Crop X"] = "Couper X"
	L["Crop Y"] = "Couper Y"
	L["Custom"] = "Personnalisé"
	L["Custom Anchor"] = "Ancrage personnalisé"
	--[[Translation missing --]]
	L["Custom Background"] = "Custom Background"
	--[[Translation missing --]]
	L["Custom Check"] = "Custom Check"
	L["Custom Code"] = "Code personnalisé"
	--[[Translation missing --]]
	L["Custom Color"] = "Custom Color"
	L["Custom Configuration"] = "Configuration personnalisée"
	--[[Translation missing --]]
	L["Custom Foreground"] = "Custom Foreground"
	L["Custom Frames"] = "Cadres personnalisés"
	L["Custom Function"] = "Fonction personnalisée"
	L["Custom Grow"] = "Surbrillance personnalisée"
	L["Custom Options"] = "Options personnalisées"
	L["Custom Sort"] = "Tri personnalisé"
	L["Custom Trigger"] = "Déclencheur personnalisé"
	L["Custom trigger event tooltip"] = [=[
Choisissez quels évènements peuvent activer le déclencheur.
Plusieurs évènements peuvent être spécifiés avec des virgules ou des espaces.

|cFF4444FFPar exemple:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED
]=]
	L["Custom trigger status tooltip"] = [=[
Choisissez quels évènements peuvent activer le déclencheur.
Comme c'est un déclencheur de type statut, les évènements spécifiés peuvent être appelés par WeakAuras sans les arguments attendus.
Plusieurs évènements peuvent être spécifiés avec des virgules ou des espaces.

|cFF4444FFPar exemple:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED
]=]
	L["Custom Untrigger"] = "Désactivation personnalisée"
	L["Custom Variables"] = "Variables personnalisées"
	L["Debuff Type"] = "Type d'affaiblissement"
	L["Default"] = "Par défaut"
	--[[Translation missing --]]
	L["Default Color"] = "Default Color"
	L["Delete"] = "Supprimer"
	L["Delete all"] = "Supprimer tout"
	L["Delete children and group"] = "Supprimer enfants et groupe"
	--[[Translation missing --]]
	L["Delete Entry"] = "Delete Entry"
	L["Desaturate"] = "Dé-saturer"
	L["Description"] = "Description"
	L["Description Text"] = "Texte de Description"
	--[[Translation missing --]]
	L["Determines how many entries can be in the table."] = "Determines how many entries can be in the table."
	L["Differences"] = "Différences"
	L["Disabled"] = "Désactivé"
	--[[Translation missing --]]
	L["Disallow Entry Reordering"] = "Disallow Entry Reordering"
	L["Discrete Rotation"] = "Rotation individuelle"
	L["Display"] = "Affichage"
	L["Display Name"] = "Nom de l'affichage"
	L["Display Text"] = "Texte de l'affichage"
	L["Displays a text, works best in combination with other displays"] = "Affiche du texte, fonctionne mieux en combinaison avec d'autres affichages."
	L["Distribute Horizontally"] = "Distribuer horizontalement"
	L["Distribute Vertically"] = "Distribuer verticalement"
	L["Do not group this display"] = "Ne pas grouper cet affichage"
	L["Documentation"] = "Documentation"
	L["Done"] = "Terminé"
	L["Don't skip this Version"] = [=[
Ne sautez pas cette version]=]
	L["Drag to move"] = "Glisser pour déplacer"
	L["Duplicate"] = "Doubler"
	L["Duplicate All"] = "Doubler Tout"
	L["Duration (s)"] = "Durée (s)"
	L["Duration Info"] = "Info de durée"
	L["Dynamic Duration"] = "Durée Dynamique"
	L["Dynamic Group"] = "Groupe Dynamique"
	L["Dynamic Group Settings"] = "Paramètres de Groupe Dynamiques"
	L["Dynamic Information"] = "Information Dynamique"
	L["Dynamic information from first active trigger"] = "Information dynamique depuis le premier déclencheur"
	L["Dynamic information from Trigger %i"] = "Information dynamique du Déclencheur %i"
	L["Dynamic text tooltip"] = [=[Il y a plusieurs codes spéciaux disponibles pour rendre ce texte dynamique :

|cFFFF0000%p|r - Progression - Le temps restant sur un compteur, ou une valeur autre
|cFFFF0000%t|r - Total - La durée maximum d'un compteur, ou le maximum d'une valeur autre
|cFFFF0000%n|r - Nom - Le nom du graphique (souvent le nom d'une aura), ou l'ID du graphique s'il n'y a pas de nom dynamique
|cFFFF0000%i|r - Icône - L'icône associée à l'affichage
|cFFFF0000%s|r - Pile - La taille de la pile d'une aura (généralement)
|cFFFF0000%c|r - Personnalisé - Vous permet de définir une fonction Lua personnalisée qui donne un texte à afficher]=]
	--[[Translation missing --]]
	L["Ease Strength"] = "Ease Strength"
	--[[Translation missing --]]
	L["Ease type"] = "Ease type"
	--[[Translation missing --]]
	L["Edge"] = "Edge"
	--[[Translation missing --]]
	L["eliding"] = "eliding"
	--[[Translation missing --]]
	L["Else If"] = "Else If"
	--[[Translation missing --]]
	L["Else If Trigger %s"] = "Else If Trigger %s"
	L["Enabled"] = "Activé"
	L["End Angle"] = "Angle de fin"
	--[[Translation missing --]]
	L["End of %s"] = "End of %s"
	L["Enter a Spell ID"] = "Entrer un ID de sort"
	L["Enter an aura name, partial aura name, or spell id"] = "Entrez un nom d'aura, nom d'aura partiel ou ID de sort"
	L["Enter an Aura Name, partial Aura Name, or Spell ID. A Spell ID will match any spells with the same name."] = "Entrez un nom d’aura, un nom d’aura partiel ou un identifiant de sort. Un identifiant de sort correspond à tous les sorts de même nom."
	L["Enter Author Mode"] = "Entrer en Mode Auteur"
	--[[Translation missing --]]
	L["Enter in a value for the tick's placement."] = "Enter in a value for the tick's placement."
	L["Enter User Mode"] = "Entrer en Mode Utilisateur."
	L["Enter user mode."] = "Entrer en Mode Utilisateur."
	--[[Translation missing --]]
	L["Entry %i"] = "Entry %i"
	--[[Translation missing --]]
	L["Entry limit"] = "Entry limit"
	--[[Translation missing --]]
	L["Entry Name Source"] = "Entry Name Source"
	L["Event Type"] = "Type d'évènement"
	L["Event(s)"] = "Évènement(s)"
	L["Everything"] = "Tous"
	L["Exact Spell ID(s)"] = "ID(s) de sort exact(s)"
	L["Exact Spell Match"] = "Correspondance Exacte du Sort"
	L["Expand"] = "Agrandir"
	L["Expand all loaded displays"] = "Agrandir tous affichages chargés"
	L["Expand all non-loaded displays"] = "Agrandir tous affichage non-chargés"
	L["Expansion is disabled because this group has no children"] = "L'expansion est désactivée car ce groupe n'a pas d'enfants"
	L["Export to Lua table..."] = "Exporter vers une table Lua..."
	L["Export to string..."] = "Exporter vers une chaîne..."
	L["External"] = "Externe"
	L["Fade"] = "Fondu"
	L["Fade In"] = "Fondu entrant"
	L["Fade Out"] = "Fondu sortant"
	--[[Translation missing --]]
	L["Fallback"] = "Fallback"
	--[[Translation missing --]]
	L["Fallback Icon"] = "Fallback Icon"
	L["False"] = "Faux"
	L["Fetch Affected/Unaffected Names"] = "chercher concerné/Noms non-concernés"
	--[[Translation missing --]]
	L["Filter by Class"] = "Filter by Class"
	L["Filter by Group Role"] = "Filtrer par Rôle de Groupe"
	--[[Translation missing --]]
	L["Filter by Nameplate Type"] = "Filter by Nameplate Type"
	--[[Translation missing --]]
	L["Filter by Raid Role"] = "Filter by Raid Role"
	--[[Translation missing --]]
	L[ [=[Filter formats: 'Name', 'Name-Realm', '-Realm'.

Supports multiple entries, separated by commas
]=] ] = [=[Filter formats: 'Name', 'Name-Realm', '-Realm'.

Supports multiple entries, separated by commas
]=]
	--[[Translation missing --]]
	L["Find Auras"] = "Find Auras"
	L["Finish"] = "Finir"
	L["Fire Orb"] = "Orbe de feu"
	L["Font"] = "Police"
	L["Font Size"] = "Taille de Police"
	L["Foreground"] = "Premier plan"
	L["Foreground Color"] = "Couleur premier-plan"
	L["Foreground Texture"] = "Texture premier-plan"
	L["Format"] = "Format"
	L["Format for %s"] = "Format pour %s"
	L["Found a Bug?"] = "Trouvé un bogue?"
	L["Frame"] = "Cadre"
	--[[Translation missing --]]
	L["Frame Count"] = "Frame Count"
	--[[Translation missing --]]
	L["Frame Rate"] = "Frame Rate"
	--[[Translation missing --]]
	L["Frame Selector"] = "Frame Selector"
	L["Frame Strata"] = "Strate du cadre"
	L["Frequency"] = "Fréquence"
	L["From Template"] = "D'après un modèle"
	--[[Translation missing --]]
	L["From version %s to version %s"] = "From version %s to version %s"
	L["Full Circle"] = "Cercle Complet"
	--[[Translation missing --]]
	L["Get Help"] = "Get Help"
	L["Global Conditions"] = "Conditions globales"
	--[[Translation missing --]]
	L["Glow %s"] = "Glow %s"
	L["Glow Action"] = "Action de l'éclat"
	--[[Translation missing --]]
	L["Glow Anchor"] = "Glow Anchor"
	L["Glow Color"] = "Couleur de la surbrillance"
	--[[Translation missing --]]
	L["Glow External Element"] = "Glow External Element"
	--[[Translation missing --]]
	L["Glow Frame Type"] = "Glow Frame Type"
	L["Glow Type"] = "Type de la surbrillance"
	L["Green Rune"] = "Rune verte"
	L["Grid direction"] = "Direction de la grille"
	L["Group"] = "Groupe"
	L["Group (verb)"] = "Groupe (verbe)"
	L["Group aura count description"] = [=[Le nombre de membres du %s qui doivent être affectés par une ou plusieurs des auras sélectionnées pour que l'affichage soit déclenché.
Si le nombre entré est un entier (ex. 5), le nombre de membres du raid affectés sera comparé au nombre entré.
Si le nombre entré est decimal (ex. 0.5), une fraction (ex. 1/2), ou un pourcentage (ex. 50%%), alors cette fraction du %s doit être affectée.

|cFF4444FFPar exemple :|r
|cFF00CC00> 0|r se déclenchera quand n'importe quel membre du %s est affecté
|cFF00CC00= 100%%|r se déclenchera quand tous les membres du %s sont affectés
|cFF00CC00!= 2|r se déclenchera quand le nombre de membres du %s affectés est différent de 2
|cFF00CC00<= 0.8|r se déclenchera quand moins de 80%% du %s est affecté (4 des 5 membres du groupe, 8 des 10 ou 20 des 25 membres du raid )
|cFF00CC00> 1/2|r se déclenchera quand plus de la moitié du %s est affecté
|cFF00CC00>= 0|r se déclenchera toujours, quoi qu'il arrive
]=]
	--[[Translation missing --]]
	L["Group by Frame"] = "Group by Frame"
	L["Group contains updates from Wago"] = "Le groupe contient des mises à jour de https://wago.io/"
	--[[Translation missing --]]
	L["Group Description"] = "Group Description"
	L["Group Icon"] = "Icône du groupe"
	--[[Translation missing --]]
	L["Group key"] = "Group key"
	L["Group Member Count"] = "Nombre de membres du groupe"
	--[[Translation missing --]]
	L["Group Options"] = "Group Options"
	L["Group Role"] = "Rôle du Groupe"
	L["Group Scale"] = "Échelle du Groupe"
	L["Group Settings"] = "Paramètres du groupe"
	--[[Translation missing --]]
	L["Group Type"] = "Group Type"
	L["Grow"] = "Grandir"
	L["Hawk"] = "Faucon"
	L["Height"] = "Hauteur"
	L["Help"] = "Aide"
	L["Hide"] = "Cacher"
	L["Hide Cooldown Text"] = "Cacher le texte du temps de recharge"
	--[[Translation missing --]]
	L["Hide Glows applied by this aura"] = "Hide Glows applied by this aura"
	L["Hide on"] = "Cacher à"
	L["Hide this group's children"] = "Cacher les enfants de ce groupe"
	L["Hide When Not In Group"] = "Cacher hors d'un groupe"
	L["Horizontal Align"] = "Aligner horizontalement"
	L["Horizontal Bar"] = "Barre horizontale"
	L["Hostility"] = "Hostilité"
	L["Huge Icon"] = "Énorme icône"
	L["Hybrid Position"] = "Position hybride"
	L["Hybrid Sort Mode"] = "Mode de tri hybride"
	L["Icon"] = "Icône"
	L["Icon Info"] = "Info d'icône"
	L["Icon Inset"] = "Objet inséré"
	L["Icon Position"] = "Position de l'icône"
	L["Icon Settings"] = "Paramètres de l'icône"
	--[[Translation missing --]]
	L["Icon Source"] = "Icon Source"
	L["If"] = "Si"
	--[[Translation missing --]]
	L["If checked, then the user will see a multi line edit box. This is useful for inputting large amounts of text."] = "If checked, then the user will see a multi line edit box. This is useful for inputting large amounts of text."
	--[[Translation missing --]]
	L["If checked, then this option group can be temporarily collapsed by the user."] = "If checked, then this option group can be temporarily collapsed by the user."
	--[[Translation missing --]]
	L["If checked, then this option group will start collapsed."] = "If checked, then this option group will start collapsed."
	L["If checked, then this separator will include text. Otherwise, it will be just a horizontal line."] = [=[
Si cette case est cochée, ce séparateur inclura du texte. Sinon, ce sera juste une ligne horizontale]=]
	--[[Translation missing --]]
	L["If checked, then this separator will not merge with other separators when selecting multiple auras."] = "If checked, then this separator will not merge with other separators when selecting multiple auras."
	L["If checked, then this space will span across multiple lines."] = "Si cette case est cochée, cet espace s'étendra sur plusieurs lignes."
	L["If Trigger %s"] = "Si Déclencheur %s"
	L["If unchecked, then a default color will be used (usually yellow)"] = "Si cette case n'est pas cochée, une couleur par défaut sera utilisée (généralement jaune)"
	L["If unchecked, then this space will fill the entire line it is on in User Mode."] = "Si cette case n'est pas cochée, cet espace remplira toute la ligne sur laquelle il est activé en Mode Utilisateur."
	L["Ignore all Updates"] = "Ignorer toutes les mises à jour"
	--[[Translation missing --]]
	L["Ignore Dead"] = "Ignore Dead"
	--[[Translation missing --]]
	L["Ignore Disconnected"] = "Ignore Disconnected"
	--[[Translation missing --]]
	L["Ignore Lua Errors on OPTIONS event"] = "Ignore Lua Errors on OPTIONS event"
	--[[Translation missing --]]
	L["Ignore out of checking range"] = "Ignore out of checking range"
	L["Ignore Self"] = "S'ignorer"
	L["Ignore self"] = "Ignorer soi-même"
	L["Ignored"] = "Ignoré"
	--[[Translation missing --]]
	L["Ignored Aura Name"] = "Ignored Aura Name"
	--[[Translation missing --]]
	L["Ignored Exact Spell ID(s)"] = "Ignored Exact Spell ID(s)"
	--[[Translation missing --]]
	L["Ignored Name(s)"] = "Ignored Name(s)"
	--[[Translation missing --]]
	L["Ignored Spell ID"] = "Ignored Spell ID"
	L["Import"] = "Importer"
	L["Import a display from an encoded string"] = "Importer un graphique d'un texte encodé"
	--[[Translation missing --]]
	L["Indent Size"] = "Indent Size"
	L["Information"] = "Information"
	L["Inner"] = "Intérieur"
	L["Invalid Item Name/ID/Link"] = "Nom/ID/Lien Invalide"
	L["Invalid Spell ID"] = "ID du Sort Invalide"
	L["Invalid Spell Name/ID/Link"] = "Nom du Sort/ID/Lien Invalide"
	--[[Translation missing --]]
	L["Invalid type for '%s'. Expected 'bool', 'number', 'select', 'string', 'timer' or 'elapsedTimer'."] = "Invalid type for '%s'. Expected 'bool', 'number', 'select', 'string', 'timer' or 'elapsedTimer'."
	--[[Translation missing --]]
	L["Invalid type for property '%s' in '%s'. Expected '%s'"] = "Invalid type for property '%s' in '%s'. Expected '%s'"
	L["Inverse"] = "Inverser"
	L["Inverse Slant"] = "Inverser l'Inclinaison"
	--[[Translation missing --]]
	L["Is Boss Debuff"] = "Is Boss Debuff"
	L["Is Stealable"] = "Est subtilisable "
	L["Justify"] = "Justification"
	L["Keep Aspect Ratio"] = "Conserver les Proportions"
	--[[Translation missing --]]
	L["Keep your Wago imports up to date with the Companion App."] = "Keep your Wago imports up to date with the Companion App."
	--[[Translation missing --]]
	L["Large Input"] = "Large Input"
	L["Leaf"] = "Feuille"
	L["Left"] = "Gauche"
	L["Left 2 HUD position"] = "Position ATH Gauche 2"
	L["Left HUD position"] = "Position ATH Gauche"
	L["Length"] = "Longueur"
	--[[Translation missing --]]
	L["Length of |cFFFF0000%s|r"] = "Length of |cFFFF0000%s|r"
	L["Limit"] = "Limite"
	--[[Translation missing --]]
	L["Lines & Particles"] = "Lines & Particles"
	L["Load"] = "Chargement"
	L["Loaded"] = "Chargé"
	--[[Translation missing --]]
	L["Lock Positions"] = "Lock Positions"
	L["Loop"] = "Boucle"
	L["Low Mana"] = "Mana bas"
	--[[Translation missing --]]
	L["Magnetically Align"] = "Magnetically Align"
	L["Main"] = "Principal"
	L["Manage displays defined by Addons"] = "Gérer les affichages définis par des addons"
	--[[Translation missing --]]
	L["Match Count"] = "Match Count"
	--[[Translation missing --]]
	L["Matches the height setting of a horizontal bar or width for a vertical bar."] = "Matches the height setting of a horizontal bar or width for a vertical bar."
	L["Max"] = "Max"
	L["Max Length"] = "Longueur max"
	L["Medium Icon"] = "Icône moyenne"
	L["Message"] = "Message"
	L["Message Prefix"] = "Préfixe du message"
	L["Message Suffix"] = "Suffixe du message"
	L["Message Type"] = "Type de message"
	L["Min"] = "Min (minutes?)"
	L["Mirror"] = "Miroir"
	L["Model"] = "Modèle"
	L["Model %s"] = "Modèle %s"
	L["Model Settings"] = "Paramètres du modèle"
	L["Move Above Group"] = "Déplacer au dessus du groupe"
	L["Move Below Group"] = "Déplacer en dessous du grouoe"
	L["Move Down"] = "Déplacer vers le bas"
	--[[Translation missing --]]
	L["Move Entry Down"] = "Move Entry Down"
	--[[Translation missing --]]
	L["Move Entry Up"] = "Move Entry Up"
	--[[Translation missing --]]
	L["Move Into Above Group"] = "Move Into Above Group"
	--[[Translation missing --]]
	L["Move Into Below Group"] = "Move Into Below Group"
	L["Move this display down in its group's order"] = "Déplacer cet affichage vers le bas dans l'ordre de son groupe"
	L["Move this display up in its group's order"] = "Déplacer cet affichage vers le haut dans l'ordre de son groupe"
	L["Move Up"] = "Déplacer vers le haut"
	L["Multiple Displays"] = "Affichages multiples"
	L["Multiselect ignored tooltip"] = [=[
|cFFFF0000Ignoré|r - |cFF777777Unique|r - |cFF777777Multiple|r
Cette option ne sera pas utilisée pour déterminer quand ce graphique doit être chargé]=]
	L["Multiselect multiple tooltip"] = [=[
|cFF777777Ignoré|r - |cFF777777Unique|r - |cFF00FF00Multiple|r
Plusieurs valeurs peuvent être choisies]=]
	L["Multiselect single tooltip"] = [=[
|cFF777777Ignoré|r - |cFF00FF00Unique|r - |cFF777777Multiple|r
Seule une unique valeur peut être choisie]=]
	L["Name Info"] = "Info du nom"
	L["Name Pattern Match"] = "Correspondance de modèle de nom"
	L["Name(s)"] = "Nom(s)"
	L["Name:"] = "Nom:"
	--[[Translation missing --]]
	L["Nameplate"] = "Nameplate"
	L["Nameplates"] = "Barres de vie"
	L["Negator"] = "Pas"
	--[[Translation missing --]]
	L["New Aura"] = "New Aura"
	L["New Value"] = "Nouvelle Valeur"
	L["No Children"] = "Pas d'Enfants"
	L["None"] = "Aucun"
	--[[Translation missing --]]
	L["Not a table"] = "Not a table"
	L["Not all children have the same value for this option"] = "Tous les enfants n'ont pas la même valeur pour cette option"
	L["Not Loaded"] = "Non chargé"
	--[[Translation missing --]]
	L["Note: Automated Messages to SAY and YELL are blocked outside of Instances."] = "Note: Automated Messages to SAY and YELL are blocked outside of Instances."
	--[[Translation missing --]]
	L["Note: The legacy buff trigger is now permanently disabled. It will be removed in the near future."] = "Note: The legacy buff trigger is now permanently disabled. It will be removed in the near future."
	--[[Translation missing --]]
	L["Number of Entries"] = "Number of Entries"
	--[[Translation missing --]]
	L["Offer a guided way to create auras for your character"] = "Offer a guided way to create auras for your character"
	--[[Translation missing --]]
	L["Offset by |cFFFF0000%s|r/|cFFFF0000%s|r"] = "Offset by |cFFFF0000%s|r/|cFFFF0000%s|r"
	--[[Translation missing --]]
	L["Offset by 1px"] = "Offset by 1px"
	L["Okay"] = "Okay"
	L["On Hide"] = "Au masquage"
	L["On Init"] = "À l'initialisation"
	L["On Show"] = "A l'affichage"
	--[[Translation missing --]]
	L["Only Match auras cast by a player (not an npc)"] = "Only Match auras cast by a player (not an npc)"
	L["Only match auras cast by people other than the player"] = "Ne considérer que les auras lancées par d'autres que le joueur"
	L["Only match auras cast by people other than the player or his pet"] = "uniquement les auras lancées par des personnes autres que le joueur ou son animal de compagnie"
	L["Only match auras cast by the player"] = "Ne considérer que les auras lancées par le joueur"
	L["Only match auras cast by the player or his pet"] = "correspond à des auras lancés uniquement par le joueur ou son animal de compagnie"
	L["Operator"] = "Opérateur"
	L["Option %i"] = "Option %i"
	L["Option key"] = "Touche d'option"
	L["Option Type"] = "Type d'option"
	L["Options will open after combat ends."] = "Les options s'ouvriront après la fin du combat."
	L["or"] = "ou"
	L["or Trigger %s"] = "ou Déclencheur %s"
	L["Orange Rune"] = "Rune orange"
	L["Orientation"] = "Orientation"
	L["Outer"] = "Extérieur"
	L["Outline"] = "Contour"
	L["Overflow"] = "Débordement"
	L["Overlay %s Info"] = "%s Infos en Superposition"
	L["Overlays"] = "Superpositions"
	L["Own Only"] = "Le mien uniquement"
	L["Paste Action Settings"] = "Coller les paramètres d'Actions"
	L["Paste Animations Settings"] = "Coller les paramètres d'Animations"
	L["Paste Author Options Settings"] = "Coller les paramètres des options de l'auteur"
	L["Paste Condition Settings"] = "Coller les paramètres de Conditions"
	L["Paste Custom Configuration"] = "Coller les Options personnalisées"
	L["Paste Display Settings"] = "Coller les paramètres d'Affichage"
	L["Paste Group Settings"] = "Coller les paramètres du Groupe"
	L["Paste Load Settings"] = "Coller les paramètres de Chargement"
	L["Paste Settings"] = "Coller Paramètres"
	L["Paste text below"] = "Coller le texte ci-dessous"
	L["Paste Trigger Settings"] = "Coller les paramètres de Déclencheurs"
	--[[Translation missing --]]
	L["Places a tick on the bar"] = "Places a tick on the bar"
	L["Play Sound"] = "Jouer un son"
	L["Portrait Zoom"] = "Zoom Portrait"
	L["Position Settings"] = "Paramètres de position"
	--[[Translation missing --]]
	L["Preferred Match"] = "Preferred Match"
	--[[Translation missing --]]
	L["Premade Snippets"] = "Premade Snippets"
	L["Preset"] = "Préréglé"
	--[[Translation missing --]]
	L["Press Ctrl+C to copy"] = "Press Ctrl+C to copy"
	--[[Translation missing --]]
	L["Press Ctrl+C to copy the URL"] = "Press Ctrl+C to copy the URL"
	--[[Translation missing --]]
	L["Prevent Merging"] = "Prevent Merging"
	L["Processed %i chars"] = "%i caractères traité "
	L["Progress Bar"] = "Barre de progression"
	L["Progress Bar Settings"] = "Paramètres de la barre de progression"
	L["Progress Texture"] = "Texture de progression"
	L["Progress Texture Settings"] = "Paramètres de la texture de progression"
	L["Purple Rune"] = "Rune violette"
	L["Put this display in a group"] = "Placer cet affichage dans un groupe"
	L["Radius"] = "Rayon"
	--[[Translation missing --]]
	L["Raid Role"] = "Raid Role"
	L["Re-center X"] = "Recentrer X"
	L["Re-center Y"] = "Recentrer Y"
	L["Regions of type \"%s\" are not supported."] = "Les régions de type \"%s\" ne sont pas prises en charge."
	L["Remaining Time"] = "Temps restant"
	L["Remove"] = "Retirer"
	L["Remove this display from its group"] = "Retirer cet affichage de son groupe"
	L["Remove this property"] = "Retirer cette propriété"
	L["Rename"] = "Renommer"
	L["Repeat After"] = "Répéter Après"
	L["Repeat every"] = "Répéter tous les"
	--[[Translation missing --]]
	L["Report bugs on our issue tracker."] = "Report bugs on our issue tracker."
	--[[Translation missing --]]
	L["Require unit from trigger"] = "Require unit from trigger"
	L["Required for Activation"] = "Requis pour l'activation"
	L["Reset all options to their default values."] = "Réinitialiser toutes les options à leurs valeurs par défaut."
	--[[Translation missing --]]
	L["Reset Entry"] = "Reset Entry"
	L["Reset to Defaults"] = "Réinitialiser les paramètres par défaut"
	L["Right"] = "Droite"
	L["Right 2 HUD position"] = "Position ATH Droite 2"
	L["Right HUD position"] = "Position ATH Droite"
	L["Right-click for more options"] = "Clic-droit pour plus d'options"
	L["Rotate"] = "Tourner"
	L["Rotate In"] = "Rotation entrante"
	L["Rotate Out"] = "Rotation sortante"
	L["Rotate Text"] = "Tourner le texte"
	L["Rotation"] = "Rotation"
	L["Rotation Mode"] = "Mode de rotation"
	--[[Translation missing --]]
	L["Row Space"] = "Row Space"
	--[[Translation missing --]]
	L["Row Width"] = "Row Width"
	L["Rows"] = "Lignes"
	L["Same"] = "Le même"
	L["Scale"] = "Échelle"
	L["Search"] = "Chrecher"
	L["Select the auras you always want to be listed first"] = "Choisissez les auras que vous voulez toujours voir apparaître en premier dans la liste"
	L["Send To"] = "Envoyer vers"
	L["Separator Text"] = "Texte Séparateur"
	L["Separator text"] = "texte séparateur"
	L["Set Parent to Anchor"] = "Définir Parent à l'Ancrage"
	L["Set Thumbnail Icon"] = "Définir la miniature"
	--[[Translation missing --]]
	L["Sets the anchored frame as the aura's parent, causing the aura to inherit attributes such as visibility and scale."] = "Sets the anchored frame as the aura's parent, causing the aura to inherit attributes such as visibility and scale."
	L["Settings"] = "Paramètres"
	--[[Translation missing --]]
	L["Shadow Color"] = "Shadow Color"
	L["Shadow X Offset"] = "Décalage X de l'ombre"
	L["Shadow Y Offset"] = "Décalage Y de l'ombre"
	L["Shift-click to create chat link"] = "Maj-clic pour créer un lien de discussion"
	L["Show all matches (Auto-clone)"] = "Montrer toutes correspondances (Auto-Clone)"
	L["Show Border"] = "Afficher l'encadrement"
	L["Show Cooldown"] = "Afficher le temps de recharge"
	L["Show Glow"] = "Surbrillance"
	L["Show Icon"] = "Afficher l'icône"
	--[[Translation missing --]]
	L["Show If Unit Does Not Exist"] = "Show If Unit Does Not Exist"
	L["Show If Unit Is Invalid"] = "Afficher Si l'Unité Est Invalide"
	--[[Translation missing --]]
	L["Show Matches for"] = "Show Matches for"
	--[[Translation missing --]]
	L["Show Matches for Units"] = "Show Matches for Units"
	--[[Translation missing --]]
	L["Show Model"] = "Show Model"
	L["Show model of unit "] = "Montrer le modèle de l'unité"
	L["Show On"] = "Afficher Sur"
	L["Show Spark"] = "Afficher l'étincelle"
	L["Show Text"] = "Afficher Texte"
	L["Show this group's children"] = "Afficher les enfants de ce groupe"
	--[[Translation missing --]]
	L["Show Tick"] = "Show Tick"
	L["Shows a 3D model from the game files"] = "Affiche un modèle 3D tiré du jeu"
	L["Shows a border"] = "Affiche un encadrement"
	L["Shows a custom texture"] = "Affiche une texture personnalisée"
	--[[Translation missing --]]
	L["Shows a glow"] = "Shows a glow"
	L["Shows a model"] = "Affiche un modèle"
	L["Shows a progress bar with name, timer, and icon"] = "Affiche une barre de progression avec nom, temps, et icône"
	L["Shows a spell icon with an optional cooldown overlay"] = "Affiche une icône de sort avec optionnellement la durée ou le temps de recharge intégré"
	--[[Translation missing --]]
	L["Shows a stop motion texture"] = "Shows a stop motion texture"
	L["Shows a texture that changes based on duration"] = "Affiche une texture qui change selon la durée"
	L["Shows one or more lines of text, which can include dynamic information such as progress or stacks"] = "Affiche une ligne de texte ou plus, qui peut inclure des infos dynamiques telles que progression ou piles."
	L["Simple"] = "Basique"
	L["Size"] = "Taille"
	--[[Translation missing --]]
	L["Skip this Version"] = "Skip this Version"
	--[[Translation missing --]]
	L["Slant Amount"] = "Slant Amount"
	--[[Translation missing --]]
	L["Slant Mode"] = "Slant Mode"
	L["Slanted"] = "Incliné"
	L["Slide"] = "Glisser"
	L["Slide In"] = "Glisser entrant"
	L["Slide Out"] = "Glisser sortant"
	--[[Translation missing --]]
	L["Slider Step Size"] = "Slider Step Size"
	L["Small Icon"] = "Petite icône"
	L["Smooth Progress"] = "Progrès Doux"
	--[[Translation missing --]]
	L["Snippets"] = "Snippets"
	--[[Translation missing --]]
	L["Soft Max"] = "Soft Max"
	--[[Translation missing --]]
	L["Soft Min"] = "Soft Min"
	L["Sort"] = "Trier"
	L["Sound"] = "Son"
	L["Sound Channel"] = "Canal sonore"
	L["Sound File Path"] = "Chemin fichier son"
	L["Sound Kit ID"] = "ID Kit Son"
	L["Source"] = "Source"
	L["Space"] = "Espacer"
	L["Space Horizontally"] = "Espacer horizontalement"
	L["Space Vertically"] = "Espacer verticalement"
	L["Spark"] = "Étincelle"
	L["Spark Settings"] = "Paramètres de l'étincelle"
	L["Spark Texture"] = "Texture Étincelle"
	L["Specific Unit"] = "Unité spécifique"
	L["Spell ID"] = "ID de sort"
	L["Stack Count"] = "Nombre de Piles"
	L["Stack Info"] = "Info de Piles"
	L["Stagger"] = "Report"
	L["Star"] = "Étoile"
	L["Start"] = "Début"
	L["Start Angle"] = "Angle de départ"
	--[[Translation missing --]]
	L["Start Collapsed"] = "Start Collapsed"
	--[[Translation missing --]]
	L["Start of %s"] = "Start of %s"
	L["Stealable"] = "Volable"
	--[[Translation missing --]]
	L["Step Size"] = "Step Size"
	L["Stop ignoring Updates"] = "Arrêtez d'ignorer les mises à jour"
	--[[Translation missing --]]
	L["Stop Motion"] = "Stop Motion"
	--[[Translation missing --]]
	L["Stop Motion Settings"] = "Stop Motion Settings"
	L["Stop Sound"] = "Arrêter Son"
	--[[Translation missing --]]
	L["Sub Elements"] = "Sub Elements"
	--[[Translation missing --]]
	L["Sub Option %i"] = "Sub Option %i"
	L["Temporary Group"] = "Groupe temporaire"
	L["Text"] = "Texte"
	L["Text %s"] = "Texte %s"
	L["Text Color"] = "Couleur Texte"
	L["Text Settings"] = "Paramètres du texte"
	L["Texture"] = "Texture"
	L["Texture Info"] = "Info Texture"
	L["Texture Settings"] = "Paramètres de la texture"
	L["Texture Wrap"] = "Enveloppe de texture"
	L["The duration of the animation in seconds."] = "La durée de l'animation en secondes."
	L["The duration of the animation in seconds. The finish animation does not start playing until after the display would normally be hidden."] = "La durée de l'animation en secondes. L'animation de fin ne commence qu'après le moment où l'affichage est normalement caché."
	L["The type of trigger"] = "Le type de déclencheur"
	L["Then "] = "Alors"
	L["Thickness"] = "Épaisseur"
	L["This adds %tooltip, %tooltip1, %tooltip2, %tooltip3 as text replacements."] = "Cela ajoute %infobulle, %infobulle1, %infobulle2, %infobulle3 en remplacement du texte."
	L["This display is currently loaded"] = "Cet affichage est actuellement chargé"
	L["This display is not currently loaded"] = "Cet affichage n'est pas chargé"
	L["This region of type \"%s\" is not supported."] = "Cette région de type \"%s\" n'est pas supportée."
	L["This setting controls what widget is generated in user mode."] = "Ce paramètre contrôle le widget généré en mode utilisateur."
	L["Tick %s"] = "Coche %s"
	--[[Translation missing --]]
	L["Tick Mode"] = "Tick Mode"
	--[[Translation missing --]]
	L["Tick Placement"] = "Tick Placement"
	L["Time in"] = "Temps entrant"
	L["Tiny Icon"] = "Très petite icône"
	L["To Frame's"] = "Au cadre de"
	--[[Translation missing --]]
	L["To Group's"] = "To Group's"
	L["To Personal Ressource Display's"] = "À ... du cadre des Res. Perso"
	L["To Screen's"] = "À ... de l'écran"
	L["Toggle the visibility of all loaded displays"] = "Change la visibilité de tous les affichages chargés"
	L["Toggle the visibility of all non-loaded displays"] = "Change la visibilité de tous les affichages non-chargés"
	L["Toggle the visibility of this display"] = "Activer/Désactiver la visibilité de cet affichage"
	L["Tooltip"] = "Infobulle"
	L["Tooltip Content"] = "Contenu de l'info-bulle"
	L["Tooltip on Mouseover"] = "Infobulle à la souris"
	L["Tooltip Pattern Match"] = "Correspondance de modèle de l'info-bulle"
	L["Tooltip Text"] = "Texte de l'Info-bulle."
	L["Tooltip Value"] = "Valeur de l'info-bulle"
	L["Tooltip Value #"] = "Valeur de l'info-bulle #"
	L["Top"] = "Haut"
	L["Top HUD position"] = "Position ATH Haute"
	L["Top Left"] = "Haut gauche"
	L["Top Right"] = "Haut droite"
	--[[Translation missing --]]
	L["Total Angle"] = "Total Angle"
	--[[Translation missing --]]
	L["Total Time"] = "Total Time"
	L["Trigger"] = "Déclencheur"
	L["Trigger %d"] = "Déclencheur %d"
	L["Trigger %s"] = "Déclencheur %s"
	--[[Translation missing --]]
	L["Trigger Combination"] = "Trigger Combination"
	L["True"] = "Vrai"
	L["Type"] = "Type"
	--[[Translation missing --]]
	L["Type 'select' for '%s' requires a values member'"] = "Type 'select' for '%s' requires a values member'"
	L["Ungroup"] = "Dissocier"
	L["Unit"] = "Unité"
	--[[Translation missing --]]
	L["Unit %s is not a valid unit for RegisterUnitEvent"] = "Unit %s is not a valid unit for RegisterUnitEvent"
	L["Unit Count"] = "Nombre d'unité"
	--[[Translation missing --]]
	L["Unit Frame"] = "Unit Frame"
	L["Unit Frames"] = "Cadre d'unité"
	--[[Translation missing --]]
	L["Unit Name Filter"] = "Unit Name Filter"
	--[[Translation missing --]]
	L["UnitName Filter"] = "UnitName Filter"
	--[[Translation missing --]]
	L["Unknown property '%s' found in '%s'"] = "Unknown property '%s' found in '%s'"
	L["Unlike the start or finish animations, the main animation will loop over and over until the display is hidden."] = "Contrairement aux animations de début et de fin, l'animation principale bouclera tant que l'affichage est visible."
	--[[Translation missing --]]
	L["Update %s by %s"] = "Update %s by %s"
	--[[Translation missing --]]
	L["Update Auras"] = "Update Auras"
	L["Update Custom Text On..."] = "Mettre à jour le texte personnalisé sur..."
	L["Update in Group"] = "Mettre à jour dans le Groupe"
	L["Update this Aura"] = "Mettre à jour cette Aura"
	L["URL"] = "URL"
	--[[Translation missing --]]
	L["Use Custom Color"] = "Use Custom Color"
	L["Use Display Info Id"] = "Utiliser les informations d'identifiant de l'affichage"
	L["Use Full Scan (High CPU)"] = "Utiliser Scan Complet (CPU élevé)"
	L["Use nth value from tooltip:"] = "Utilisez la nième valeur de l'info-bulle:"
	L["Use SetTransform"] = "Utiliser SetTransform"
	--[[Translation missing --]]
	L["Use Texture"] = "Use Texture"
	L["Use tooltip \"size\" instead of stacks"] = "Utiliser la \"taille\" de l'infobulle plutôt que la pile"
	L["Use Tooltip Information"] = "Utiliser l'information de la boite de dialogue"
	L["Used in Auras:"] = "Utilisé(e) dans les Auras:"
	L["Used in auras:"] = "Utilisé dans les auras:"
	--[[Translation missing --]]
	L["Uses UnitIsVisible() to check if in range. This is polled every second."] = "Uses UnitIsVisible() to check if in range. This is polled every second."
	L["Value %i"] = "Valeur %i"
	L["Values are in normalized rgba format."] = "Les valeurs sont normalisées dans le format rvba"
	L["Values:"] = "Valeurs:"
	L["Version: "] = "Version: "
	L["Vertical Align"] = "Aligner verticalement"
	L["Vertical Bar"] = "Barre verticale"
	L["View"] = "Vue"
	--[[Translation missing --]]
	L["Wago Update"] = "Wago Update"
	--[[Translation missing --]]
	L["Whole Area"] = "Whole Area"
	L["Width"] = "Largeur"
	--[[Translation missing --]]
	L["wrapping"] = "wrapping"
	L["X Offset"] = "Décalage X"
	L["X Rotation"] = "Rotation X"
	L["X Scale"] = "Echelle X"
	L["X-Offset"] = "Décalage X"
	--[[Translation missing --]]
	L["x-Offset"] = "x-Offset"
	L["Y Offset"] = "Décalage Y"
	L["Y Rotation"] = "Rotation Y"
	L["Y Scale"] = "Echelle Y"
	L["Yellow Rune"] = "Rune jaune"
	L["Y-Offset"] = "Décalage Y"
	--[[Translation missing --]]
	L["y-Offset"] = "y-Offset"
	L["You are about to delete %d aura(s). |cFFFF0000This cannot be undone!|r Would you like to continue?"] = "Vous êtes sur le point de supprimer %d aura(s). |cFFFF0000Cela ne peut pas être annulé !|r Voulez-vous continuer ?"
	--[[Translation missing --]]
	L["You are about to delete a trigger. |cFFFF0000This cannot be undone!|r Would you like to continue?"] = "You are about to delete a trigger. |cFFFF0000This cannot be undone!|r Would you like to continue?"
	--[[Translation missing --]]
	L["Your Saved Snippets"] = "Your Saved Snippets"
	L["Z Offset"] = "Décalage Z"
	L["Z Rotation"] = "Rotation Z"
	L["Zoom"] = "Zoom"
	L["Zoom In"] = "Zoom entrant"
	L["Zoom Out"] = "Zoom sortant"

