if not WeakAuras.IsCorrectVersion() then return end

if not(GetLocale() == "deDE") then
  return
end

local L = WeakAuras.L

-- WeakAuras/Options
	L["-- Do not remove this comment, it is part of this trigger: "] = "-- Entferne diesen Kommentar nicht, er ist Teil dieses Auslösers: "
	L["% of Progress"] = "Fortschritt in %"
	L["%i auras selected"] = "%i Auren ausgew\\195\\164hlt"
	L["%i Matches"] = "%i Treffer"
	--[[Translation missing --]]
	L["%s - Option #%i has the key %s. Please choose a different option key."] = "%s - Option #%i has the key %s. Please choose a different option key."
	--[[Translation missing --]]
	L["%s %s, Lines: %d, Frequency: %0.2f, Length: %d, Thickness: %d"] = "%s %s, Lines: %d, Frequency: %0.2f, Length: %d, Thickness: %d"
	--[[Translation missing --]]
	L["%s %s, Particles: %d, Frequency: %0.2f, Scale: %0.2f"] = "%s %s, Particles: %d, Frequency: %0.2f, Scale: %0.2f"
	--[[Translation missing --]]
	L["%s Alpha: %d%%"] = "%s Alpha: %d%%"
	L["%s Color"] = "%s Farbe"
	--[[Translation missing --]]
	L["%s Default Alpha, Zoom, Icon Inset, Aspect Ratio"] = "%s Default Alpha, Zoom, Icon Inset, Aspect Ratio"
	--[[Translation missing --]]
	L["%s Inset: %d%%"] = "%s Inset: %d%%"
	--[[Translation missing --]]
	L["%s is not a valid SubEvent for COMBAT_LOG_EVENT_UNFILTERED"] = "%s is not a valid SubEvent for COMBAT_LOG_EVENT_UNFILTERED"
	--[[Translation missing --]]
	L["%s Keep Aspect Ratio"] = "%s Keep Aspect Ratio"
	L["%s total auras"] = "%s gesamte Auren"
	--[[Translation missing --]]
	L["%s Zoom: %d%%"] = "%s Zoom: %d%%"
	--[[Translation missing --]]
	L["%s, Border"] = "%s, Border"
	--[[Translation missing --]]
	L["%s, Offset: %0.2f;%0.2f"] = "%s, Offset: %0.2f;%0.2f"
	--[[Translation missing --]]
	L["%s, offset: %0.2f;%0.2f"] = "%s, offset: %0.2f;%0.2f"
	--[[Translation missing --]]
	L["|c%02x%02x%02x%02xCustom Color|r"] = "|c%02x%02x%02x%02xCustom Color|r"
	--[[Translation missing --]]
	L["|cFFFF0000Note:|r The unit '%s' is not a trackable unit."] = "|cFFFF0000Note:|r The unit '%s' is not a trackable unit."
	--[[Translation missing --]]
	L["|cFFffcc00Anchors:|r Anchored |cFFFF0000%s|r to frame's |cFFFF0000%s|r"] = "|cFFffcc00Anchors:|r Anchored |cFFFF0000%s|r to frame's |cFFFF0000%s|r"
	--[[Translation missing --]]
	L["|cFFffcc00Anchors:|r Anchored |cFFFF0000%s|r to frame's |cFFFF0000%s|r with offset |cFFFF0000%s/%s|r"] = "|cFFffcc00Anchors:|r Anchored |cFFFF0000%s|r to frame's |cFFFF0000%s|r with offset |cFFFF0000%s/%s|r"
	--[[Translation missing --]]
	L["|cFFffcc00Anchors:|r Anchored to frame's |cFFFF0000%s|r"] = "|cFFffcc00Anchors:|r Anchored to frame's |cFFFF0000%s|r"
	--[[Translation missing --]]
	L["|cFFffcc00Anchors:|r Anchored to frame's |cFFFF0000%s|r with offset |cFFFF0000%s/%s|r"] = "|cFFffcc00Anchors:|r Anchored to frame's |cFFFF0000%s|r with offset |cFFFF0000%s/%s|r"
	--[[Translation missing --]]
	L["|cFFffcc00Extra Options:|r"] = "|cFFffcc00Extra Options:|r"
	--[[Translation missing --]]
	L["|cFFffcc00Font Flags:|r |cFFFF0000%s|r and shadow |c%sColor|r with offset |cFFFF0000%s/%s|r%s%s%s"] = "|cFFffcc00Font Flags:|r |cFFFF0000%s|r and shadow |c%sColor|r with offset |cFFFF0000%s/%s|r%s%s%s"
	L["1 Match"] = "1 Treffer"
	L["A 20x20 pixels icon"] = "Ein Symbol mit 20x20 Pixeln"
	L["A 32x32 pixels icon"] = "Ein Symbol mit 32x32 Pixeln"
	L["A 40x40 pixels icon"] = "Ein Symbol mit 40x40 Pixeln"
	L["A 48x48 pixels icon"] = "Ein Symbol mit 48x48 Pixeln"
	L["A 64x64 pixels icon"] = "Ein Symbol mit 64x64 Pixeln"
	L["A group that dynamically controls the positioning of its children"] = "Eine Gruppe, die dynamisch die Position ihrer Kinder steuert"
	--[[Translation missing --]]
	L["A Unit ID (e.g., party1)."] = "A Unit ID (e.g., party1)."
	L["Actions"] = "Aktionen"
	--[[Translation missing --]]
	L["Add %s"] = "Add %s"
	L["Add a new display"] = "Neue Anzeige hinzufügen"
	L["Add Condition"] = "Neue Bedingung"
	--[[Translation missing --]]
	L["Add Entry"] = "Add Entry"
	--[[Translation missing --]]
	L["Add Extra Elements"] = "Add Extra Elements"
	--[[Translation missing --]]
	L["Add Option"] = "Add Option"
	--[[Translation missing --]]
	L["Add Overlay"] = "Add Overlay"
	L["Add Property Change"] = "Weitere Änderung"
	--[[Translation missing --]]
	L["Add Sub Option"] = "Add Sub Option"
	L["Add to group %s"] = "Zu Gruppe %s hinzufügen"
	L["Add to new Dynamic Group"] = "Neue dynamische Gruppe hinzufügen"
	L["Add to new Group"] = "Neue Gruppe hinzufügen"
	L["Add Trigger"] = "Auslöser hinzufügen"
	L["Addon"] = "Addon"
	L["Addons"] = "Addons"
	--[[Translation missing --]]
	L["Advanced"] = "Advanced"
	L["Align"] = "Ausrichtung"
	--[[Translation missing --]]
	L["Alignment"] = "Alignment"
	--[[Translation missing --]]
	L["All of"] = "All of"
	L["Allow Full Rotation"] = "Erlaubt eine vollständige Rotation"
	L["Alpha"] = "Transparenz"
	L["Anchor"] = "Anker"
	L["Anchor Point"] = "Ankerpunkt"
	L["Anchored To"] = "Angeheftet an"
	L["And "] = "Und"
	--[[Translation missing --]]
	L["and aligned left"] = "and aligned left"
	--[[Translation missing --]]
	L["and aligned right"] = "and aligned right"
	--[[Translation missing --]]
	L["and rotated left"] = "and rotated left"
	--[[Translation missing --]]
	L["and rotated right"] = "and rotated right"
	--[[Translation missing --]]
	L["and Trigger %s"] = "and Trigger %s"
	--[[Translation missing --]]
	L["and with width |cFFFF0000%s|r and %s"] = "and with width |cFFFF0000%s|r and %s"
	L["Angle"] = "Winkel"
	L["Animate"] = "Animieren"
	L["Animated Expand and Collapse"] = "Erweitern und Verbergen animieren"
	--[[Translation missing --]]
	L["Animates progress changes"] = "Animates progress changes"
	L["Animation relative duration description"] = [=[Die Dauer der Animation relativ zur Dauer der Anzeige als Bruchteil (1/2), als Prozent (50%) oder als Dezimal (0.5).
|cFFFF0000Notiz:|r Falls die Anzeige keine Dauer besitzt (zb. Aura ohne Dauer), wird diese Animation nicht ausgeführt.

|cFF4444FFFBeispiel:|r
Falls die Dauer der Animation auf |cFF00CC0010%|r gesetzt wurde und die Dauer der Anzeige 20 Sekunden beträgt (zb. Debuff), dann wird diese Animation über eine Dauer von 2 Sekunden abgespielt.
Falls die Dauer der Animation auf |cFF00CC0010%|r gesetzt wurde und für die Anzeige keine Dauer bekannt ist (Meistens kann diese auch manuell festgelegt werden), wird diese Animation nicht abgespielt.]=]
	L["Animation Sequence"] = "Animationssequenz"
	L["Animations"] = "Animationen"
	--[[Translation missing --]]
	L["Any of"] = "Any of"
	L["Apply Template"] = "Vorlage übernehmen"
	--[[Translation missing --]]
	L["Arc Length"] = "Arc Length"
	L["Arcane Orb"] = "Arkane Kugel"
	--[[Translation missing --]]
	L["At a position a bit left of Left HUD position."] = "At a position a bit left of Left HUD position."
	--[[Translation missing --]]
	L["At a position a bit left of Right HUD position"] = "At a position a bit left of Right HUD position"
	L["At the same position as Blizzard's spell alert"] = "An der Position von Blizzards Zauberwarnmeldung"
	L["Aura Name"] = "Auraname"
	--[[Translation missing --]]
	L["Aura Name Pattern"] = "Aura Name Pattern"
	L["Aura Type"] = "Auratyp"
	L["Aura(s)"] = "Auren"
	--[[Translation missing --]]
	L["Author Options"] = "Author Options"
	L["Auto"] = "Auto"
	--[[Translation missing --]]
	L["Auto-Clone (Show All Matches)"] = "Auto-Clone (Show All Matches)"
	L["Auto-cloning enabled"] = "Auto-Klonen deaktiviert"
	--[[Translation missing --]]
	L["Automatic"] = "Automatic"
	L["Automatic Icon"] = "Automatisches Symbol"
	L["Backdrop Color"] = "Hintergrundfarbe"
	--[[Translation missing --]]
	L["Backdrop in Front"] = "Backdrop in Front"
	L["Backdrop Style"] = "Hintergrundstil"
	L["Background Color"] = "Hintergrundfarbe"
	L["Background Offset"] = "Hintergrundversatz"
	L["Background Texture"] = "Hintergrundtextur"
	--[[Translation missing --]]
	L["Bar"] = "Bar"
	L["Bar Alpha"] = "Balkentransparenz"
	L["Bar Color"] = "Balkenfarbe"
	L["Bar Color Settings"] = "Balkenfarbeneinstellungen"
	--[[Translation missing --]]
	L["Bar Inner"] = "Bar Inner"
	L["Bar Texture"] = "Balkentextur"
	L["Big Icon"] = "Großes Symbol"
	--[[Translation missing --]]
	L["Blacklisted Aura Name"] = "Blacklisted Aura Name"
	--[[Translation missing --]]
	L["Blacklisted Exact Spell ID(s)"] = "Blacklisted Exact Spell ID(s)"
	--[[Translation missing --]]
	L["Blacklisted Name(s)"] = "Blacklisted Name(s)"
	--[[Translation missing --]]
	L["Blacklisted Spell ID"] = "Blacklisted Spell ID"
	L["Blend Mode"] = "Blendmodus"
	L["Blue Rune"] = "Blaue Rune"
	L["Blue Sparkle Orb"] = "Blau funkelnde Kugel"
	L["Border"] = "Rand"
	--[[Translation missing --]]
	L["Border %s"] = "Border %s"
	--[[Translation missing --]]
	L["Border Anchor"] = "Border Anchor"
	L["Border Color"] = "Randfarbe"
	--[[Translation missing --]]
	L["Border in Front"] = "Border in Front"
	L["Border Inset"] = "Rahmeneinlassung"
	L["Border Offset"] = "Randversatz"
	L["Border Settings"] = "Rahmeneinstellungen"
	L["Border Size"] = "Rahmengröße"
	L["Border Style"] = "Rahmenstil"
	--[[Translation missing --]]
	L["Bottom"] = "Bottom"
	--[[Translation missing --]]
	L["Bottom Left"] = "Bottom Left"
	--[[Translation missing --]]
	L["Bottom Right"] = "Bottom Right"
	--[[Translation missing --]]
	L["Bracket Matching"] = "Bracket Matching"
	--[[Translation missing --]]
	L["Can be a Name or a Unit ID (e.g. party1). A name only works on friendly players in your group."] = "Can be a Name or a Unit ID (e.g. party1). A name only works on friendly players in your group."
	--[[Translation missing --]]
	L["Can be a UID (e.g., party1)."] = "Can be a UID (e.g., party1)."
	L["Cancel"] = "Abbrechen"
	--[[Translation missing --]]
	L["Center"] = "Center"
	L["Channel Number"] = "Kanalnummer"
	L["Chat Message"] = "Chatnachricht"
	L["Check On..."] = "Prüfen auf..."
	L["Children:"] = "Kinder:"
	L["Choose"] = "Auswählen"
	L["Choose Trigger"] = "Auslöser Auswählen"
	L["Choose whether the displayed icon is automatic or defined manually"] = "Symbol automatisch oder manuell auswählen"
	--[[Translation missing --]]
	L["Class"] = "Class"
	--[[Translation missing --]]
	L["Clip Overlays"] = "Clip Overlays"
	--[[Translation missing --]]
	L["Clipped by Progress"] = "Clipped by Progress"
	L["Clone option enabled dialog"] = [=[
Eine Option, die |cFFFF0000Auto-Klonen|r verwendet, wurde aktiviert.

|cFFFF0000Auto-Klonen|r dupliziert automatisch eine Anzeige, um mehrere passende Quellen (z.B. Auren) darzustellen.
Solange die Anzeige sich nicht in einer |cFF22AA22Dynamischen Gruppe|r befindet, werden alle Klone nur hintereinander angeordnet.

Soll die Anzeige in einer neuen |cFF22AA22Dynamischen Gruppe|r platziert werden?]=]
	L["Close"] = "Schließen"
	L["Collapse"] = "Minimieren"
	L["Collapse all loaded displays"] = "Alle geladenen Anzeigen minimieren"
	L["Collapse all non-loaded displays"] = "Alle nicht geladenen Anzeigen minimieren"
	--[[Translation missing --]]
	L["Collapsible Group"] = "Collapsible Group"
	L["color"] = "Farbe"
	L["Color"] = "Farbe"
	--[[Translation missing --]]
	L["Column Height"] = "Column Height"
	--[[Translation missing --]]
	L["Column Space"] = "Column Space"
	--[[Translation missing --]]
	L["Combinations"] = "Combinations"
	--[[Translation missing --]]
	L["Combine Matches Per Unit"] = "Combine Matches Per Unit"
	--[[Translation missing --]]
	L["Common Text"] = "Common Text"
	--[[Translation missing --]]
	L["Compare against the number of units affected."] = "Compare against the number of units affected."
	L["Compress"] = "Stauchen"
	L["Condition %i"] = "Bedingung %i"
	L["Conditions"] = "Bedingungen"
	--[[Translation missing --]]
	L["Configure what options appear on this panel."] = "Configure what options appear on this panel."
	L["Constant Factor"] = "Konstanter Faktor"
	L["Control-click to select multiple displays"] = "Strg-Klick, um mehrere Anzeigen auszuwählen"
	L["Controls the positioning and configuration of multiple displays at the same time"] = "Eine Gruppe, die die Position und Konfiguration ihrer Kinder kontrolliert"
	--[[Translation missing --]]
	L["Convert to New Aura Trigger"] = "Convert to New Aura Trigger"
	L["Convert to..."] = "Konvertieren zu..."
	--[[Translation missing --]]
	L["Cooldown Edge"] = "Cooldown Edge"
	--[[Translation missing --]]
	L["Cooldown Settings"] = "Cooldown Settings"
	--[[Translation missing --]]
	L["Cooldown Swipe"] = "Cooldown Swipe"
	--[[Translation missing --]]
	L["Copy"] = "Copy"
	L["Copy settings..."] = "Einstellungen kopieren..."
	L["Copy to all auras"] = "Kopiere zu allen Auren"
	L["Copy URL"] = "URL kopieren"
	L["Count"] = "Anzahl"
	--[[Translation missing --]]
	L["Counts the number of matches over all units."] = "Counts the number of matches over all units."
	L["Creating buttons: "] = "Erstelle Schaltflächen:"
	L["Creating options: "] = "Erstelle Optionen:"
	L["Crop X"] = "Abschneiden (X)"
	L["Crop Y"] = "Abschneiden (Y)"
	L["Custom"] = "Benutzerdefiniert"
	--[[Translation missing --]]
	L["Custom Anchor"] = "Custom Anchor"
	L["Custom Code"] = "Benutzerdefinierter Code"
	--[[Translation missing --]]
	L["Custom Color"] = "Custom Color"
	--[[Translation missing --]]
	L["Custom Configuration"] = "Custom Configuration"
	--[[Translation missing --]]
	L["Custom Frames"] = "Custom Frames"
	L["Custom Function"] = "Benutzerdefiniert"
	--[[Translation missing --]]
	L["Custom Grow"] = "Custom Grow"
	--[[Translation missing --]]
	L["Custom Options"] = "Custom Options"
	--[[Translation missing --]]
	L["Custom Sort"] = "Custom Sort"
	L["Custom Trigger"] = "Benutzerdefinierter Auslöser"
	L["Custom trigger event tooltip"] = [=[Wähle die Ereignisse, die den benutzerdefinierten Auslöser aufrufen sollen.
Mehrere Ereignisse können durch Komma oder Leerzeichen getrennt werden.

|cFF4444FFBeispiel:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED]=]
	L["Custom trigger status tooltip"] = [=[Wähle die Events, die den benutzerdefinierten Auslöser aufrufen sollen.
Da es sich um einen Zustands-Auslöser handelt, kann es passieren, dass WeakAuras nicht die in der WoW-API spezifizierten Argumente übergibt.
Mehrere Events können durch Komma oder Leerzeichen getrennt werden.

|cFF4444FFBeispiel:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED]=]
	L["Custom Untrigger"] = "Benutzerdefinierter Umkehrauslöser"
	--[[Translation missing --]]
	L["Custom Variables"] = "Custom Variables"
	L["Debuff Type"] = "Debufftyp"
	L["Default"] = "Standard"
	--[[Translation missing --]]
	L["Default Color"] = "Default Color"
	L["Delete"] = "Löschen"
	L["Delete all"] = "Alle löschen"
	L["Delete children and group"] = "Kinder und Gruppe löschen"
	--[[Translation missing --]]
	L["Delete Entry"] = "Delete Entry"
	L["Delete Trigger"] = "Auslöser löschen"
	L["Desaturate"] = "Entsättigen"
	--[[Translation missing --]]
	L["Description Text"] = "Description Text"
	--[[Translation missing --]]
	L["Determines how many entries can be in the table."] = "Determines how many entries can be in the table."
	L["Differences"] = "Unterschiede"
	L["Disabled"] = "Deaktiviert"
	--[[Translation missing --]]
	L["Disallow Entry Reordering"] = "Disallow Entry Reordering"
	L["Discrete Rotation"] = "Rotation um x90°"
	L["Display"] = "Anzeige"
	L["Display Icon"] = "Anzeigesymbol"
	--[[Translation missing --]]
	L["Display Name"] = "Display Name"
	L["Display Text"] = "Anzeigetext"
	L["Displays a text, works best in combination with other displays"] = "Zeigt einen Text an, funktioniert am besten in Kombination mit anderen Anzeigen"
	L["Distribute Horizontally"] = "Horizontal verteilen"
	L["Distribute Vertically"] = "Vertikal verteilen"
	L["Do not group this display"] = "Diese Anzeige nicht kopieren"
	L["Done"] = "Fertig"
	--[[Translation missing --]]
	L["Don't skip this Version"] = "Don't skip this Version"
	--[[Translation missing --]]
	L["Down"] = "Down"
	L["Drag to move"] = "Ziehen, um diese Anzeige zu verschieben"
	L["Duplicate"] = "Duplizieren"
	--[[Translation missing --]]
	L["Duplicate All"] = "Duplicate All"
	L["Duration (s)"] = "Dauer (s)"
	L["Duration Info"] = "Dauerinformationen"
	--[[Translation missing --]]
	L["Dynamic Duration"] = "Dynamic Duration"
	L["Dynamic Group"] = "Dynamische Gruppe"
	--[[Translation missing --]]
	L["Dynamic Group Settings"] = "Dynamic Group Settings"
	L["Dynamic Information"] = "Dynamische Information"
	L["Dynamic information from first active trigger"] = "Dynamische Information vom ersten aktiven Auslöser"
	L["Dynamic information from Trigger %i"] = "Dynamische Information des %i. Auslösers"
	L["Dynamic text tooltip"] = [=[Es werden einige spezielle Codes für dynamischen Text angeboten:

|cFFFF0000%p|r - Fortschritt - Die verbleibende Dauer der Anzeige
|cFFFF0000%t|r - Gesamt - Die maximale Dauer der Anzeige
|cFFFF0000%n|r - Name - Der (dynamische) Name der Anzeige (zb. Auraname) oder die ID der Anzeige
|cFFFF0000%i|r - Symbol - Das (dynamische) Symbol der Anzeige
|cFFFF0000%s|r - Stapel - Die Anzahl der Stapel
|cFFFF0000%c|r - Benutzerdefiniert - Verwendet den String-Rückgabewert der benutzerdefinierten Lua-Funktion]=]
	--[[Translation missing --]]
	L["Ease Strength"] = "Ease Strength"
	--[[Translation missing --]]
	L["Ease type"] = "Ease type"
	--[[Translation missing --]]
	L["Edge"] = "Edge"
	--[[Translation missing --]]
	L["eliding"] = "eliding"
	L["Enabled"] = "Aktivieren"
	L["End Angle"] = "Endewinkel"
	--[[Translation missing --]]
	L["End of %s"] = "End of %s"
	--[[Translation missing --]]
	L["Enter a Spell ID"] = "Enter a Spell ID"
	L["Enter an aura name, partial aura name, or spell id"] = "Auraname, Teilname oder Zauber-ID"
	--[[Translation missing --]]
	L["Enter an Aura Name, partial Aura Name, or Spell ID. A Spell ID will match any spells with the same name."] = "Enter an Aura Name, partial Aura Name, or Spell ID. A Spell ID will match any spells with the same name."
	--[[Translation missing --]]
	L["Enter Author Mode"] = "Enter Author Mode"
	--[[Translation missing --]]
	L["Enter User Mode"] = "Enter User Mode"
	--[[Translation missing --]]
	L["Enter user mode."] = "Enter user mode."
	--[[Translation missing --]]
	L["Entry %i"] = "Entry %i"
	--[[Translation missing --]]
	L["Entry limit"] = "Entry limit"
	--[[Translation missing --]]
	L["Entry Name Source"] = "Entry Name Source"
	L["Event"] = "Ereignis"
	L["Event Type"] = "Ereignistyp"
	L["Event(s)"] = "Ereignis(se)"
	L["Everything"] = "Alles"
	--[[Translation missing --]]
	L["Exact Spell ID(s)"] = "Exact Spell ID(s)"
	--[[Translation missing --]]
	L["Exact Spell Match"] = "Exact Spell Match"
	L["Expand"] = "Erweitern"
	L["Expand all loaded displays"] = "Alle geladenen Anzeigen erweitern"
	L["Expand all non-loaded displays"] = "Alle nicht geladenen Anzeigen erweitern"
	L["Expansion is disabled because this group has no children"] = "Erweiterung deaktiviert, da diese Gruppe keine Kinder hat"
	L["Export to Lua table..."] = "Als Lua-Tabelle exportieren.."
	L["Export to string..."] = "Als Zeichenkette exportieren.."
	--[[Translation missing --]]
	L["External"] = "External"
	L["Fade"] = "Verblassen"
	L["Fade In"] = "Einblenden"
	L["Fade Out"] = "Ausblenden"
	L["False"] = "Falsch"
	--[[Translation missing --]]
	L["Fetch Affected/Unaffected Names"] = "Fetch Affected/Unaffected Names"
	--[[Translation missing --]]
	L["Filter by Class"] = "Filter by Class"
	--[[Translation missing --]]
	L["Filter by Group Role"] = "Filter by Group Role"
	L["Finish"] = "Endanimation"
	L["Fire Orb"] = "Feuerkugel"
	L["Font"] = "Schriftart"
	L["Font Size"] = "Schriftgröße"
	--[[Translation missing --]]
	L["Foreground"] = "Foreground"
	L["Foreground Color"] = "Vordergrundfarbe"
	L["Foreground Texture"] = "Vordergrundtextur"
	L["Frame"] = "Frame"
	--[[Translation missing --]]
	L["Frame Selector"] = "Frame Selector"
	L["Frame Strata"] = "Frame-Schicht"
	--[[Translation missing --]]
	L["Frequency"] = "Frequency"
	L["From Template"] = "Vorlage verwenden"
	--[[Translation missing --]]
	L["From version %s to version %s"] = "From version %s to version %s"
	L["Global Conditions"] = "Globale Bedingungen"
	--[[Translation missing --]]
	L["Glow %s"] = "Glow %s"
	L["Glow Action"] = "Leuchtaktion"
	--[[Translation missing --]]
	L["Glow Anchor"] = "Glow Anchor"
	--[[Translation missing --]]
	L["Glow Color"] = "Glow Color"
	--[[Translation missing --]]
	L["Glow External Element"] = "Glow External Element"
	--[[Translation missing --]]
	L["Glow Frame Type"] = "Glow Frame Type"
	--[[Translation missing --]]
	L["Glow Type"] = "Glow Type"
	L["Green Rune"] = "Grüne Rune"
	--[[Translation missing --]]
	L["Grid direction"] = "Grid direction"
	L["Group"] = "Gruppe"
	L["Group (verb)"] = "Gruppieren"
	L["Group aura count description"] = [=[Die Anzahl der %s-Mitglieder, die von einer der Auren betroffen sein müssen, um den Trigger auszulösen.
Falls der eingegebene Wert eine ganze Zahl (z.B. 5) ist, wird die Anzahl der betroffenen Gruppenmitglieder damit verglichen.
Falls die Zahl als Dezimalzahl (z.B. 0.5), Bruch (z.B. 1/2) oder Prozentsatz (z.B. 50%%) eingegeben wird, muss dieser Teil der %s betroffen sein.

|cFF4444FBeispiel:|r
|cFF00CC00> 0|r Löst aus, wenn irgendjemand in der %s betroffen ist.
|cFF00CC00= 100%%|r Löst aus, wenn alle in der %s betroffen sind.
|cFF00CC00!= 2|r Löst aus, wenn weniger oder mehr als 2 Spieler in der %s betroffen sind.
|cFF00CC00<= 0.8|r Löst aus, wenn weniger als 80%% in der %s betroffen sind (4 von 5 Gruppenmitgliedern, 8 von 10 oder 20 von 25 Schlachtzugsmitgliedern).
|cFF00CC00> 1/2|r Löst aus, wenn mehr als die Hälfte der %s betroffen sind.
|cFF00CC00>= 0|r Löst immer aus.]=]
	--[[Translation missing --]]
	L["Group by Frame"] = "Group by Frame"
	--[[Translation missing --]]
	L["Group contains updates from Wago"] = "Group contains updates from Wago"
	--[[Translation missing --]]
	L["Group Icon"] = "Group Icon"
	--[[Translation missing --]]
	L["Group key"] = "Group key"
	L["Group Member Count"] = "Anzahl der Gruppenmitglieder"
	--[[Translation missing --]]
	L["Group Role"] = "Group Role"
	--[[Translation missing --]]
	L["Group Scale"] = "Group Scale"
	--[[Translation missing --]]
	L["Group Settings"] = "Group Settings"
	--[[Translation missing --]]
	L["Group Type"] = "Group Type"
	--[[Translation missing --]]
	L["Grow"] = "Grow"
	L["Hawk"] = "Falke"
	L["Height"] = "Höhe"
	--[[Translation missing --]]
	L["Help"] = "Help"
	L["Hide"] = "Verbergen"
	--[[Translation missing --]]
	L["Hide Cooldown Text"] = "Hide Cooldown Text"
	--[[Translation missing --]]
	L["Hide Glows applied by this aura"] = "Hide Glows applied by this aura"
	L["Hide on"] = "Verbergen falls"
	L["Hide this group's children"] = "Die Kinder dieser Gruppe ausblenden"
	L["Hide When Not In Group"] = "Ausblenden, wenn ich gruppenlos bin"
	L["Horizontal Align"] = "Horizontale Ausrichtung"
	L["Horizontal Bar"] = "Horizontaler Balken"
	L["Huge Icon"] = "Riesiges Symbol"
	--[[Translation missing --]]
	L["Hybrid Position"] = "Hybrid Position"
	--[[Translation missing --]]
	L["Hybrid Sort Mode"] = "Hybrid Sort Mode"
	L["Icon"] = "Symbol"
	L["Icon Info"] = "Symbolinfo"
	L["Icon Inset"] = "Symboleinrückung"
	--[[Translation missing --]]
	L["Icon Position"] = "Icon Position"
	--[[Translation missing --]]
	L["Icon Settings"] = "Icon Settings"
	L["If"] = "Falls"
	--[[Translation missing --]]
	L["If checked, then the user will see a multi line edit box. This is useful for inputting large amounts of text."] = "If checked, then the user will see a multi line edit box. This is useful for inputting large amounts of text."
	--[[Translation missing --]]
	L["If checked, then this option group can be temporarily collapsed by the user."] = "If checked, then this option group can be temporarily collapsed by the user."
	--[[Translation missing --]]
	L["If checked, then this option group will start collapsed."] = "If checked, then this option group will start collapsed."
	--[[Translation missing --]]
	L["If checked, then this separator will include text. Otherwise, it will be just a horizontal line."] = "If checked, then this separator will include text. Otherwise, it will be just a horizontal line."
	--[[Translation missing --]]
	L["If checked, then this separator will not merge with other separators when selecting multiple auras."] = "If checked, then this separator will not merge with other separators when selecting multiple auras."
	--[[Translation missing --]]
	L["If checked, then this space will span across multiple lines."] = "If checked, then this space will span across multiple lines."
	L["If Trigger %s"] = "Falls Auslöser %s"
	--[[Translation missing --]]
	L["If unchecked, then a default color will be used (usually yellow)"] = "If unchecked, then a default color will be used (usually yellow)"
	--[[Translation missing --]]
	L["If unchecked, then this space will fill the entire line it is on in User Mode."] = "If unchecked, then this space will fill the entire line it is on in User Mode."
	--[[Translation missing --]]
	L["Ignore all Updates"] = "Ignore all Updates"
	--[[Translation missing --]]
	L["Ignore Self"] = "Ignore Self"
	--[[Translation missing --]]
	L["Ignore self"] = "Ignore self"
	L["Ignored"] = "Ignoriert"
	L["Import"] = "Importieren"
	L["Import a display from an encoded string"] = "Anzeige von Klartext importieren"
	--[[Translation missing --]]
	L["Inner"] = "Inner"
	--[[Translation missing --]]
	L["Invalid Item Name/ID/Link"] = "Invalid Item Name/ID/Link"
	--[[Translation missing --]]
	L["Invalid Spell ID"] = "Invalid Spell ID"
	--[[Translation missing --]]
	L["Invalid Spell Name/ID/Link"] = "Invalid Spell Name/ID/Link"
	L["Inverse"] = "Invertiert"
	--[[Translation missing --]]
	L["Inverse Slant"] = "Inverse Slant"
	--[[Translation missing --]]
	L["Is Stealable"] = "Is Stealable"
	L["Justify"] = "Ausrichten"
	--[[Translation missing --]]
	L["Keep Aspect Ratio"] = "Keep Aspect Ratio"
	--[[Translation missing --]]
	L["Large Input"] = "Large Input"
	L["Leaf"] = "Blatt"
	--[[Translation missing --]]
	L["Left"] = "Left"
	--[[Translation missing --]]
	L["Left 2 HUD position"] = "Left 2 HUD position"
	L["Left HUD position"] = "Linke HUD Position"
	--[[Translation missing --]]
	L["Legacy Aura Trigger"] = "Legacy Aura Trigger"
	--[[Translation missing --]]
	L["Length"] = "Length"
	--[[Translation missing --]]
	L["Limit"] = "Limit"
	--[[Translation missing --]]
	L["Lines & Particles"] = "Lines & Particles"
	L["Load"] = "Laden"
	L["Loaded"] = "Geladen"
	L["Loop"] = "Schleife"
	L["Low Mana"] = "Niedriges Mana"
	--[[Translation missing --]]
	L["Magnetically Align"] = "Magnetically Align"
	L["Main"] = "Hauptanimation"
	L["Manage displays defined by Addons"] = "Bearbeite Anzeigen von externen Addons"
	--[[Translation missing --]]
	L["Match Count"] = "Match Count"
	--[[Translation missing --]]
	L["Max"] = "Max"
	--[[Translation missing --]]
	L["Max Length"] = "Max Length"
	L["Medium Icon"] = "Mittelgroßes Symbol"
	L["Message"] = "Nachricht"
	L["Message Prefix"] = "Nachrichtenprefix"
	L["Message Suffix"] = "Nachrichtensuffix"
	L["Message Type"] = "Nachrichtentyp"
	--[[Translation missing --]]
	L["Min"] = "Min"
	L["Mirror"] = "Spiegeln"
	L["Model"] = "Modell"
	--[[Translation missing --]]
	L["Model %s"] = "Model %s"
	--[[Translation missing --]]
	L["Model Settings"] = "Model Settings"
	--[[Translation missing --]]
	L["Move Above Group"] = "Move Above Group"
	--[[Translation missing --]]
	L["Move Below Group"] = "Move Below Group"
	L["Move Down"] = "Nach unten verschieben"
	--[[Translation missing --]]
	L["Move Entry Down"] = "Move Entry Down"
	--[[Translation missing --]]
	L["Move Entry Up"] = "Move Entry Up"
	--[[Translation missing --]]
	L["Move Into Above Group"] = "Move Into Above Group"
	--[[Translation missing --]]
	L["Move Into Below Group"] = "Move Into Below Group"
	L["Move this display down in its group's order"] = "Verschiebt diese Anzeige in der Reihenfolge seiner Gruppe nach unten"
	L["Move this display up in its group's order"] = "Verschiebt diese Anzeige in der Reihenfolge seiner Gruppe nach oben"
	L["Move Up"] = "Nach oben verschieben"
	L["Multiple Displays"] = "Mehrere Anzeigen"
	L["Multiple Triggers"] = "Mehrere Auslöser"
	L["Multiselect ignored tooltip"] = [=[
|cFFFF0000Ignoriert|r - |cFF777777Einfach|r - |cFF777777Mehrfach|r
Diese Option wird nicht verwendet, um zu prüfen, wann die Anzeige geladen wird.]=]
	L["Multiselect multiple tooltip"] = [=[
|cFFFF0000Ignoriert|r - |cFF777777Einfach|r - |cFF777777Mehrfach|r
Beliebige Anzahl an Werten zum Vergleichen können ausgewählt werden.]=]
	L["Multiselect single tooltip"] = [=[
|cFFFF0000Ignoriert|r - |cFF777777Einfach|r - |cFF777777Mehrfach|r
Nur ein Wert kann ausgewählt werden.]=]
	L["Name Info"] = "Namensinfo"
	--[[Translation missing --]]
	L["Name Pattern Match"] = "Name Pattern Match"
	--[[Translation missing --]]
	L["Name(s)"] = "Name(s)"
	L["Negator"] = "Nicht"
	L["Never"] = "Nie"
	--[[Translation missing --]]
	L["New Aura"] = "New Aura"
	--[[Translation missing --]]
	L["New Value"] = "New Value"
	L["No"] = "Nein"
	L["No Children"] = "Keine Kinder"
	L["No tooltip text"] = "Kein Tooltip"
	L["None"] = "Keinen"
	L["Not all children have the same value for this option"] = "Nicht alle Kinder besitzen denselben Wert"
	L["Not Loaded"] = "Nicht geladen"
	--[[Translation missing --]]
	L["Note: Automated Messages to SAY and YELL are blocked outside of Instances."] = "Note: Automated Messages to SAY and YELL are blocked outside of Instances."
	--[[Translation missing --]]
	L["Number of Entries"] = "Number of Entries"
	--[[Translation missing --]]
	L["Offer a guided way to create auras for your character"] = "Offer a guided way to create auras for your character"
	L["Okay"] = "Okey"
	L["On Hide"] = "Beim Ausblenden"
	L["On Init"] = "Beim Initialisieren"
	L["On Show"] = "Beim Einblenden"
	L["Only match auras cast by people other than the player"] = "Nur Auren von anderen Spielern"
	--[[Translation missing --]]
	L["Only match auras cast by people other than the player or his pet"] = "Only match auras cast by people other than the player or his pet"
	L["Only match auras cast by the player"] = "Nur Auren vom Spieler selbst"
	--[[Translation missing --]]
	L["Only match auras cast by the player or his pet"] = "Only match auras cast by the player or his pet"
	L["Operator"] = "Operator"
	--[[Translation missing --]]
	L["Option %i"] = "Option %i"
	--[[Translation missing --]]
	L["Option key"] = "Option key"
	--[[Translation missing --]]
	L["Option Type"] = "Option Type"
	--[[Translation missing --]]
	L["Options will open after combat ends."] = "Options will open after combat ends."
	L["or"] = "oder"
	--[[Translation missing --]]
	L["or Trigger %s"] = "or Trigger %s"
	L["Orange Rune"] = "Orange Rune"
	L["Orientation"] = "Orientierung"
	--[[Translation missing --]]
	L["Outer"] = "Outer"
	L["Outline"] = "Umriss"
	--[[Translation missing --]]
	L["Overflow"] = "Overflow"
	--[[Translation missing --]]
	L["Overlay %s Info"] = "Overlay %s Info"
	--[[Translation missing --]]
	L["Overlays"] = "Overlays"
	L["Own Only"] = "Nur eigene"
	--[[Translation missing --]]
	L["Paste Action Settings"] = "Paste Action Settings"
	--[[Translation missing --]]
	L["Paste Animations Settings"] = "Paste Animations Settings"
	--[[Translation missing --]]
	L["Paste Author Options Settings"] = "Paste Author Options Settings"
	--[[Translation missing --]]
	L["Paste Condition Settings"] = "Paste Condition Settings"
	--[[Translation missing --]]
	L["Paste Custom Configuration"] = "Paste Custom Configuration"
	--[[Translation missing --]]
	L["Paste Display Settings"] = "Paste Display Settings"
	--[[Translation missing --]]
	L["Paste Group Settings"] = "Paste Group Settings"
	--[[Translation missing --]]
	L["Paste Load Settings"] = "Paste Load Settings"
	--[[Translation missing --]]
	L["Paste Settings"] = "Paste Settings"
	L["Paste text below"] = "Text unten einfügen"
	--[[Translation missing --]]
	L["Paste Trigger Settings"] = "Paste Trigger Settings"
	L["Play Sound"] = "Sound abspielen"
	L["Position Settings"] = "Positionsbedingte Einstellungen"
	--[[Translation missing --]]
	L["Preferred Match"] = "Preferred Match"
	L["Preset"] = "Voreinstellung"
	--[[Translation missing --]]
	L["Press Ctrl+C to copy"] = "Press Ctrl+C to copy"
	--[[Translation missing --]]
	L["Prevent Merging"] = "Prevent Merging"
	--[[Translation missing --]]
	L["Processed %i chars"] = "Processed %i chars"
	L["Progress Bar"] = "Fortschrittsbalken"
	--[[Translation missing --]]
	L["Progress Bar Settings"] = "Progress Bar Settings"
	L["Progress Texture"] = "Fortschrittstextur"
	--[[Translation missing --]]
	L["Progress Texture Settings"] = "Progress Texture Settings"
	L["Purple Rune"] = "Violette Rune"
	L["Put this display in a group"] = "Diese Anzeige in eine Gruppe stecken"
	L["Radius"] = "Radius"
	L["Re-center X"] = "Zentrum (X)"
	L["Re-center Y"] = "Zentrum (Y)"
	--[[Translation missing --]]
	L["Regions of type \"%s\" are not supported."] = "Regions of type \"%s\" are not supported."
	L["Remaining Time"] = "Verbleibende Zeit"
	L["Remaining Time Precision"] = "Genauigkeit der Restzeit"
	L["Remove"] = "Entfernen"
	L["Remove this display from its group"] = "Diese Anzeige aus seiner Gruppe entfernen"
	L["Remove this property"] = "Eigenschaft entfernen"
	L["Rename"] = "Umbenennen"
	L["Repeat After"] = "Wiederholen nach"
	L["Repeat every"] = "Wiederhole alle"
	--[[Translation missing --]]
	L["Require unit from trigger"] = "Require unit from trigger"
	L["Required for Activation"] = "Benötigt zur Aktivierung"
	--[[Translation missing --]]
	L["Reset all options to their default values."] = "Reset all options to their default values."
	--[[Translation missing --]]
	L["Reset Entry"] = "Reset Entry"
	--[[Translation missing --]]
	L["Reset to Defaults"] = "Reset to Defaults"
	--[[Translation missing --]]
	L["Right"] = "Right"
	--[[Translation missing --]]
	L["Right 2 HUD position"] = "Right 2 HUD position"
	L["Right HUD position"] = "Rechte HUD Position"
	L["Right-click for more options"] = "|cFF8080FF(Rechtsklick)|r für mehr Optionen"
	L["Rotate"] = "Rotieren"
	L["Rotate In"] = "Nach innen rotieren"
	L["Rotate Out"] = "Nach außen rotieren"
	L["Rotate Text"] = "Text rotieren"
	L["Rotation"] = "Rotation"
	L["Rotation Mode"] = "Rotationsmodus"
	--[[Translation missing --]]
	L["Row Space"] = "Row Space"
	--[[Translation missing --]]
	L["Row Width"] = "Row Width"
	L["Same"] = "Gleich"
	L["Scale"] = "Skalierung"
	L["Search"] = "Suchen"
	L["Select the auras you always want to be listed first"] = "Wähle die Auren aus, die immer an oberster Stelle angezeigt werden sollen"
	L["Send To"] = "Senden an"
	--[[Translation missing --]]
	L["Separator Text"] = "Separator Text"
	--[[Translation missing --]]
	L["Separator text"] = "Separator text"
	--[[Translation missing --]]
	L["Set Parent to Anchor"] = "Set Parent to Anchor"
	--[[Translation missing --]]
	L["Set Thumbnail Icon"] = "Set Thumbnail Icon"
	L["Set tooltip description"] = "Tooltipbeschreibung festlegen"
	--[[Translation missing --]]
	L["Sets the anchored frame as the aura's parent, causing the aura to inherit attributes such as visiblility and scale."] = "Sets the anchored frame as the aura's parent, causing the aura to inherit attributes such as visiblility and scale."
	L["Settings"] = "Einstellungen"
	--[[Translation missing --]]
	L["Shadow Color"] = "Shadow Color"
	--[[Translation missing --]]
	L["Shadow X Offset"] = "Shadow X Offset"
	--[[Translation missing --]]
	L["Shadow Y Offset"] = "Shadow Y Offset"
	L["Shift-click to create chat link"] = "Shift-Klick, um einen Chatlink zu erstellen"
	L["Show all matches (Auto-clone)"] = "Alle Treffer anzeigen (Auto-Klonen)"
	--[[Translation missing --]]
	L["Show Border"] = "Show Border"
	--[[Translation missing --]]
	L["Show Cooldown"] = "Show Cooldown"
	--[[Translation missing --]]
	L["Show Glow"] = "Show Glow"
	--[[Translation missing --]]
	L["Show Icon"] = "Show Icon"
	--[[Translation missing --]]
	L["Show If Unit Does Not Exist"] = "Show If Unit Does Not Exist"
	L["Show If Unit Is Invalid"] = "Einblenden falls Einheit ungültig"
	--[[Translation missing --]]
	L["Show Matches for"] = "Show Matches for"
	--[[Translation missing --]]
	L["Show Matches for Units"] = "Show Matches for Units"
	--[[Translation missing --]]
	L["Show Model"] = "Show Model"
	L["Show model of unit "] = "Modell der Einheit zeigen"
	L["Show On"] = "Einblenden wenn"
	--[[Translation missing --]]
	L["Show Spark"] = "Show Spark"
	--[[Translation missing --]]
	L["Show Text"] = "Show Text"
	L["Show this group's children"] = "Die Kinder dieser Gruppe anzeigen"
	L["Shows a 3D model from the game files"] = "Zeigt ein 3D-Modell aus den Spieldateien"
	--[[Translation missing --]]
	L["Shows a border"] = "Shows a border"
	L["Shows a custom texture"] = "Zeigt eine benutzerdefinierte Textur"
	--[[Translation missing --]]
	L["Shows a glow"] = "Shows a glow"
	--[[Translation missing --]]
	L["Shows a model"] = "Shows a model"
	L["Shows a progress bar with name, timer, and icon"] = "Zeigt einen Fortschrittsbalken mit Name, Zeitanzeige und Symbol"
	L["Shows a spell icon with an optional cooldown overlay"] = "Zeigt ein Zaubersymbol mit optionaler Abklingzeit-Anzeige."
	L["Shows a texture that changes based on duration"] = "Zeigt eine Textur, die sich über die Zeit verändert"
	L["Shows one or more lines of text, which can include dynamic information such as progress or stacks"] = "Zeigt ein oder mehrere Zeilen Text an, der dynamische Informationen anzeigen kann, z.B. Fortschritt oder Stapel"
	--[[Translation missing --]]
	L["Simple"] = "Simple"
	L["Size"] = "Größe"
	--[[Translation missing --]]
	L["Skip this Version"] = "Skip this Version"
	--[[Translation missing --]]
	L["Slant Amount"] = "Slant Amount"
	--[[Translation missing --]]
	L["Slant Mode"] = "Slant Mode"
	--[[Translation missing --]]
	L["Slanted"] = "Slanted"
	L["Slide"] = "Gleiten"
	L["Slide In"] = "Einschieben"
	L["Slide Out"] = "Ausschieben"
	--[[Translation missing --]]
	L["Slider Step Size"] = "Slider Step Size"
	L["Small Icon"] = "Kleines Symbol"
	--[[Translation missing --]]
	L["Smooth Progress"] = "Smooth Progress"
	--[[Translation missing --]]
	L["Soft Max"] = "Soft Max"
	--[[Translation missing --]]
	L["Soft Min"] = "Soft Min"
	L["Sort"] = "Sortieren"
	L["Sound"] = "Sound"
	L["Sound Channel"] = "Soundkanal"
	L["Sound File Path"] = "Sound Dateipfad"
	L["Sound Kit ID"] = "Sound Kit ID"
	L["Space"] = "Abstand"
	L["Space Horizontally"] = "Horizontaler Abstand"
	L["Space Vertically"] = "Vertikaler Abstand"
	L["Spark"] = "Funken"
	L["Spark Settings"] = "Funkeneinstellungen"
	L["Spark Texture"] = "Funkentextur"
	L["Specific Unit"] = "Spezifische Einheit"
	L["Spell ID"] = "Zauber-ID"
	L["Stack Count"] = "Stapelanzahl"
	L["Stack Info"] = "Stapelinfo"
	L["Stagger"] = "Taumeln"
	L["Star"] = "Stern"
	L["Start"] = "Start"
	L["Start Angle"] = "Startwinkel"
	--[[Translation missing --]]
	L["Start Collapsed"] = "Start Collapsed"
	--[[Translation missing --]]
	L["Start of %s"] = "Start of %s"
	L["Status"] = "Status"
	L["Stealable"] = "stehlbare Aura"
	--[[Translation missing --]]
	L["Step Size"] = "Step Size"
	--[[Translation missing --]]
	L["Stop ignoring Updates"] = "Stop ignoring Updates"
	L["Stop Sound"] = "Sound stoppen"
	--[[Translation missing --]]
	L["Sub Elements"] = "Sub Elements"
	--[[Translation missing --]]
	L["Sub Option %i"] = "Sub Option %i"
	L["Temporary Group"] = "Temporäre Gruppe"
	L["Text"] = "Text"
	--[[Translation missing --]]
	L["Text %s"] = "Text %s"
	L["Text Color"] = "Textfarbe"
	--[[Translation missing --]]
	L["Text Settings"] = "Text Settings"
	L["Texture"] = "Textur"
	L["Texture Info"] = "Texturinfo"
	--[[Translation missing --]]
	L["Texture Settings"] = "Texture Settings"
	--[[Translation missing --]]
	L["Texture Wrap"] = "Texture Wrap"
	L["The duration of the animation in seconds."] = "Die Dauer der Animation in Sekunden."
	L["The duration of the animation in seconds. The finish animation does not start playing until after the display would normally be hidden."] = "Die Dauer der Animation in Sekunden. Die Endanimation erscheint erst zum Zeitpunkt des Ausblendens."
	L["The type of trigger"] = "Auslösertyp"
	L["Then "] = "Dann"
	--[[Translation missing --]]
	L["Thickness"] = "Thickness"
	--[[Translation missing --]]
	L["This adds %tooltip, %tooltip1, %tooltip2, %tooltip3 as text replacements."] = "This adds %tooltip, %tooltip1, %tooltip2, %tooltip3 as text replacements."
	--[[Translation missing --]]
	L["This aura has legacy aura trigger(s). Convert them to the new system to benefit from enhanced performance and features"] = "This aura has legacy aura trigger(s). Convert them to the new system to benefit from enhanced performance and features"
	L["This display is currently loaded"] = "Diese Anzeige ist momentan geladen"
	L["This display is not currently loaded"] = "Diese Anzeige ist momentan nicht geladen"
	L["This region of type \"%s\" is not supported."] = "Diese Region des Typs \"%s\" wird nicht unterstützt."
	--[[Translation missing --]]
	L["This setting controls what widget is generated in user mode."] = "This setting controls what widget is generated in user mode."
	L["Time in"] = "Zeit in"
	L["Tiny Icon"] = "Winziges Symbol"
	--[[Translation missing --]]
	L["To Frame's"] = "To Frame's"
	--[[Translation missing --]]
	L["To Group's"] = "To Group's"
	--[[Translation missing --]]
	L["To Personal Ressource Display's"] = "To Personal Ressource Display's"
	--[[Translation missing --]]
	L["To Screen's"] = "To Screen's"
	L["Toggle the visibility of all loaded displays"] = "Sichtbarkeit aller geladener Anzeigen umschalten"
	L["Toggle the visibility of all non-loaded displays"] = "Sichtbarkeit aller nicht geladener Anzeigen umschalten"
	L["Toggle the visibility of this display"] = "Die Sichtbarkeit dieser Anzeige umschalten"
	L["Tooltip"] = "Tooltip"
	--[[Translation missing --]]
	L["Tooltip Content"] = "Tooltip Content"
	L["Tooltip on Mouseover"] = "Tooltip bei Mausberührung"
	--[[Translation missing --]]
	L["Tooltip Pattern Match"] = "Tooltip Pattern Match"
	--[[Translation missing --]]
	L["Tooltip Text"] = "Tooltip Text"
	--[[Translation missing --]]
	L["Tooltip Value"] = "Tooltip Value"
	--[[Translation missing --]]
	L["Tooltip Value #"] = "Tooltip Value #"
	--[[Translation missing --]]
	L["Top"] = "Top"
	L["Top HUD position"] = "Höchste HUD Position"
	--[[Translation missing --]]
	L["Top Left"] = "Top Left"
	--[[Translation missing --]]
	L["Top Right"] = "Top Right"
	--[[Translation missing --]]
	L["Total Time"] = "Total Time"
	L["Total Time Precision"] = "Genauigkeit der Gesamtzeit"
	L["Trigger"] = "Auslöser"
	L["Trigger %d"] = "Auslöser %d"
	--[[Translation missing --]]
	L["Trigger %s"] = "Trigger %s"
	L["True"] = "Wahr"
	L["Type"] = "Typ"
	L["Ungroup"] = "Gruppierung aufheben"
	L["Unit"] = "Einheit"
	--[[Translation missing --]]
	L["Unit %s is not a valid unit for RegisterUnitEvent"] = "Unit %s is not a valid unit for RegisterUnitEvent"
	--[[Translation missing --]]
	L["Unit Count"] = "Unit Count"
	--[[Translation missing --]]
	L["Unit Frame"] = "Unit Frame"
	--[[Translation missing --]]
	L["Unit Frames"] = "Unit Frames"
	L["Unlike the start or finish animations, the main animation will loop over and over until the display is hidden."] = "Anders als die Start- und Endanimation wird die Hauptanimation immer wieder wiederholt, bis die Anzeige in den Endstatus versetzt wird."
	--[[Translation missing --]]
	L["Up"] = "Up"
	--[[Translation missing --]]
	L["Update %s by %s"] = "Update %s by %s"
	L["Update Custom Text On..."] = "Aktualisiere benutzerdefinierten Text bei..."
	--[[Translation missing --]]
	L["Update in Group"] = "Update in Group"
	--[[Translation missing --]]
	L["Update this Aura"] = "Update this Aura"
	--[[Translation missing --]]
	L["Use Custom Color"] = "Use Custom Color"
	--[[Translation missing --]]
	L["Use Display Info Id"] = "Use Display Info Id"
	L["Use Full Scan (High CPU)"] = "Alle Auren scannen (CPU-Intensiv)"
	--[[Translation missing --]]
	L["Use nth value from tooltip:"] = "Use nth value from tooltip:"
	--[[Translation missing --]]
	L["Use SetTransform"] = "Use SetTransform"
	L["Use tooltip \"size\" instead of stacks"] = "Tooltipgröße anstatt Stapel verwenden"
	--[[Translation missing --]]
	L["Use Tooltip Information"] = "Use Tooltip Information"
	--[[Translation missing --]]
	L["Used in Auras:"] = "Used in Auras:"
	--[[Translation missing --]]
	L["Used in auras:"] = "Used in auras:"
	--[[Translation missing --]]
	L["Value %i"] = "Value %i"
	--[[Translation missing --]]
	L["Values are in normalized rgba format."] = "Values are in normalized rgba format."
	--[[Translation missing --]]
	L["Values:"] = "Values:"
	--[[Translation missing --]]
	L["Version: "] = "Version: "
	L["Vertical Align"] = "Vertikale Ausrichtung"
	L["Vertical Bar"] = "Vertikaler Balken"
	--[[Translation missing --]]
	L["View"] = "View"
	--[[Translation missing --]]
	L["Wago Update"] = "Wago Update"
	--[[Translation missing --]]
	L["Whole Area"] = "Whole Area"
	L["Width"] = "Breite"
	--[[Translation missing --]]
	L["wrapping"] = "wrapping"
	L["X Offset"] = "X-Versatz"
	L["X Rotation"] = "X-Rotation"
	L["X Scale"] = "Skalierung (X)"
	--[[Translation missing --]]
	L["X-Offset"] = "X-Offset"
	L["Y Offset"] = "Y-Versatz"
	L["Y Rotation"] = "Y-Rotation"
	L["Y Scale"] = "Skalierung (Y)"
	L["Yellow Rune"] = "Gelbe Rune"
	L["Yes"] = "Ja"
	--[[Translation missing --]]
	L["Y-Offset"] = "Y-Offset"
	L["You are about to delete %d aura(s). |cFFFF0000This cannot be undone!|r Would you like to continue?"] = "Du bist im Begriff %d Aura/Auren zu löschen. |cFFFF0000Das Löschen kann nicht rückgängig gemacht werden!|r Willst du fortfahren?"
	L["Z Offset"] = "Z-Versatz"
	L["Z Rotation"] = "Z-Rotation"
	L["Zoom"] = "Zoom"
	L["Zoom In"] = "Einzoomen"
	L["Zoom Out"] = "Auszoomen"


