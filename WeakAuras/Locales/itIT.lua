if not(GetLocale() == "itIT") then
  return
end

local L = WeakAuras.L

-- WeakAuras
L["   • %d auras added"] = "   • %d aure aggiunte"
L["   • %d auras deleted"] = " • %d aure cancellate"
L["   • %d auras modified"] = "• %d aure modificate"
L[ [=[ Filter formats: 'Name', 'Name-Realm', '-Realm'. 

Supports multiple entries, separated by commas
]=] ] = [=[Formattazione filtro: 'Nome', 'Nome-Reame', '-Reame'.
 Supporta scelte multiple, separate dalla virgola]=]
L[ [=[

Supports multiple entries, separated by commas]=] ] = " Supporta scelte multiple, separate dalla virgola"
L["%s - %i. Trigger"] = "%s - %i. Innesco"
L["%s - Alpha Animation"] = "%s - Animazione  Alpha"
L["%s - Color Animation"] = "%s - Animazione Colore"
L["%s - Condition Custom Chat"] = "%s - Condizioni Chat Personalizzata"
L["%s - Custom Text"] = "%s - Testo Personalizzato"
L["%s - Finish"] = "%s - Fine"
L["%s - Finish Action"] = "%s - Azione Finale"
L["%s - Finish Custom Text"] = "%s - Testo Personalizzato Finale"
L["%s - Init Action"] = "%s - Azione Iniziale"
L["%s - Main"] = "%s - Principale"
L["%s - Rotate Animation"] = "%s - Animazione di Rotazione"
L["%s - Scale Animation"] = "%s - Animazione di Ridimensionamento"
L["%s - Start"] = "%s - Inizio"
L["%s - Start Action"] = "%s - Azione Iniziale"
L["%s - Start Custom Text"] = "%s - Testo Personalizzato Iniziale"
L["%s - Translate Animation"] = "%s - Animazione di Traslazione"
L["%s - Trigger Logic"] = "%s - Logica dell'innesco"
L["%s Duration Function"] = "%s Durata della Funzione"
L["%s Icon Function"] = "%s Icona della Funzione"
L["%s Name Function"] = "%s Name della Funzione"
L["%s Overlay Color"] = "%s Colore Overlay"
--[[Translation missing --]]
L["%s Stacks Function"] = "%s Stacks Function"
L["%s Texture Function"] = "%s Funzione di Texture"
L["%s total auras"] = "%s aure totali"
L["%s Trigger Function"] = "%s Funzione di Innesco"
L["%s Untrigger Function"] = "%s Funzione di Disinnesco"
L["* Suffix"] = "* Suffisso"
L["/wa help - Show this message"] = "/wa help - Mostra questo messaggio"
L["/wa minimap - Toggle the minimap icon"] = "/wa minimap - Mostra/Nascondi l'icona della minimappa"
L["/wa pprint - Show the results from the most recent profiling"] = "/wa pprint - Mostra i risultati del più recente profiling"
L["/wa pstart - Start profiling. Optionally include a duration in seconds after which profiling automatically stops. To profile the next combat/encounter, pass a \"combat\" or \"encounter\" argument."] = "/wa pstart - Inizia il profiling. Si può includere una durata in secondi dopo la quale il profiling termina automaticamente. Per profilare il prossimo combattimento, passare un argomento ''combat'' o ''encounter''."
L["/wa pstop - Finish profiling"] = "/wa pstop - Termina il profiling"
--[[Translation missing --]]
L["/wa repair - Repair tool"] = "/wa repair - Repair tool"
L["|cffeda55fLeft-Click|r to toggle showing the main window."] = "|cffeda55fClick Sinistro|r per mostrare/nascondere la finestra principale."
L["|cffeda55fMiddle-Click|r to toggle the minimap icon on or off."] = "|cffeda55fClick Centrale|r per mostrare/nascondere l'icona della minimappa."
--[[Translation missing --]]
L["|cffeda55fRight-Click|r to toggle performance profiling window."] = "|cffeda55fRight-Click|r to toggle performance profiling window."
L["|cffeda55fShift-Click|r to pause addon execution."] = "|cffeda55fShift Click|r per mettere in pausa l'addon."
--[[Translation missing --]]
L["|cFFFF0000Not|r Item Bonus Id Equipped"] = "|cFFFF0000Not|r Item Bonus Id Equipped"
--[[Translation missing --]]
L["|cFFFF0000Not|r Player Name/Realm"] = "|cFFFF0000Not|r Player Name/Realm"
--[[Translation missing --]]
L["|cFFffcc00Extra Options:|r %s"] = "|cFFffcc00Extra Options:|r %s"
--[[Translation missing --]]
L["|cFFffcc00Extra Options:|r None"] = "|cFFffcc00Extra Options:|r None"
L["10 Man Raid"] = "Incursione da 10 giocatori"
--[[Translation missing --]]
L["10 Player Raid (Heroic)"] = "10 Player Raid (Heroic)"
--[[Translation missing --]]
L["10 Player Raid (Normal)"] = "10 Player Raid (Normal)"
L["20 Man Raid"] = "incursione da 20 giocatori"
L["25 Man Raid"] = "Incursione da 25 giocatori"
--[[Translation missing --]]
L["25 Player Raid (Heroic)"] = "25 Player Raid (Heroic)"
--[[Translation missing --]]
L["25 Player Raid (Normal)"] = "25 Player Raid (Normal)"
L["40 Man Raid"] = "incursione da 40 giocatori"
--[[Translation missing --]]
L["40 Player Raid"] = "40 Player Raid"
L["5 Man Dungeon"] = "Spedizione da 5 giocatori"
L["Abbreviate"] = "Abbreviare"
--[[Translation missing --]]
L["AbbreviateLargeNumbers (Blizzard)"] = "AbbreviateLargeNumbers (Blizzard)"
--[[Translation missing --]]
L["AbbreviateNumbers (Blizzard)"] = "AbbreviateNumbers (Blizzard)"
L["Absorb"] = "Assorbimento"
L["Absorb Display"] = "Mostra Assorbimento"
L["Absorbed"] = "Assorbito"
L["Action Button Glow"] = "Bagliore Pulsante Azioni"
L["Action Usable"] = "Azione utilizzabile"
L["Actions"] = "Azioni"
L["Active"] = "Attivo"
L["Add"] = "Aggiungi"
L["Add Missing Auras"] = "Aggiungi Aure Mancanti"
L["Additional Trigger Replacements"] = "Ulteriori Sostituzioni di Innesco"
L["Affected"] = "Affetto"
L["Affected Unit Count"] = "Conta Unità Interessate"
L["Aggro"] = "Aggro"
L["Agility"] = "Agilità"
L["Ahn'Qiraj"] = "Ahn'Qiraj"
L["Alert Type"] = "Tipo di Allerta"
L["Alive"] = "Vivo"
L["All"] = "Tutto"
L["All Triggers"] = "Tutte le attivazioni"
L["Alliance"] = "Alleanza"
L["Allow partial matches"] = "Permetti corrispondenze parziali"
L["Alpha"] = "Alfa"
L["Alternate Power"] = "Risorse Speciali"
L["Always"] = "Sempre"
L["Always active trigger"] = "Innesco sempre attivo"
L["Always include realm"] = "Includi sempre il reame"
L["Always True"] = "Sempre Vero"
L["Amount"] = "Quantità"
--[[Translation missing --]]
L["And Talent"] = "And Talent"
L["Animations"] = "Animazioni"
L["Anticlockwise"] = "Antiorario"
--[[Translation missing --]]
L["Anub'Rekhan"] = "Anub'Rekhan"
L["Any"] = "Qualsiasi"
L["Any Triggers"] = "Qualsiasi attivazione"
--[[Translation missing --]]
L["AOE"] = "AOE"
L["Arcane Resistance"] = "Resistenza Arcana"
L["Arena"] = "Arena"
L["Armor (%)"] = "Armatura (%)"
--[[Translation missing --]]
L["Armor against Target (%)"] = "Armor against Target (%)"
--[[Translation missing --]]
L["Armor Rating"] = "Armor Rating"
--[[Translation missing --]]
L["Array"] = "Array"
L["Ascending"] = "Crescente"
--[[Translation missing --]]
L["Assigned Role"] = "Assigned Role"
L["At Least One Enemy"] = "Almeno un nemico"
--[[Translation missing --]]
L["At missing Value"] = "At missing Value"
--[[Translation missing --]]
L["At Percent"] = "At Percent"
--[[Translation missing --]]
L["At Value"] = "At Value"
L["Attach to End"] = "Aggiungi alla Fine"
L["Attach to Start"] = "Aggiungi all'inizio"
--[[Translation missing --]]
L["Attack Power"] = "Attack Power"
L["Attackable"] = "Attaccabile"
L["Attackable Target"] = "Bersaglio attaccabile"
L["Aura"] = "Aura"
--[[Translation missing --]]
L["Aura '%s': %s"] = "Aura '%s': %s"
L["Aura Applied"] = "Aura applicata"
L["Aura Applied Dose"] = "Parte di aura applicata"
L["Aura Broken"] = "Aura finita"
L["Aura Broken Spell"] = "Aura di magia finita"
L["Aura Name"] = "Nome Aura"
L["Aura Names"] = "Nomi Aura"
L["Aura Refresh"] = "Aura rinnovata"
L["Aura Removed"] = "Aura rimossa"
L["Aura Removed Dose"] = "Parte di aura rimossa"
L["Aura Stack"] = "Aura Stack"
L["Aura Type"] = "Tipo di aura"
L["Aura(s) Found"] = "Aura(e) Trovata(e)"
L["Aura(s) Missing"] = "Aura(e) Mancante(i)"
L["Aura:"] = "Aura:"
L["Auras:"] = "Aure:"
L["Author Options"] = "Opzioni Autore"
--[[Translation missing --]]
L["Auto"] = "Auto"
--[[Translation missing --]]
L["Autocast Shine"] = "Autocast Shine"
L["Automatic"] = "Automatico"
--[[Translation missing --]]
L["Automatic Length"] = "Automatic Length"
--[[Translation missing --]]
L["Automatic Repair Confirmation Dialog"] = "Automatic Repair Confirmation Dialog"
L["Automatic Rotation"] = "Rotazione Automatica"
--[[Translation missing --]]
L["Avoidance (%)"] = "Avoidance (%)"
--[[Translation missing --]]
L["Avoidance Rating"] = "Avoidance Rating"
--[[Translation missing --]]
L["Ayamiss the Hunter"] = "Ayamiss the Hunter"
L["Back and Forth"] = "Avanti e indietro"
L["Background"] = "Sfondo"
L["Background Color"] = "Colore Sfondo"
L["Bar Color"] = "Colore Barra"
--[[Translation missing --]]
L["Baron Geddon"] = "Baron Geddon"
L["Battle.net Whisper"] = "Sussurri di Battle.net"
L["Battleground"] = "Campo di battaglia"
--[[Translation missing --]]
L["Battleguard Sartura"] = "Battleguard Sartura"
--[[Translation missing --]]
L["BG>Raid>Party>Say"] = "BG>Raid>Party>Say"
--[[Translation missing --]]
L["BG-System Alliance"] = "BG-System Alliance"
--[[Translation missing --]]
L["BG-System Horde"] = "BG-System Horde"
--[[Translation missing --]]
L["BG-System Neutral"] = "BG-System Neutral"
--[[Translation missing --]]
L["Big Number"] = "Big Number"
L["BigWigs Addon"] = "BigWigs Add-on"
L["BigWigs Message"] = "Messaggio di BigWigs"
L["BigWigs Timer"] = "Timer di BigWigs"
--[[Translation missing --]]
L["Black Wing Lair"] = "Black Wing Lair"
--[[Translation missing --]]
L["Blizzard (2h | 3m | 10s | 2.4)"] = "Blizzard (2h | 3m | 10s | 2.4)"
L["Blizzard Combat Text"] = "Testo di combattimento Blizzard"
L["Block"] = "Bloccare"
--[[Translation missing --]]
L["Block (%)"] = "Block (%)"
--[[Translation missing --]]
L["Block against Target (%)"] = "Block against Target (%)"
L["Blocked"] = "Bloccato"
--[[Translation missing --]]
L["Bloodlord Mandokir"] = "Bloodlord Mandokir"
L["Border"] = "Bordo"
L["Boss"] = "Boss"
L["Boss Emote"] = "Boss Emote"
--[[Translation missing --]]
L["Boss Whisper"] = "Boss Whisper"
L["Bottom"] = "Basso"
L["Bottom Left"] = "Basso a sinistra"
L["Bottom Right"] = "Basso a destra"
L["Bottom to Top"] = "Basso verso l'alto"
L["Bounce"] = "Balzo"
L["Bounce with Decay"] = "Bounce with Decay"
--[[Translation missing --]]
L["Broodlord Lashlayer"] = "Broodlord Lashlayer"
L["Buff"] = "Buff"
L["Buffed/Debuffed"] = "Buffato/Debuffato"
--[[Translation missing --]]
L["Buru the Gorger"] = "Buru the Gorger"
L["Can be used for e.g. checking if \"boss1target\" is the same as \"player\"."] = "Può essere usato per esempio per controllare se \"boss1target\" sia uguale a \"player\"."
L["Cancel"] = "Cancella"
--[[Translation missing --]]
L["Can't schedule timer with %i, due to a World of Warcraft bug with high computer uptime. (Uptime: %i). Please restart your computer."] = "Can't schedule timer with %i, due to a World of Warcraft bug with high computer uptime. (Uptime: %i). Please restart your computer."
L["Cast"] = "Cast"
--[[Translation missing --]]
L["Cast Bar"] = "Cast Bar"
L["Cast Failed"] = "Cast fallito"
L["Cast Start"] = "Inizio cast"
L["Cast Success"] = "Cast terminato con successo"
L["Cast Type"] = "Tipo di cast"
--[[Translation missing --]]
L["Caster"] = "Caster"
--[[Translation missing --]]
L["Caster Name"] = "Caster Name"
--[[Translation missing --]]
L["Caster Realm"] = "Caster Realm"
--[[Translation missing --]]
L["Caster Unit"] = "Caster Unit"
--[[Translation missing --]]
L["Caster's Target"] = "Caster's Target"
--[[Translation missing --]]
L["Ceil"] = "Ceil"
L["Center"] = "Centro"
L["Centered Horizontal"] = "Centrato orizzontalmente"
L["Centered Vertical"] = "Centrato verticalmente"
L["Changed"] = "Modificato"
L["Channel"] = "Canale"
L["Channel (Spell)"] = "Canale (Magia)"
--[[Translation missing --]]
L["Character Stats"] = "Character Stats"
L["Character Type"] = "Tipo di carattere"
--[[Translation missing --]]
L["Charge gained/lost"] = "Charge gained/lost"
--[[Translation missing --]]
L["Charged Combo Point"] = "Charged Combo Point"
L["Charges"] = "Cariche"
--[[Translation missing --]]
L["Charges Changed Event"] = "Charges Changed Event"
L["Chat Frame"] = "Cornice di chat"
L["Chat Message"] = "Messaggio di chat"
--[[Translation missing --]]
L["Children:"] = "Children:"
--[[Translation missing --]]
L["Choose a category"] = "Choose a category"
--[[Translation missing --]]
L["Chromaggus"] = "Chromaggus"
L["Circle"] = "Cerchio"
--[[Translation missing --]]
L["Clamp"] = "Clamp"
L["Class"] = "Classe"
L["Class and Specialization"] = "Classe e Specializzazione"
--[[Translation missing --]]
L["Classification"] = "Classification"
L["Clockwise"] = "Senso Orario"
--[[Translation missing --]]
L["Clone per Event"] = "Clone per Event"
--[[Translation missing --]]
L["Clone per Match"] = "Clone per Match"
L["Color"] = "Colore"
L["Combat Log"] = "Registro di combattimento"
L["Conditions"] = "Condizioni"
L["Contains"] = "Contiene"
--[[Translation missing --]]
L["Continuously update Movement Speed"] = "Continuously update Movement Speed"
--[[Translation missing --]]
L["Cooldown"] = "Cooldown"
--[[Translation missing --]]
L["Cooldown Progress (Item)"] = "Cooldown Progress (Item)"
--[[Translation missing --]]
L["Cooldown Progress (Slot)"] = "Cooldown Progress (Slot)"
--[[Translation missing --]]
L["Cooldown Ready Event"] = "Cooldown Ready Event"
--[[Translation missing --]]
L["Cooldown Ready Event (Item)"] = "Cooldown Ready Event (Item)"
--[[Translation missing --]]
L["Cooldown Ready Event (Slot)"] = "Cooldown Ready Event (Slot)"
--[[Translation missing --]]
L["Cooldown/Charges/Count"] = "Cooldown/Charges/Count"
--[[Translation missing --]]
L["Count"] = "Count"
--[[Translation missing --]]
L["Counter Clockwise"] = "Counter Clockwise"
L["Create"] = "Crea"
L["Create a Copy"] = "Crea una Copia"
L["Critical"] = "Critico"
--[[Translation missing --]]
L["Critical (%)"] = "Critical (%)"
--[[Translation missing --]]
L["Critical Rating"] = "Critical Rating"
--[[Translation missing --]]
L["Crowd Controlled"] = "Crowd Controlled"
--[[Translation missing --]]
L["Crushing"] = "Crushing"
--[[Translation missing --]]
L["C'thun"] = "C'thun"
--[[Translation missing --]]
L["Current Experience"] = "Current Experience"
--[[Translation missing --]]
L[ [=[Current Zone Group
]=] ] = [=[Current Zone Group
]=]
--[[Translation missing --]]
L[ [=[Current Zone
]=] ] = [=[Current Zone
]=]
--[[Translation missing --]]
L["Curse"] = "Curse"
--[[Translation missing --]]
L["Custom"] = "Custom"
--[[Translation missing --]]
L["Custom Check"] = "Custom Check"
--[[Translation missing --]]
L["Custom Color"] = "Custom Color"
--[[Translation missing --]]
L["Custom Configuration"] = "Custom Configuration"
--[[Translation missing --]]
L["Custom Function"] = "Custom Function"
--[[Translation missing --]]
L["Damage"] = "Damage"
--[[Translation missing --]]
L["Damage Shield"] = "Damage Shield"
--[[Translation missing --]]
L["Damage Shield Missed"] = "Damage Shield Missed"
--[[Translation missing --]]
L["Damage Split"] = "Damage Split"
--[[Translation missing --]]
L["DBM Announce"] = "DBM Announce"
--[[Translation missing --]]
L["DBM Timer"] = "DBM Timer"
L["Death Knight Rune"] = "Rune del cavaliere della morte"
--[[Translation missing --]]
L["Debuff"] = "Debuff"
--[[Translation missing --]]
L["Debuff Class"] = "Debuff Class"
--[[Translation missing --]]
L["Debuff Class Icon"] = "Debuff Class Icon"
--[[Translation missing --]]
L["Debuff Type"] = "Debuff Type"
--[[Translation missing --]]
L["Deflect"] = "Deflect"
--[[Translation missing --]]
L["Desaturate"] = "Desaturate"
--[[Translation missing --]]
L["Desaturate Background"] = "Desaturate Background"
--[[Translation missing --]]
L["Desaturate Foreground"] = "Desaturate Foreground"
--[[Translation missing --]]
L["Descending"] = "Descending"
L["Description"] = "Descrizione"
--[[Translation missing --]]
L["Dest Raid Mark"] = "Dest Raid Mark"
--[[Translation missing --]]
L["Destination Affiliation"] = "Destination Affiliation"
--[[Translation missing --]]
L["Destination GUID"] = "Destination GUID"
--[[Translation missing --]]
L["Destination Name"] = "Destination Name"
--[[Translation missing --]]
L["Destination NPC Id"] = "Destination NPC Id"
--[[Translation missing --]]
L["Destination Object Type"] = "Destination Object Type"
--[[Translation missing --]]
L["Destination Reaction"] = "Destination Reaction"
--[[Translation missing --]]
L["Destination Unit"] = "Destination Unit"
--[[Translation missing --]]
L["Disable Spell Known Check"] = "Disable Spell Known Check"
--[[Translation missing --]]
L["Disabled Spell Known Check"] = "Disabled Spell Known Check"
--[[Translation missing --]]
L["Disease"] = "Disease"
--[[Translation missing --]]
L["Dispel"] = "Dispel"
--[[Translation missing --]]
L["Dispel Failed"] = "Dispel Failed"
--[[Translation missing --]]
L["Display"] = "Display"
L["Distance"] = "Distanza"
--[[Translation missing --]]
L["Dodge"] = "Dodge"
--[[Translation missing --]]
L["Dodge (%)"] = "Dodge (%)"
--[[Translation missing --]]
L["Dodge Rating"] = "Dodge Rating"
--[[Translation missing --]]
L["Done"] = "Done"
--[[Translation missing --]]
L["Down"] = "Down"
--[[Translation missing --]]
L["Down, then Left"] = "Down, then Left"
--[[Translation missing --]]
L["Down, then Right"] = "Down, then Right"
--[[Translation missing --]]
L["Drain"] = "Drain"
--[[Translation missing --]]
L["Dropdown Menu"] = "Dropdown Menu"
--[[Translation missing --]]
L["Dungeon (Heroic)"] = "Dungeon (Heroic)"
--[[Translation missing --]]
L["Dungeon (Mythic)"] = "Dungeon (Mythic)"
--[[Translation missing --]]
L["Dungeon (Normal)"] = "Dungeon (Normal)"
--[[Translation missing --]]
L["Dungeon (Timewalking)"] = "Dungeon (Timewalking)"
--[[Translation missing --]]
L["Dungeons"] = "Dungeons"
--[[Translation missing --]]
L["Durability Damage"] = "Durability Damage"
--[[Translation missing --]]
L["Durability Damage All"] = "Durability Damage All"
--[[Translation missing --]]
L["Dynamic Information"] = "Dynamic Information"
--[[Translation missing --]]
L["Ease In"] = "Ease In"
--[[Translation missing --]]
L["Ease In and Out"] = "Ease In and Out"
--[[Translation missing --]]
L["Ease Out"] = "Ease Out"
--[[Translation missing --]]
L["Ebonroc"] = "Ebonroc"
--[[Translation missing --]]
L["Edge"] = "Edge"
--[[Translation missing --]]
L["Edge of Madness"] = "Edge of Madness"
--[[Translation missing --]]
L["Elide"] = "Elide"
--[[Translation missing --]]
L["Elite"] = "Elite"
--[[Translation missing --]]
L["Emote"] = "Emote"
--[[Translation missing --]]
L["Empty"] = "Empty"
--[[Translation missing --]]
L["Enchant Applied"] = "Enchant Applied"
--[[Translation missing --]]
L["Enchant Found"] = "Enchant Found"
--[[Translation missing --]]
L["Enchant Missing"] = "Enchant Missing"
--[[Translation missing --]]
L["Enchant Name or ID"] = "Enchant Name or ID"
--[[Translation missing --]]
L["Enchant Removed"] = "Enchant Removed"
--[[Translation missing --]]
L["Enchanted"] = "Enchanted"
--[[Translation missing --]]
L["Encounter ID(s)"] = "Encounter ID(s)"
--[[Translation missing --]]
L["Energize"] = "Energize"
--[[Translation missing --]]
L["Enrage"] = "Enrage"
--[[Translation missing --]]
L["Enter static or relative values with %"] = "Enter static or relative values with %"
--[[Translation missing --]]
L["Entering"] = "Entering"
--[[Translation missing --]]
L["Entering/Leaving Combat"] = "Entering/Leaving Combat"
--[[Translation missing --]]
L["Entry Order"] = "Entry Order"
--[[Translation missing --]]
L["Environment Type"] = "Environment Type"
--[[Translation missing --]]
L["Environmental"] = "Environmental"
--[[Translation missing --]]
L["Equipment Set"] = "Equipment Set"
--[[Translation missing --]]
L["Equipment Set Equipped"] = "Equipment Set Equipped"
--[[Translation missing --]]
L["Equipment Slot"] = "Equipment Slot"
--[[Translation missing --]]
L["Equipped"] = "Equipped"
L["Error"] = "Errore"
--[[Translation missing --]]
L["Error Frame"] = "Error Frame"
--[[Translation missing --]]
L["Error not receiving display information from %s"] = "Error not receiving display information from %s"
--[[Translation missing --]]
L[ [=['ERROR: Anchoring %s': 
]=] ] = [=['ERROR: Anchoring %s': 
]=]
--[[Translation missing --]]
L["Evade"] = "Evade"
L["Event"] = "Evento"
--[[Translation missing --]]
L["Event(s)"] = "Event(s)"
--[[Translation missing --]]
L["Every Frame"] = "Every Frame"
--[[Translation missing --]]
L["Every Frame (High CPU usage)"] = "Every Frame (High CPU usage)"
--[[Translation missing --]]
L["Experience (%)"] = "Experience (%)"
--[[Translation missing --]]
L["Extend Outside"] = "Extend Outside"
--[[Translation missing --]]
L["Extra Amount"] = "Extra Amount"
--[[Translation missing --]]
L["Extra Attacks"] = "Extra Attacks"
--[[Translation missing --]]
L["Extra Spell Name"] = "Extra Spell Name"
--[[Translation missing --]]
L["Faction"] = "Faction"
--[[Translation missing --]]
L["Faction Name"] = "Faction Name"
--[[Translation missing --]]
L["Faction Reputation"] = "Faction Reputation"
--[[Translation missing --]]
L["Fade In"] = "Fade In"
--[[Translation missing --]]
L["Fade Out"] = "Fade Out"
--[[Translation missing --]]
L["Fail Alert"] = "Fail Alert"
--[[Translation missing --]]
L["Fallback"] = "Fallback"
--[[Translation missing --]]
L["Fallback Icon"] = "Fallback Icon"
--[[Translation missing --]]
L["False"] = "False"
--[[Translation missing --]]
L["Fankriss the Unyielding"] = "Fankriss the Unyielding"
--[[Translation missing --]]
L["Fetch Legendary Power"] = "Fetch Legendary Power"
--[[Translation missing --]]
L["Fetches the name and icon of the Legendary Power that matches this bonus id."] = "Fetches the name and icon of the Legendary Power that matches this bonus id."
--[[Translation missing --]]
L["Filter messages with format <message>"] = "Filter messages with format <message>"
--[[Translation missing --]]
L["Fire Resistance"] = "Fire Resistance"
--[[Translation missing --]]
L["Firemaw"] = "Firemaw"
--[[Translation missing --]]
L["First"] = "First"
--[[Translation missing --]]
L["First Value of Tooltip Text"] = "First Value of Tooltip Text"
--[[Translation missing --]]
L["Fixed"] = "Fixed"
--[[Translation missing --]]
L["Fixed Names"] = "Fixed Names"
--[[Translation missing --]]
L["Fixed Size"] = "Fixed Size"
--[[Translation missing --]]
L["Flamegor"] = "Flamegor"
--[[Translation missing --]]
L["Flash"] = "Flash"
--[[Translation missing --]]
L["Flex Raid"] = "Flex Raid"
--[[Translation missing --]]
L["Flip"] = "Flip"
--[[Translation missing --]]
L["Floor"] = "Floor"
--[[Translation missing --]]
L["Focus"] = "Focus"
--[[Translation missing --]]
L["Font Size"] = "Font Size"
--[[Translation missing --]]
L["Forbidden function or table: %s"] = "Forbidden function or table: %s"
--[[Translation missing --]]
L["Foreground"] = "Foreground"
--[[Translation missing --]]
L["Foreground Color"] = "Foreground Color"
L["Form"] = "Forma"
--[[Translation missing --]]
L["Format"] = "Format"
--[[Translation missing --]]
L["Formats |cFFFF0000%unit|r"] = "Formats |cFFFF0000%unit|r"
--[[Translation missing --]]
L["Formats Player's |cFFFF0000%guid|r"] = "Formats Player's |cFFFF0000%guid|r"
--[[Translation missing --]]
L["Forward"] = "Forward"
--[[Translation missing --]]
L["Forward, Reverse Loop"] = "Forward, Reverse Loop"
--[[Translation missing --]]
L["Frame Selector"] = "Frame Selector"
--[[Translation missing --]]
L["Frequency"] = "Frequency"
--[[Translation missing --]]
L["Friendly"] = "Friendly"
--[[Translation missing --]]
L["Friendly Fire"] = "Friendly Fire"
--[[Translation missing --]]
L["From"] = "From"
--[[Translation missing --]]
L["Frost Resistance"] = "Frost Resistance"
--[[Translation missing --]]
L["Full"] = "Full"
--[[Translation missing --]]
L["Full Bar"] = "Full Bar"
--[[Translation missing --]]
L["Full/Empty"] = "Full/Empty"
--[[Translation missing --]]
L["Gahz'ranka"] = "Gahz'ranka"
--[[Translation missing --]]
L["Gained"] = "Gained"
--[[Translation missing --]]
L["Garr"] = "Garr"
--[[Translation missing --]]
L["Gehennas"] = "Gehennas"
--[[Translation missing --]]
L["General Rajaxx"] = "General Rajaxx"
--[[Translation missing --]]
L["Glancing"] = "Glancing"
--[[Translation missing --]]
L["Global Cooldown"] = "Global Cooldown"
--[[Translation missing --]]
L["Glow"] = "Glow"
--[[Translation missing --]]
L["Glow External Element"] = "Glow External Element"
--[[Translation missing --]]
L["Gluth"] = "Gluth"
--[[Translation missing --]]
L["Golemagg the Incinerator"] = "Golemagg the Incinerator"
--[[Translation missing --]]
L["Gothik the Harvester"] = "Gothik the Harvester"
--[[Translation missing --]]
L["Gradient"] = "Gradient"
--[[Translation missing --]]
L["Gradient Pulse"] = "Gradient Pulse"
--[[Translation missing --]]
L["Grand Widow Faerlina"] = "Grand Widow Faerlina"
--[[Translation missing --]]
L["Grid"] = "Grid"
--[[Translation missing --]]
L["Grobbulus"] = "Grobbulus"
--[[Translation missing --]]
L["Group"] = "Group"
--[[Translation missing --]]
L["Group Arrangement"] = "Group Arrangement"
--[[Translation missing --]]
L["Grow"] = "Grow"
--[[Translation missing --]]
L["GTFO Alert"] = "GTFO Alert"
--[[Translation missing --]]
L["Guardian"] = "Guardian"
--[[Translation missing --]]
L["Guild"] = "Guild"
--[[Translation missing --]]
L["Hakkar"] = "Hakkar"
--[[Translation missing --]]
L["Has Target"] = "Has Target"
--[[Translation missing --]]
L["Has Vehicle UI"] = "Has Vehicle UI"
--[[Translation missing --]]
L["HasPet"] = "HasPet"
--[[Translation missing --]]
L["Haste (%)"] = "Haste (%)"
--[[Translation missing --]]
L["Haste Rating"] = "Haste Rating"
--[[Translation missing --]]
L["Heal"] = "Heal"
--[[Translation missing --]]
L["Health"] = "Health"
--[[Translation missing --]]
L["Health (%)"] = "Health (%)"
--[[Translation missing --]]
L["Heigan the Unclean"] = "Heigan the Unclean"
--[[Translation missing --]]
L["Height"] = "Height"
--[[Translation missing --]]
L["Hide"] = "Hide"
--[[Translation missing --]]
L["Hide 0 cooldowns"] = "Hide 0 cooldowns"
--[[Translation missing --]]
L["High Damage"] = "High Damage"
--[[Translation missing --]]
L["High Priest Thekal"] = "High Priest Thekal"
--[[Translation missing --]]
L["High Priest Venoxis"] = "High Priest Venoxis"
--[[Translation missing --]]
L["High Priestess Arlokk"] = "High Priestess Arlokk"
--[[Translation missing --]]
L["High Priestess Jeklik"] = "High Priestess Jeklik"
--[[Translation missing --]]
L["High Priestess Mar'li"] = "High Priestess Mar'li"
--[[Translation missing --]]
L["Higher Than Tank"] = "Higher Than Tank"
--[[Translation missing --]]
L["Holy Resistance"] = "Holy Resistance"
--[[Translation missing --]]
L["Horde"] = "Horde"
--[[Translation missing --]]
L["Hostile"] = "Hostile"
--[[Translation missing --]]
L["Hostility"] = "Hostility"
--[[Translation missing --]]
L["Humanoid"] = "Humanoid"
--[[Translation missing --]]
L["Hybrid"] = "Hybrid"
--[[Translation missing --]]
L["Icon"] = "Icon"
--[[Translation missing --]]
L["If you require additional assistance, please open a ticket on GitHub or visit our Discord at https://discord.gg/UXSc7nt!"] = "If you require additional assistance, please open a ticket on GitHub or visit our Discord at https://discord.gg/UXSc7nt!"
--[[Translation missing --]]
L["Ignore Dead"] = "Ignore Dead"
--[[Translation missing --]]
L["Ignore Disconnected"] = "Ignore Disconnected"
--[[Translation missing --]]
L["Ignore Rune CD"] = "Ignore Rune CD"
--[[Translation missing --]]
L["Ignore Rune CDs"] = "Ignore Rune CDs"
--[[Translation missing --]]
L["Ignore Self"] = "Ignore Self"
--[[Translation missing --]]
L["Immune"] = "Immune"
--[[Translation missing --]]
L["Import"] = "Import"
--[[Translation missing --]]
L["Import as Copy"] = "Import as Copy"
--[[Translation missing --]]
L["Import as Update"] = "Import as Update"
--[[Translation missing --]]
L["Import Group"] = "Import Group"
--[[Translation missing --]]
L["Import in progress"] = "Import in progress"
--[[Translation missing --]]
L["Important"] = "Important"
--[[Translation missing --]]
L["Importing is disabled while in combat"] = "Importing is disabled while in combat"
--[[Translation missing --]]
L["In Combat"] = "In Combat"
--[[Translation missing --]]
L["In Encounter"] = "In Encounter"
--[[Translation missing --]]
L["In Group"] = "In Group"
--[[Translation missing --]]
L["In Pet Battle"] = "In Pet Battle"
--[[Translation missing --]]
L["In Raid"] = "In Raid"
--[[Translation missing --]]
L["In Vehicle"] = "In Vehicle"
--[[Translation missing --]]
L["Include Bank"] = "Include Bank"
--[[Translation missing --]]
L["Include Charges"] = "Include Charges"
--[[Translation missing --]]
L["Incoming Heal"] = "Incoming Heal"
--[[Translation missing --]]
L["Increase Precision Below"] = "Increase Precision Below"
--[[Translation missing --]]
L["Information"] = "Information"
--[[Translation missing --]]
L["Inherited"] = "Inherited"
--[[Translation missing --]]
L["Instakill"] = "Instakill"
--[[Translation missing --]]
L["Instance"] = "Instance"
--[[Translation missing --]]
L["Instance Difficulty"] = "Instance Difficulty"
--[[Translation missing --]]
L["Instance Size Type"] = "Instance Size Type"
--[[Translation missing --]]
L["Instance Type"] = "Instance Type"
--[[Translation missing --]]
L["Instructor Razuvious"] = "Instructor Razuvious"
--[[Translation missing --]]
L["Insufficient Resources"] = "Insufficient Resources"
--[[Translation missing --]]
L["Intellect"] = "Intellect"
--[[Translation missing --]]
L["Interrupt"] = "Interrupt"
--[[Translation missing --]]
L["Interrupt School"] = "Interrupt School"
--[[Translation missing --]]
L["Interrupted School Text"] = "Interrupted School Text"
--[[Translation missing --]]
L["Interruptible"] = "Interruptible"
--[[Translation missing --]]
L["Inverse"] = "Inverse"
--[[Translation missing --]]
L["Inverse Pet Behavior"] = "Inverse Pet Behavior"
--[[Translation missing --]]
L["Is Away from Keyboard"] = "Is Away from Keyboard"
--[[Translation missing --]]
L["Is Exactly"] = "Is Exactly"
--[[Translation missing --]]
L["Is Moving"] = "Is Moving"
--[[Translation missing --]]
L["Is Off Hand"] = "Is Off Hand"
--[[Translation missing --]]
L["is useable"] = "is useable"
--[[Translation missing --]]
L["Island Expedition (Heroic)"] = "Island Expedition (Heroic)"
--[[Translation missing --]]
L["Island Expedition (Mythic)"] = "Island Expedition (Mythic)"
--[[Translation missing --]]
L["Island Expedition (Normal)"] = "Island Expedition (Normal)"
--[[Translation missing --]]
L["Island Expeditions (PvP)"] = "Island Expeditions (PvP)"
--[[Translation missing --]]
L["It might not work correctly on Classic!"] = "It might not work correctly on Classic!"
--[[Translation missing --]]
L["It might not work correctly on Retail!"] = "It might not work correctly on Retail!"
--[[Translation missing --]]
L["It might not work correctly with your version!"] = "It might not work correctly with your version!"
--[[Translation missing --]]
L["Item"] = "Item"
--[[Translation missing --]]
L["Item Bonus Id"] = "Item Bonus Id"
--[[Translation missing --]]
L["Item Bonus Id Equipped"] = "Item Bonus Id Equipped"
--[[Translation missing --]]
L["Item Count"] = "Item Count"
--[[Translation missing --]]
L["Item Equipped"] = "Item Equipped"
--[[Translation missing --]]
L["Item Id"] = "Item Id"
--[[Translation missing --]]
L["Item in Range"] = "Item in Range"
--[[Translation missing --]]
L["Item Name"] = "Item Name"
--[[Translation missing --]]
L["Item Set Equipped"] = "Item Set Equipped"
--[[Translation missing --]]
L["Item Set Id"] = "Item Set Id"
--[[Translation missing --]]
L["Item Slot"] = "Item Slot"
--[[Translation missing --]]
L["Item Slot String"] = "Item Slot String"
--[[Translation missing --]]
L["Item Type"] = "Item Type"
--[[Translation missing --]]
L["Item Type Equipped"] = "Item Type Equipped"
--[[Translation missing --]]
L["Jin'do the Hexxer"] = "Jin'do the Hexxer"
--[[Translation missing --]]
L["Keep Inside"] = "Keep Inside"
--[[Translation missing --]]
L["Kel'Thuzad"] = "Kel'Thuzad"
--[[Translation missing --]]
L["Kurinnaxx"] = "Kurinnaxx"
--[[Translation missing --]]
L["Large"] = "Large"
--[[Translation missing --]]
L["Latency"] = "Latency"
--[[Translation missing --]]
L["Least remaining time"] = "Least remaining time"
--[[Translation missing --]]
L["Leaving"] = "Leaving"
--[[Translation missing --]]
L["Leech"] = "Leech"
--[[Translation missing --]]
L["Leech (%)"] = "Leech (%)"
--[[Translation missing --]]
L["Leech Rating"] = "Leech Rating"
--[[Translation missing --]]
L["Left"] = "Left"
--[[Translation missing --]]
L["Left to Right"] = "Left to Right"
--[[Translation missing --]]
L["Left, then Down"] = "Left, then Down"
--[[Translation missing --]]
L["Left, then Up"] = "Left, then Up"
--[[Translation missing --]]
L["Legacy Aura (disabled)"] = "Legacy Aura (disabled)"
--[[Translation missing --]]
L["Legacy Aura (disabled):"] = "Legacy Aura (disabled):"
--[[Translation missing --]]
L["Legacy Looking for Raid"] = "Legacy Looking for Raid"
--[[Translation missing --]]
L["Legacy RGB Gradient"] = "Legacy RGB Gradient"
--[[Translation missing --]]
L["Legacy RGB Gradient Pulse"] = "Legacy RGB Gradient Pulse"
--[[Translation missing --]]
L["Length"] = "Length"
--[[Translation missing --]]
L["Level"] = "Level"
--[[Translation missing --]]
L["Limited"] = "Limited"
--[[Translation missing --]]
L["Lines & Particles"] = "Lines & Particles"
--[[Translation missing --]]
L["Load Conditions"] = "Load Conditions"
--[[Translation missing --]]
L["Loatheb"] = "Loatheb"
--[[Translation missing --]]
L["Looking for Raid"] = "Looking for Raid"
--[[Translation missing --]]
L["Loop"] = "Loop"
--[[Translation missing --]]
L["Lost"] = "Lost"
--[[Translation missing --]]
L["Low Damage"] = "Low Damage"
--[[Translation missing --]]
L["Lower Than Tank"] = "Lower Than Tank"
--[[Translation missing --]]
L["Lucifron"] = "Lucifron"
--[[Translation missing --]]
L["Maexxna"] = "Maexxna"
--[[Translation missing --]]
L["Magic"] = "Magic"
--[[Translation missing --]]
L["Magmadar"] = "Magmadar"
--[[Translation missing --]]
L["Main Stat"] = "Main Stat"
--[[Translation missing --]]
L["Majordomo Executus"] = "Majordomo Executus"
--[[Translation missing --]]
L["Make sure you can trust the person who sent it!"] = "Make sure you can trust the person who sent it!"
--[[Translation missing --]]
L["Malformed WeakAuras link"] = "Malformed WeakAuras link"
--[[Translation missing --]]
L["Manual Repair Confirmation Dialog"] = "Manual Repair Confirmation Dialog"
--[[Translation missing --]]
L["Manual Rotation"] = "Manual Rotation"
--[[Translation missing --]]
L["Marked First"] = "Marked First"
--[[Translation missing --]]
L["Marked Last"] = "Marked Last"
--[[Translation missing --]]
L["Master"] = "Master"
--[[Translation missing --]]
L["Mastery (%)"] = "Mastery (%)"
--[[Translation missing --]]
L["Mastery Rating"] = "Mastery Rating"
--[[Translation missing --]]
L["Match Count"] = "Match Count"
--[[Translation missing --]]
L["Match Count per Unit"] = "Match Count per Unit"
--[[Translation missing --]]
L["Matches (Pattern)"] = "Matches (Pattern)"
--[[Translation missing --]]
L["Max Char "] = "Max Char "
--[[Translation missing --]]
L["Max Charges"] = "Max Charges"
--[[Translation missing --]]
L["Maximum"] = "Maximum"
--[[Translation missing --]]
L["Maximum Estimate"] = "Maximum Estimate"
--[[Translation missing --]]
L["Medium"] = "Medium"
--[[Translation missing --]]
L["Message"] = "Message"
--[[Translation missing --]]
L["Message Type"] = "Message Type"
--[[Translation missing --]]
L["Message type:"] = "Message type:"
--[[Translation missing --]]
L["Meta Data"] = "Meta Data"
--[[Translation missing --]]
L["Mine"] = "Mine"
--[[Translation missing --]]
L["Minimum"] = "Minimum"
--[[Translation missing --]]
L["Minimum Estimate"] = "Minimum Estimate"
--[[Translation missing --]]
L["Minus (Small Nameplate)"] = "Minus (Small Nameplate)"
--[[Translation missing --]]
L["Mirror"] = "Mirror"
--[[Translation missing --]]
L["Miss"] = "Miss"
--[[Translation missing --]]
L["Miss Type"] = "Miss Type"
--[[Translation missing --]]
L["Missed"] = "Missed"
--[[Translation missing --]]
L["Missing"] = "Missing"
--[[Translation missing --]]
L["Moam"] = "Moam"
--[[Translation missing --]]
L["Model"] = "Model"
--[[Translation missing --]]
L["Modern Blizzard (1h 3m | 3m 7s | 10s | 2.4)"] = "Modern Blizzard (1h 3m | 3m 7s | 10s | 2.4)"
--[[Translation missing --]]
L["Molten Core"] = "Molten Core"
--[[Translation missing --]]
L["Monochrome"] = "Monochrome"
--[[Translation missing --]]
L["Monochrome Outline"] = "Monochrome Outline"
--[[Translation missing --]]
L["Monochrome Thick Outline"] = "Monochrome Thick Outline"
--[[Translation missing --]]
L["Monster Emote"] = "Monster Emote"
--[[Translation missing --]]
L["Monster Party"] = "Monster Party"
--[[Translation missing --]]
L["Monster Say"] = "Monster Say"
--[[Translation missing --]]
L["Monster Whisper"] = "Monster Whisper"
--[[Translation missing --]]
L["Monster Yell"] = "Monster Yell"
--[[Translation missing --]]
L["Most remaining time"] = "Most remaining time"
--[[Translation missing --]]
L["Mounted"] = "Mounted"
--[[Translation missing --]]
L["Mouse Cursor"] = "Mouse Cursor"
--[[Translation missing --]]
L["Movement Speed (%)"] = "Movement Speed (%)"
--[[Translation missing --]]
L["Movement Speed Rating"] = "Movement Speed Rating"
--[[Translation missing --]]
L["Multi-target"] = "Multi-target"
--[[Translation missing --]]
L["Mythic Keystone"] = "Mythic Keystone"
--[[Translation missing --]]
L["Mythic+ Affix"] = "Mythic+ Affix"
--[[Translation missing --]]
L["Name"] = "Name"
--[[Translation missing --]]
L["Name of Caster's Target"] = "Name of Caster's Target"
--[[Translation missing --]]
L["Name/Realm of Caster's Target"] = "Name/Realm of Caster's Target"
--[[Translation missing --]]
L["Nameplate"] = "Nameplate"
--[[Translation missing --]]
L["Nameplate Type"] = "Nameplate Type"
--[[Translation missing --]]
L["Nameplates"] = "Nameplates"
--[[Translation missing --]]
L["Names of affected Players"] = "Names of affected Players"
--[[Translation missing --]]
L["Names of unaffected Players"] = "Names of unaffected Players"
--[[Translation missing --]]
L["Nature Resistance"] = "Nature Resistance"
--[[Translation missing --]]
L["Naxxramas"] = "Naxxramas"
--[[Translation missing --]]
L["Nefarian"] = "Nefarian"
--[[Translation missing --]]
L["Neutral"] = "Neutral"
--[[Translation missing --]]
L["Never"] = "Never"
--[[Translation missing --]]
L["Next"] = "Next"
--[[Translation missing --]]
L["Next Combat"] = "Next Combat"
--[[Translation missing --]]
L["Next Encounter"] = "Next Encounter"
--[[Translation missing --]]
L["No Children"] = "No Children"
--[[Translation missing --]]
L["No Extend"] = "No Extend"
--[[Translation missing --]]
L["No Instance"] = "No Instance"
--[[Translation missing --]]
L["No Profiling information saved."] = "No Profiling information saved."
--[[Translation missing --]]
L["None"] = "None"
--[[Translation missing --]]
L["Non-player Character"] = "Non-player Character"
--[[Translation missing --]]
L["Normal"] = "Normal"
--[[Translation missing --]]
L["Not in Group"] = "Not in Group"
--[[Translation missing --]]
L["Not on Cooldown"] = "Not on Cooldown"
--[[Translation missing --]]
L["Not On Threat Table"] = "Not On Threat Table"
--[[Translation missing --]]
L["Note, that cross realm transmission is possible if you are on the same group"] = "Note, that cross realm transmission is possible if you are on the same group"
--[[Translation missing --]]
L["Note: 'Hide Alone' is not available in the new aura tracking system. A load option can be used instead."] = "Note: 'Hide Alone' is not available in the new aura tracking system. A load option can be used instead."
--[[Translation missing --]]
L["Note: The available text replacements for multi triggers match the normal triggers now."] = "Note: The available text replacements for multi triggers match the normal triggers now."
--[[Translation missing --]]
L["Note: This trigger type estimates the range to the hitbox of a unit. The actual range of friendly players is usually 3 yards more than the estimate. Range checking capabilities depend on your current class and known abilities as well as the type of unit being checked. Some of the ranges may also not work with certain NPCs.|n|n|cFFAAFFAAFriendly Units:|r %s|n|cFFFFAAAAHarmful Units:|r %s|n|cFFAAAAFFMiscellanous Units:|r %s"] = "Note: This trigger type estimates the range to the hitbox of a unit. The actual range of friendly players is usually 3 yards more than the estimate. Range checking capabilities depend on your current class and known abilities as well as the type of unit being checked. Some of the ranges may also not work with certain NPCs.|n|n|cFFAAFFAAFriendly Units:|r %s|n|cFFFFAAAAHarmful Units:|r %s|n|cFFAAAAFFMiscellanous Units:|r %s"
--[[Translation missing --]]
L["Noth the Plaguebringer"] = "Noth the Plaguebringer"
--[[Translation missing --]]
L["NPC"] = "NPC"
--[[Translation missing --]]
L["Npc ID"] = "Npc ID"
--[[Translation missing --]]
L["Number"] = "Number"
--[[Translation missing --]]
L["Number Affected"] = "Number Affected"
--[[Translation missing --]]
L["Object"] = "Object"
--[[Translation missing --]]
L["Officer"] = "Officer"
--[[Translation missing --]]
L["Offset from progress"] = "Offset from progress"
--[[Translation missing --]]
L["Offset Timer"] = "Offset Timer"
--[[Translation missing --]]
L["Old Blizzard (2h | 3m | 10s | 2.4)"] = "Old Blizzard (2h | 3m | 10s | 2.4)"
--[[Translation missing --]]
L["On Cooldown"] = "On Cooldown"
--[[Translation missing --]]
L["On Taxi"] = "On Taxi"
--[[Translation missing --]]
L["Only if BigWigs shows it on it's bar"] = "Only if BigWigs shows it on it's bar"
--[[Translation missing --]]
L["Only if DBM shows it on it's bar"] = "Only if DBM shows it on it's bar"
--[[Translation missing --]]
L["Only if on a different realm"] = "Only if on a different realm"
--[[Translation missing --]]
L["Only if Primary"] = "Only if Primary"
--[[Translation missing --]]
L["Only if selected"] = "Only if selected"
--[[Translation missing --]]
L["Onyxia"] = "Onyxia"
--[[Translation missing --]]
L["Onyxia's Lair"] = "Onyxia's Lair"
--[[Translation missing --]]
L["Opaque"] = "Opaque"
--[[Translation missing --]]
L["Option Group"] = "Option Group"
--[[Translation missing --]]
L["Options will finish loading after combat ends."] = "Options will finish loading after combat ends."
--[[Translation missing --]]
L["Options will open after the login process has completed."] = "Options will open after the login process has completed."
--[[Translation missing --]]
L["Orbit"] = "Orbit"
--[[Translation missing --]]
L["Orientation"] = "Orientation"
--[[Translation missing --]]
L["Ossirian the Unscarred"] = "Ossirian the Unscarred"
--[[Translation missing --]]
L["Other Addons"] = "Other Addons"
--[[Translation missing --]]
L["Other Events"] = "Other Events"
--[[Translation missing --]]
L["Ouro"] = "Ouro"
--[[Translation missing --]]
L["Outline"] = "Outline"
--[[Translation missing --]]
L["Overhealing"] = "Overhealing"
--[[Translation missing --]]
L["Overkill"] = "Overkill"
--[[Translation missing --]]
L["Overlay %s"] = "Overlay %s"
--[[Translation missing --]]
L["Overlay Charged Combo Points"] = "Overlay Charged Combo Points"
--[[Translation missing --]]
L["Overlay Cost of Casts"] = "Overlay Cost of Casts"
--[[Translation missing --]]
L["Overlay Latency"] = "Overlay Latency"
--[[Translation missing --]]
L["Parry"] = "Parry"
--[[Translation missing --]]
L["Parry (%)"] = "Parry (%)"
--[[Translation missing --]]
L["Parry Rating"] = "Parry Rating"
--[[Translation missing --]]
L["Party"] = "Party"
--[[Translation missing --]]
L["Party Kill"] = "Party Kill"
--[[Translation missing --]]
L["Patchwerk"] = "Patchwerk"
--[[Translation missing --]]
L["Path of Ascension: Courage"] = "Path of Ascension: Courage"
--[[Translation missing --]]
L["Path of Ascension: Humility"] = "Path of Ascension: Humility"
--[[Translation missing --]]
L["Path of Ascension: Loyalty"] = "Path of Ascension: Loyalty"
--[[Translation missing --]]
L["Path of Ascension: Wisdom"] = "Path of Ascension: Wisdom"
--[[Translation missing --]]
L["Paused"] = "Paused"
--[[Translation missing --]]
L["Periodic Spell"] = "Periodic Spell"
--[[Translation missing --]]
L["Personal Resource Display"] = "Personal Resource Display"
--[[Translation missing --]]
L["Pet"] = "Pet"
--[[Translation missing --]]
L["Pet Behavior"] = "Pet Behavior"
--[[Translation missing --]]
L["Pet Specialization"] = "Pet Specialization"
--[[Translation missing --]]
L["Pet Spell"] = "Pet Spell"
--[[Translation missing --]]
L["Phase"] = "Phase"
--[[Translation missing --]]
L["Pixel Glow"] = "Pixel Glow"
--[[Translation missing --]]
L["Placement"] = "Placement"
--[[Translation missing --]]
L["Placement Mode"] = "Placement Mode"
--[[Translation missing --]]
L["Play"] = "Play"
--[[Translation missing --]]
L["Player"] = "Player"
--[[Translation missing --]]
L["Player Character"] = "Player Character"
--[[Translation missing --]]
L["Player Class"] = "Player Class"
--[[Translation missing --]]
L["Player Covenant"] = "Player Covenant"
--[[Translation missing --]]
L["Player Effective Level"] = "Player Effective Level"
--[[Translation missing --]]
L["Player Experience"] = "Player Experience"
--[[Translation missing --]]
L["Player Faction"] = "Player Faction"
--[[Translation missing --]]
L["Player Level"] = "Player Level"
--[[Translation missing --]]
L["Player Name/Realm"] = "Player Name/Realm"
--[[Translation missing --]]
L["Player Race"] = "Player Race"
--[[Translation missing --]]
L["Player(s) Affected"] = "Player(s) Affected"
--[[Translation missing --]]
L["Player(s) Not Affected"] = "Player(s) Not Affected"
--[[Translation missing --]]
L["Player/Unit Info"] = "Player/Unit Info"
--[[Translation missing --]]
L["Poison"] = "Poison"
--[[Translation missing --]]
L["Power"] = "Power"
--[[Translation missing --]]
L["Power (%)"] = "Power (%)"
--[[Translation missing --]]
L["Power Type"] = "Power Type"
--[[Translation missing --]]
L["Precision"] = "Precision"
--[[Translation missing --]]
L["Preset"] = "Preset"
--[[Translation missing --]]
L["Princess Huhuran"] = "Princess Huhuran"
--[[Translation missing --]]
L["Print Profiling Results"] = "Print Profiling Results"
--[[Translation missing --]]
L["Profiling already started."] = "Profiling already started."
--[[Translation missing --]]
L["Profiling automatically started."] = "Profiling automatically started."
--[[Translation missing --]]
L["Profiling not running."] = "Profiling not running."
--[[Translation missing --]]
L["Profiling started."] = "Profiling started."
--[[Translation missing --]]
L["Profiling started. It will end automatically in %d seconds"] = "Profiling started. It will end automatically in %d seconds"
--[[Translation missing --]]
L["Profiling still running, stop before trying to print."] = "Profiling still running, stop before trying to print."
--[[Translation missing --]]
L["Profiling stopped."] = "Profiling stopped."
--[[Translation missing --]]
L["Progress"] = "Progress"
--[[Translation missing --]]
L["Progress Total"] = "Progress Total"
--[[Translation missing --]]
L["Progress Value"] = "Progress Value"
--[[Translation missing --]]
L["Pulse"] = "Pulse"
--[[Translation missing --]]
L["PvP Flagged"] = "PvP Flagged"
--[[Translation missing --]]
L["PvP Talent %i"] = "PvP Talent %i"
--[[Translation missing --]]
L["PvP Talent selected"] = "PvP Talent selected"
--[[Translation missing --]]
L["PvP Talent Selected"] = "PvP Talent Selected"
--[[Translation missing --]]
L["Queued Action"] = "Queued Action"
--[[Translation missing --]]
L["Radius"] = "Radius"
--[[Translation missing --]]
L["Ragnaros"] = "Ragnaros"
--[[Translation missing --]]
L["Raid"] = "Raid"
--[[Translation missing --]]
L["Raid (Heroic)"] = "Raid (Heroic)"
--[[Translation missing --]]
L["Raid (Mythic)"] = "Raid (Mythic)"
--[[Translation missing --]]
L["Raid (Normal)"] = "Raid (Normal)"
--[[Translation missing --]]
L["Raid (Timewalking)"] = "Raid (Timewalking)"
--[[Translation missing --]]
L["Raid Role"] = "Raid Role"
--[[Translation missing --]]
L["Raid Warning"] = "Raid Warning"
--[[Translation missing --]]
L["Raids"] = "Raids"
--[[Translation missing --]]
L["Range"] = "Range"
--[[Translation missing --]]
L["Range Check"] = "Range Check"
--[[Translation missing --]]
L["Rare"] = "Rare"
--[[Translation missing --]]
L["Rare Elite"] = "Rare Elite"
--[[Translation missing --]]
L["Raw Threat Percent"] = "Raw Threat Percent"
--[[Translation missing --]]
L["Razorgore the Untamed"] = "Razorgore the Untamed"
--[[Translation missing --]]
L["Ready Check"] = "Ready Check"
--[[Translation missing --]]
L["Realm"] = "Realm"
--[[Translation missing --]]
L["Realm Name"] = "Realm Name"
--[[Translation missing --]]
L["Realm of Caster's Target"] = "Realm of Caster's Target"
--[[Translation missing --]]
L["Receiving display information"] = "Receiving display information"
--[[Translation missing --]]
L["Reflect"] = "Reflect"
--[[Translation missing --]]
L["Region type %s not supported"] = "Region type %s not supported"
--[[Translation missing --]]
L["Relative"] = "Relative"
--[[Translation missing --]]
L["Relative X-Offset"] = "Relative X-Offset"
--[[Translation missing --]]
L["Relative Y-Offset"] = "Relative Y-Offset"
--[[Translation missing --]]
L["Remaining Duration"] = "Remaining Duration"
--[[Translation missing --]]
L["Remaining Time"] = "Remaining Time"
--[[Translation missing --]]
L["Remove Obsolete Auras"] = "Remove Obsolete Auras"
--[[Translation missing --]]
L["Repair"] = "Repair"
--[[Translation missing --]]
L["Repeat"] = "Repeat"
--[[Translation missing --]]
L["Report Summary"] = "Report Summary"
--[[Translation missing --]]
L["Requested display does not exist"] = "Requested display does not exist"
--[[Translation missing --]]
L["Requested display not authorized"] = "Requested display not authorized"
--[[Translation missing --]]
L["Requesting display information from %s ..."] = "Requesting display information from %s ..."
--[[Translation missing --]]
L["Require Valid Target"] = "Require Valid Target"
--[[Translation missing --]]
L["Resist"] = "Resist"
--[[Translation missing --]]
L["Resisted"] = "Resisted"
--[[Translation missing --]]
L["Resolve collisions dialog"] = "Resolve collisions dialog"
--[[Translation missing --]]
L["Resolve collisions dialog singular"] = "Resolve collisions dialog singular"
--[[Translation missing --]]
L["Resolve collisions dialog startup"] = "Resolve collisions dialog startup"
--[[Translation missing --]]
L["Resolve collisions dialog startup singular"] = "Resolve collisions dialog startup singular"
--[[Translation missing --]]
L["Rested"] = "Rested"
--[[Translation missing --]]
L["Rested Experience"] = "Rested Experience"
--[[Translation missing --]]
L["Rested Experience (%)"] = "Rested Experience (%)"
--[[Translation missing --]]
L["Resting"] = "Resting"
--[[Translation missing --]]
L["Resurrect"] = "Resurrect"
--[[Translation missing --]]
L["Right"] = "Right"
--[[Translation missing --]]
L["Right to Left"] = "Right to Left"
--[[Translation missing --]]
L["Right, then Down"] = "Right, then Down"
--[[Translation missing --]]
L["Right, then Up"] = "Right, then Up"
--[[Translation missing --]]
L["Role"] = "Role"
--[[Translation missing --]]
L["Rotate Left"] = "Rotate Left"
--[[Translation missing --]]
L["Rotate Right"] = "Rotate Right"
--[[Translation missing --]]
L["Rotation"] = "Rotation"
--[[Translation missing --]]
L["Round"] = "Round"
--[[Translation missing --]]
L["Round Mode"] = "Round Mode"
--[[Translation missing --]]
L["Ruins of Ahn'Qiraj"] = "Ruins of Ahn'Qiraj"
--[[Translation missing --]]
L["Run Custom Code"] = "Run Custom Code"
--[[Translation missing --]]
L["Rune"] = "Rune"
--[[Translation missing --]]
L["Rune #1"] = "Rune #1"
--[[Translation missing --]]
L["Rune #2"] = "Rune #2"
--[[Translation missing --]]
L["Rune #3"] = "Rune #3"
--[[Translation missing --]]
L["Rune #4"] = "Rune #4"
--[[Translation missing --]]
L["Rune #5"] = "Rune #5"
--[[Translation missing --]]
L["Rune #6"] = "Rune #6"
--[[Translation missing --]]
L["Runes Count"] = "Runes Count"
--[[Translation missing --]]
L["Sapphiron"] = "Sapphiron"
--[[Translation missing --]]
L["Say"] = "Say"
--[[Translation missing --]]
L["Scale"] = "Scale"
--[[Translation missing --]]
L["Scenario"] = "Scenario"
--[[Translation missing --]]
L["Scenario (Heroic)"] = "Scenario (Heroic)"
--[[Translation missing --]]
L["Scenario (Normal)"] = "Scenario (Normal)"
--[[Translation missing --]]
L["Screen/Parent Group"] = "Screen/Parent Group"
--[[Translation missing --]]
L["Second"] = "Second"
--[[Translation missing --]]
L["Second Value of Tooltip Text"] = "Second Value of Tooltip Text"
--[[Translation missing --]]
L["Seconds"] = "Seconds"
--[[Translation missing --]]
L["Select Frame"] = "Select Frame"
--[[Translation missing --]]
L["Separator"] = "Separator"
--[[Translation missing --]]
L["Set IDs can be found on websites such as classic.wowhead.com/item-sets"] = "Set IDs can be found on websites such as classic.wowhead.com/item-sets"
--[[Translation missing --]]
L["Set IDs can be found on websites such as wowhead.com/item-sets"] = "Set IDs can be found on websites such as wowhead.com/item-sets"
--[[Translation missing --]]
L["Set Maximum Progress"] = "Set Maximum Progress"
--[[Translation missing --]]
L["Set Minimum Progress"] = "Set Minimum Progress"
--[[Translation missing --]]
L["Shadow Resistance"] = "Shadow Resistance"
--[[Translation missing --]]
L["Shake"] = "Shake"
--[[Translation missing --]]
L["Shazzrah"] = "Shazzrah"
--[[Translation missing --]]
L["Shift-Click to resume addon execution."] = "Shift-Click to resume addon execution."
--[[Translation missing --]]
L["Show"] = "Show"
--[[Translation missing --]]
L["Show Absorb"] = "Show Absorb"
--[[Translation missing --]]
L["Show CD of Charge"] = "Show CD of Charge"
--[[Translation missing --]]
L["Show Code"] = "Show Code"
--[[Translation missing --]]
L["Show GCD"] = "Show GCD"
--[[Translation missing --]]
L["Show Global Cooldown"] = "Show Global Cooldown"
--[[Translation missing --]]
L["Show Incoming Heal"] = "Show Incoming Heal"
--[[Translation missing --]]
L["Show On"] = "Show On"
--[[Translation missing --]]
L["Show Rested Overlay"] = "Show Rested Overlay"
--[[Translation missing --]]
L["Shrink"] = "Shrink"
--[[Translation missing --]]
L["Silithid Royalty"] = "Silithid Royalty"
--[[Translation missing --]]
L["Simple"] = "Simple"
--[[Translation missing --]]
L["Since Apply"] = "Since Apply"
--[[Translation missing --]]
L["Since Apply/Refresh"] = "Since Apply/Refresh"
--[[Translation missing --]]
L["Since Charge Gain"] = "Since Charge Gain"
--[[Translation missing --]]
L["Since Charge Lost"] = "Since Charge Lost"
--[[Translation missing --]]
L["Since Ready"] = "Since Ready"
--[[Translation missing --]]
L["Since Stack Gain"] = "Since Stack Gain"
--[[Translation missing --]]
L["Since Stack Lost"] = "Since Stack Lost"
--[[Translation missing --]]
L["Size & Position"] = "Size & Position"
--[[Translation missing --]]
L["Slide from Bottom"] = "Slide from Bottom"
--[[Translation missing --]]
L["Slide from Left"] = "Slide from Left"
--[[Translation missing --]]
L["Slide from Right"] = "Slide from Right"
--[[Translation missing --]]
L["Slide from Top"] = "Slide from Top"
--[[Translation missing --]]
L["Slide to Bottom"] = "Slide to Bottom"
--[[Translation missing --]]
L["Slide to Left"] = "Slide to Left"
--[[Translation missing --]]
L["Slide to Right"] = "Slide to Right"
--[[Translation missing --]]
L["Slide to Top"] = "Slide to Top"
--[[Translation missing --]]
L["Slider"] = "Slider"
--[[Translation missing --]]
L["Small"] = "Small"
--[[Translation missing --]]
L["Smart Group"] = "Smart Group"
--[[Translation missing --]]
L["Sound"] = "Sound"
--[[Translation missing --]]
L["Sound by Kit ID"] = "Sound by Kit ID"
--[[Translation missing --]]
L["Source"] = "Source"
--[[Translation missing --]]
L["Source Affiliation"] = "Source Affiliation"
--[[Translation missing --]]
L["Source GUID"] = "Source GUID"
--[[Translation missing --]]
L["Source Name"] = "Source Name"
--[[Translation missing --]]
L["Source NPC Id"] = "Source NPC Id"
--[[Translation missing --]]
L["Source Object Type"] = "Source Object Type"
--[[Translation missing --]]
L["Source Raid Mark"] = "Source Raid Mark"
--[[Translation missing --]]
L["Source Reaction"] = "Source Reaction"
--[[Translation missing --]]
L["Source Unit"] = "Source Unit"
--[[Translation missing --]]
L["Source Unit Name/Realm"] = "Source Unit Name/Realm"
--[[Translation missing --]]
L["Source: "] = "Source: "
--[[Translation missing --]]
L["Space"] = "Space"
--[[Translation missing --]]
L["Spacing"] = "Spacing"
--[[Translation missing --]]
L["Spark"] = "Spark"
--[[Translation missing --]]
L["Spec Role"] = "Spec Role"
--[[Translation missing --]]
L["Specific Type"] = "Specific Type"
--[[Translation missing --]]
L["Specific Unit"] = "Specific Unit"
--[[Translation missing --]]
L["Spell"] = "Spell"
--[[Translation missing --]]
L["Spell (Building)"] = "Spell (Building)"
--[[Translation missing --]]
L["Spell Activation Overlay Glow"] = "Spell Activation Overlay Glow"
--[[Translation missing --]]
L["Spell Cost"] = "Spell Cost"
--[[Translation missing --]]
L["Spell Count"] = "Spell Count"
--[[Translation missing --]]
L["Spell ID"] = "Spell ID"
--[[Translation missing --]]
L["Spell Id"] = "Spell Id"
--[[Translation missing --]]
L["Spell ID:"] = "Spell ID:"
--[[Translation missing --]]
L["Spell IDs:"] = "Spell IDs:"
--[[Translation missing --]]
L["Spell in Range"] = "Spell in Range"
--[[Translation missing --]]
L["Spell Known"] = "Spell Known"
--[[Translation missing --]]
L["Spell Name"] = "Spell Name"
--[[Translation missing --]]
L["Spell Usable"] = "Spell Usable"
--[[Translation missing --]]
L["Spin"] = "Spin"
--[[Translation missing --]]
L["Spiral"] = "Spiral"
--[[Translation missing --]]
L["Spiral In And Out"] = "Spiral In And Out"
--[[Translation missing --]]
L["Stack Count"] = "Stack Count"
--[[Translation missing --]]
L["Stacks"] = "Stacks"
--[[Translation missing --]]
L["Stagger Scale"] = "Stagger Scale"
--[[Translation missing --]]
L["Stamina"] = "Stamina"
--[[Translation missing --]]
L["Stance/Form/Aura"] = "Stance/Form/Aura"
--[[Translation missing --]]
L["Standing"] = "Standing"
--[[Translation missing --]]
L["Star Shake"] = "Star Shake"
--[[Translation missing --]]
L["Start"] = "Start"
--[[Translation missing --]]
L["Start Now"] = "Start Now"
--[[Translation missing --]]
L["Status"] = "Status"
--[[Translation missing --]]
L["Stolen"] = "Stolen"
--[[Translation missing --]]
L["Stop"] = "Stop"
--[[Translation missing --]]
L["Strength"] = "Strength"
--[[Translation missing --]]
L["String"] = "String"
--[[Translation missing --]]
L["Subtract Cast"] = "Subtract Cast"
--[[Translation missing --]]
L["Subtract Channel"] = "Subtract Channel"
--[[Translation missing --]]
L["Subtract GCD"] = "Subtract GCD"
--[[Translation missing --]]
L["Sulfuron Harbinger"] = "Sulfuron Harbinger"
--[[Translation missing --]]
L["Summon"] = "Summon"
--[[Translation missing --]]
L["Supports multiple entries, separated by commas"] = "Supports multiple entries, separated by commas"
--[[Translation missing --]]
L[ [=[Supports multiple entries, separated by commas
]=] ] = [=[Supports multiple entries, separated by commas
]=]
--[[Translation missing --]]
L["Supports multiple entries, separated by commas. Group Zone IDs must be prefixed with 'g', e.g. g277."] = "Supports multiple entries, separated by commas. Group Zone IDs must be prefixed with 'g', e.g. g277."
--[[Translation missing --]]
L["Swing"] = "Swing"
--[[Translation missing --]]
L["Swing Timer"] = "Swing Timer"
--[[Translation missing --]]
L["Swipe"] = "Swipe"
--[[Translation missing --]]
L["System"] = "System"
--[[Translation missing --]]
L["Tab "] = "Tab "
--[[Translation missing --]]
L["Talent"] = "Talent"
--[[Translation missing --]]
L["Talent |cFFFF0000Not|r Known"] = "Talent |cFFFF0000Not|r Known"
--[[Translation missing --]]
L["Talent |cFFFF0000Not|r Selected"] = "Talent |cFFFF0000Not|r Selected"
--[[Translation missing --]]
L["Talent Known"] = "Talent Known"
--[[Translation missing --]]
L["Talent Selected"] = "Talent Selected"
--[[Translation missing --]]
L["Talent selected"] = "Talent selected"
--[[Translation missing --]]
L["Talent Specialization"] = "Talent Specialization"
--[[Translation missing --]]
L["Tanking And Highest"] = "Tanking And Highest"
--[[Translation missing --]]
L["Tanking But Not Highest"] = "Tanking But Not Highest"
--[[Translation missing --]]
L["Target"] = "Target"
--[[Translation missing --]]
L["Targeted"] = "Targeted"
--[[Translation missing --]]
L["Text"] = "Text"
--[[Translation missing --]]
L["Thaddius"] = "Thaddius"
--[[Translation missing --]]
L["The aura has overwritten the global '%s', this might affect other auras."] = "The aura has overwritten the global '%s', this might affect other auras."
--[[Translation missing --]]
L["The effective level differs from the level in e.g. Time Walking dungeons."] = "The effective level differs from the level in e.g. Time Walking dungeons."
--[[Translation missing --]]
L["The Four Horsemen"] = "The Four Horsemen"
--[[Translation missing --]]
L["The Prophet Skeram"] = "The Prophet Skeram"
--[[Translation missing --]]
L["The trigger number is optional, and uses the trigger providing dynamic information if not specified."] = "The trigger number is optional, and uses the trigger providing dynamic information if not specified."
--[[Translation missing --]]
L["There are %i updates to your auras ready to be installed!"] = "There are %i updates to your auras ready to be installed!"
--[[Translation missing --]]
L["Thick Outline"] = "Thick Outline"
--[[Translation missing --]]
L["Thickness"] = "Thickness"
--[[Translation missing --]]
L["Third"] = "Third"
--[[Translation missing --]]
L["Third Value of Tooltip Text"] = "Third Value of Tooltip Text"
--[[Translation missing --]]
L["This aura contains custom Lua code."] = "This aura contains custom Lua code."
--[[Translation missing --]]
L["This aura has legacy aura trigger(s), which are no longer supported."] = "This aura has legacy aura trigger(s), which are no longer supported."
--[[Translation missing --]]
L["This aura was created with a newer version of WeakAuras."] = "This aura was created with a newer version of WeakAuras."
--[[Translation missing --]]
L["This aura was created with the Classic version of World of Warcraft."] = "This aura was created with the Classic version of World of Warcraft."
--[[Translation missing --]]
L["This aura was created with the retail version of World of Warcraft."] = "This aura was created with the retail version of World of Warcraft."
--[[Translation missing --]]
L["This is a modified version of your aura, |cff9900FF%s.|r"] = "This is a modified version of your aura, |cff9900FF%s.|r"
--[[Translation missing --]]
L["This is a modified version of your group, |cff9900FF%s.|r"] = "This is a modified version of your group, |cff9900FF%s.|r"
--[[Translation missing --]]
L["Threat Percent"] = "Threat Percent"
--[[Translation missing --]]
L["Threat Situation"] = "Threat Situation"
--[[Translation missing --]]
L["Threat Value"] = "Threat Value"
--[[Translation missing --]]
L["Tick"] = "Tick"
--[[Translation missing --]]
L["Tier "] = "Tier "
--[[Translation missing --]]
L["Time Format"] = "Time Format"
--[[Translation missing --]]
L["Time in GCDs"] = "Time in GCDs"
--[[Translation missing --]]
L["Timed"] = "Timed"
--[[Translation missing --]]
L["Timer Id"] = "Timer Id"
--[[Translation missing --]]
L["Toggle"] = "Toggle"
--[[Translation missing --]]
L["Toggle List"] = "Toggle List"
--[[Translation missing --]]
L["Toggle Options Window"] = "Toggle Options Window"
--[[Translation missing --]]
L["Toggle Performance Profiling Window"] = "Toggle Performance Profiling Window"
--[[Translation missing --]]
L["Tooltip"] = "Tooltip"
--[[Translation missing --]]
L["Tooltip Value 1"] = "Tooltip Value 1"
--[[Translation missing --]]
L["Tooltip Value 2"] = "Tooltip Value 2"
--[[Translation missing --]]
L["Tooltip Value 3"] = "Tooltip Value 3"
--[[Translation missing --]]
L["Top"] = "Top"
--[[Translation missing --]]
L["Top Left"] = "Top Left"
--[[Translation missing --]]
L["Top Right"] = "Top Right"
--[[Translation missing --]]
L["Top to Bottom"] = "Top to Bottom"
--[[Translation missing --]]
L["Torghast"] = "Torghast"
--[[Translation missing --]]
L["Total"] = "Total"
--[[Translation missing --]]
L["Total Duration"] = "Total Duration"
--[[Translation missing --]]
L["Total Experience"] = "Total Experience"
--[[Translation missing --]]
L["Total Match Count"] = "Total Match Count"
--[[Translation missing --]]
L["Total Stacks"] = "Total Stacks"
--[[Translation missing --]]
L["Total stacks over all matches"] = "Total stacks over all matches"
--[[Translation missing --]]
L["Total Unit Count"] = "Total Unit Count"
--[[Translation missing --]]
L["Total Units"] = "Total Units"
--[[Translation missing --]]
L["Totem"] = "Totem"
--[[Translation missing --]]
L["Totem #%i"] = "Totem #%i"
--[[Translation missing --]]
L["Totem Name"] = "Totem Name"
--[[Translation missing --]]
L["Totem Name Pattern Match"] = "Totem Name Pattern Match"
--[[Translation missing --]]
L["Totem Number"] = "Totem Number"
--[[Translation missing --]]
L["Track Cooldowns"] = "Track Cooldowns"
--[[Translation missing --]]
L["Tracking Charge %i"] = "Tracking Charge %i"
--[[Translation missing --]]
L["Tracking Charge CDs"] = "Tracking Charge CDs"
--[[Translation missing --]]
L["Tracking Only Cooldown"] = "Tracking Only Cooldown"
--[[Translation missing --]]
L["Transmission error"] = "Transmission error"
--[[Translation missing --]]
L["Trigger"] = "Trigger"
--[[Translation missing --]]
L["Trigger %i"] = "Trigger %i"
--[[Translation missing --]]
L["Trigger 1"] = "Trigger 1"
--[[Translation missing --]]
L["Trigger State Updater (Advanced)"] = "Trigger State Updater (Advanced)"
--[[Translation missing --]]
L["Trigger Update"] = "Trigger Update"
--[[Translation missing --]]
L["Trigger:"] = "Trigger:"
--[[Translation missing --]]
L["Trivial (Low Level)"] = "Trivial (Low Level)"
--[[Translation missing --]]
L["True"] = "True"
--[[Translation missing --]]
L["Twin Emperors"] = "Twin Emperors"
--[[Translation missing --]]
L["Type"] = "Type"
--[[Translation missing --]]
L["Unaffected"] = "Unaffected"
--[[Translation missing --]]
L["Undefined"] = "Undefined"
--[[Translation missing --]]
L["Unit"] = "Unit"
--[[Translation missing --]]
L["Unit Characteristics"] = "Unit Characteristics"
--[[Translation missing --]]
L["Unit Destroyed"] = "Unit Destroyed"
--[[Translation missing --]]
L["Unit Died"] = "Unit Died"
--[[Translation missing --]]
L["Unit Dissipates"] = "Unit Dissipates"
--[[Translation missing --]]
L["Unit Frame"] = "Unit Frame"
--[[Translation missing --]]
L["Unit Frames"] = "Unit Frames"
--[[Translation missing --]]
L["Unit is Unit"] = "Unit is Unit"
--[[Translation missing --]]
L["Unit Name"] = "Unit Name"
--[[Translation missing --]]
L["Unit Name/Realm"] = "Unit Name/Realm"
--[[Translation missing --]]
L["Units Affected"] = "Units Affected"
--[[Translation missing --]]
L["Unlimited"] = "Unlimited"
--[[Translation missing --]]
L["Up"] = "Up"
--[[Translation missing --]]
L["Up, then Left"] = "Up, then Left"
--[[Translation missing --]]
L["Up, then Right"] = "Up, then Right"
--[[Translation missing --]]
L["Update Auras"] = "Update Auras"
--[[Translation missing --]]
L["Usage:"] = "Usage:"
--[[Translation missing --]]
L["Use /wa minimap to show the minimap icon again."] = "Use /wa minimap to show the minimap icon again."
--[[Translation missing --]]
L["Use Custom Color"] = "Use Custom Color"
--[[Translation missing --]]
L["Vaelastrasz the Corrupt"] = "Vaelastrasz the Corrupt"
--[[Translation missing --]]
L["Value"] = "Value"
--[[Translation missing --]]
L["Values/Remaining Time above this value are displayed as full progress."] = "Values/Remaining Time above this value are displayed as full progress."
--[[Translation missing --]]
L["Values/Remaining Time below this value are displayed as no progress."] = "Values/Remaining Time below this value are displayed as no progress."
--[[Translation missing --]]
L["Versatility (%)"] = "Versatility (%)"
--[[Translation missing --]]
L["Versatility Rating"] = "Versatility Rating"
--[[Translation missing --]]
L["Version: "] = "Version: "
--[[Translation missing --]]
L["Viscidus"] = "Viscidus"
--[[Translation missing --]]
L["Visibility"] = "Visibility"
--[[Translation missing --]]
L["Visions of N'Zoth"] = "Visions of N'Zoth"
--[[Translation missing --]]
L["War Mode Active"] = "War Mode Active"
--[[Translation missing --]]
L["Warfront (Heroic)"] = "Warfront (Heroic)"
--[[Translation missing --]]
L["Warfront (Normal)"] = "Warfront (Normal)"
--[[Translation missing --]]
L["Warning"] = "Warning"
--[[Translation missing --]]
L["Warning for unknown aura:"] = "Warning for unknown aura:"
--[[Translation missing --]]
L["Warning: Full Scan auras checking for both name and spell id can't be converted."] = "Warning: Full Scan auras checking for both name and spell id can't be converted."
--[[Translation missing --]]
L["Warning: Name info is now available via %affected, %unaffected. Number of affected group members via %unitCount. Some options behave differently now. This is not automatically adjusted."] = "Warning: Name info is now available via %affected, %unaffected. Number of affected group members via %unitCount. Some options behave differently now. This is not automatically adjusted."
--[[Translation missing --]]
L["Warning: Tooltip values are now available via %tooltip1, %tooltip2, %tooltip3 instead of %s. This is not automatically adjusted."] = "Warning: Tooltip values are now available via %tooltip1, %tooltip2, %tooltip3 instead of %s. This is not automatically adjusted."
--[[Translation missing --]]
L["WeakAuras Built-In (63:42 | 3:07 | 10 | 2.4)"] = "WeakAuras Built-In (63:42 | 3:07 | 10 | 2.4)"
--[[Translation missing --]]
L["WeakAuras has encountered an error during the login process. Please report this issue at https://github.com/WeakAuras/Weakauras2/issues/new."] = "WeakAuras has encountered an error during the login process. Please report this issue at https://github.com/WeakAuras/Weakauras2/issues/new."
--[[Translation missing --]]
L["WeakAuras Profiling"] = "WeakAuras Profiling"
--[[Translation missing --]]
L["WeakAuras Profiling Report"] = "WeakAuras Profiling Report"
--[[Translation missing --]]
L["Weapon"] = "Weapon"
--[[Translation missing --]]
L["Weapon Enchant"] = "Weapon Enchant"
--[[Translation missing --]]
L["Weapon Enchant / Fishing Lure"] = "Weapon Enchant / Fishing Lure"
--[[Translation missing --]]
L["What do you want to do?"] = "What do you want to do?"
--[[Translation missing --]]
L["Whisper"] = "Whisper"
--[[Translation missing --]]
L["Whole Area"] = "Whole Area"
--[[Translation missing --]]
L["Width"] = "Width"
--[[Translation missing --]]
L["Wobble"] = "Wobble"
--[[Translation missing --]]
L["World Boss"] = "World Boss"
--[[Translation missing --]]
L["Wrap"] = "Wrap"
--[[Translation missing --]]
L["Writing to the WeakAuras table is not allowed."] = "Writing to the WeakAuras table is not allowed."
--[[Translation missing --]]
L["X-Offset"] = "X-Offset"
--[[Translation missing --]]
L["Yell"] = "Yell"
--[[Translation missing --]]
L["Y-Offset"] = "Y-Offset"
--[[Translation missing --]]
L["You already have this group/aura. Importing will create a duplicate."] = "You already have this group/aura. Importing will create a duplicate."
--[[Translation missing --]]
L["Your next encounter will automatically be profiled."] = "Your next encounter will automatically be profiled."
--[[Translation missing --]]
L["Your next instance of combat will automatically be profiled."] = "Your next instance of combat will automatically be profiled."
--[[Translation missing --]]
L["Your scheduled automatic profile has been cancelled."] = "Your scheduled automatic profile has been cancelled."
--[[Translation missing --]]
L["Your threat as a percentage of the tank's current threat."] = "Your threat as a percentage of the tank's current threat."
--[[Translation missing --]]
L["Your threat on the mob as a percentage of the amount required to pull aggro. Will pull aggro at 100."] = "Your threat on the mob as a percentage of the amount required to pull aggro. Will pull aggro at 100."
--[[Translation missing --]]
L["Your total threat on the mob."] = "Your total threat on the mob."
--[[Translation missing --]]
L["Zone ID(s)"] = "Zone ID(s)"
--[[Translation missing --]]
L["Zone Name"] = "Zone Name"
--[[Translation missing --]]
L["Zoom"] = "Zoom"
--[[Translation missing --]]
L["Zul'Gurub"] = "Zul'Gurub"

