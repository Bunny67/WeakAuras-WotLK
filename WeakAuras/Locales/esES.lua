if not(GetLocale() == "esES") then
  return
end

local L = WeakAuras.L

-- WeakAuras
L["   • %d auras added"] = "• %d auras añadidas"
L["   • %d auras deleted"] = "• %d auras eliminadas"
L["   • %d auras modified"] = "• %d auras modificadas"
L[ [=[ Filter formats: 'Name', 'Name-Realm', '-Realm'. 

Supports multiple entries, separated by commas
]=] ] = "Formatos de filtro: 'Nombre', 'Nombre-Reino', '-Reino'. Admite múltiples entradas, separadas por comas"
L[ [=[

Supports multiple entries, separated by commas]=] ] = "Admite múltiples entradas, separadas por comas"
L["%s - %i. Trigger"] = "%s - %i. Desencadenador"
L["%s - Alpha Animation"] = "%s - Animación alfa"
L["%s - Color Animation"] = "%s - Animación de color"
L["%s - Condition Custom Chat"] = "%s - Condición chat personalizado"
L["%s - Custom Text"] = "%s - Texto personalizado"
L["%s - Finish"] = "%s - Terminar"
L["%s - Finish Action"] = "%s - Terminar acción"
L["%s - Finish Custom Text"] = "%s - Finalizar texto personalizado"
L["%s - Init Action"] = "%s - Iniciar acción "
L["%s - Main"] = "%s - Principal"
L["%s - Rotate Animation"] = "%s - Rotar animación"
L["%s - Scale Animation"] = "%s - Ajustar tamaño de la animación"
L["%s - Start"] = "%s - Comenzar"
L["%s - Start Action"] = "%s - Iniciar acción"
L["%s - Start Custom Text"] = "%s - Iniciar texto personalizado"
L["%s - Translate Animation"] = "%s - Traducir animación"
L["%s - Trigger Logic"] = "%s - Lógica del desencadenador"
L["%s Duration Function"] = "%s Duración de la función"
L["%s Icon Function"] = "%s Icono de la función"
L["%s Name Function"] = "%s Nombre de la función"
L["%s Overlay Color"] = "%s Color de superposición"
L["%s Stacks Function"] = "%s Función de Acumulación"
L["%s Texture Function"] = "%s Función de la textura"
L["%s total auras"] = "%s Auras totales"
L["%s Trigger Function"] = "%s Activar función"
L["%s Untrigger Function"] = "%s Desactivar función"
L["* Suffix"] = "* Sufijo"
L["/wa help - Show this message"] = "/wa help - Muestra este mensaje"
L["/wa minimap - Toggle the minimap icon"] = "/wa minimap - Muestra/oculta el botón del minimapa"
L["/wa pprint - Show the results from the most recent profiling"] = "/wa pprint - Muestra los resultados de los perfiles más recientes"
L["/wa pstart - Start profiling. Optionally include a duration in seconds after which profiling automatically stops. To profile the next combat/encounter, pass a \"combat\" or \"encounter\" argument."] = "/wa pstart: inicia perfilados. Opcionalmente, incluya una duración en segundos después de la cual perfilado se detiene automáticamente. Para perfilar el próximo combate/encuentro, pase un argumento de \"combate\" o \"encuentro\"."
L["/wa pstop - Finish profiling"] = "/wa pstop - Finalizar perfilado"
L["/wa repair - Repair tool"] = "/wa repair - Herramienta de reparación"
L["|cffeda55fLeft-Click|r to toggle showing the main window."] = "|cffeda55fClic derecho|r para mostrar la ventana principal."
L["|cffeda55fMiddle-Click|r to toggle the minimap icon on or off."] = "|cffeda55fClic central|r para mostrar/ocultar el icono del minimapa."
--[[Translation missing --]]
L["|cffeda55fRight-Click|r to toggle performance profiling window."] = "|cffeda55fRight-Click|r to toggle performance profiling window."
L["|cffeda55fShift-Click|r to pause addon execution."] = "|cffeda55fMayús clic|r para pausar la ejecución del addon."
--[[Translation missing --]]
L["|cFFFF0000Not|r Item Bonus Id Equipped"] = "|cFFFF0000Not|r Item Bonus Id Equipped"
--[[Translation missing --]]
L["|cFFFF0000Not|r Player Name/Realm"] = "|cFFFF0000Not|r Player Name/Realm"
--[[Translation missing --]]
L["|cFFffcc00Extra Options:|r %s"] = "|cFFffcc00Extra Options:|r %s"
--[[Translation missing --]]
L["|cFFffcc00Extra Options:|r None"] = "|cFFffcc00Extra Options:|r None"
L["10 Man Raid"] = "Banda de 10 Jugadores"
--[[Translation missing --]]
L["10 Player Raid (Heroic)"] = "10 Player Raid (Heroic)"
--[[Translation missing --]]
L["10 Player Raid (Normal)"] = "10 Player Raid (Normal)"
L["20 Man Raid"] = "Banda de 20 jugadores"
L["25 Man Raid"] = "Banda de 25 Jugadores"
--[[Translation missing --]]
L["25 Player Raid (Heroic)"] = "25 Player Raid (Heroic)"
--[[Translation missing --]]
L["25 Player Raid (Normal)"] = "25 Player Raid (Normal)"
L["40 Man Raid"] = "Banda de 40 jugadores"
--[[Translation missing --]]
L["40 Player Raid"] = "40 Player Raid"
L["5 Man Dungeon"] = "Mazmorra de 5 jugadores"
L["Abbreviate"] = "Abreviar"
L["AbbreviateLargeNumbers (Blizzard)"] = "AbreviarNúmerosGrandes (Blizzard)"
L["AbbreviateNumbers (Blizzard)"] = "AbreviarNúmeros (Blizzard)"
L["Absorb"] = "Absorción"
L["Absorb Display"] = "Mostrar absorción"
L["Absorbed"] = "Absorbido"
L["Action Button Glow"] = "Botón de acción resplandeciente"
L["Action Usable"] = "Acción Utilizable"
L["Actions"] = "Acciones"
L["Active"] = "Activo"
L["Add"] = "Añadir"
L["Add Missing Auras"] = "Añadir auras perdidas"
L["Additional Trigger Replacements"] = "Remplazos de disparadores adicionales"
L["Affected"] = "Afectado"
L["Affected Unit Count"] = "Recuento de unidades afectadas"
L["Aggro"] = "Amenaza"
L["Agility"] = "Agilidad"
L["Ahn'Qiraj"] = "Ahn'Qiraj"
L["Alert Type"] = "Tipo de alerta"
L["Alive"] = "Vivo"
L["All"] = "Todo"
L["All Triggers"] = "Todos los Disparadores"
L["Alliance"] = "Alianza"
L["Allow partial matches"] = "Permitir coincidencias parciales"
L["Alpha"] = "Transparencia"
L["Alternate Power"] = "Energía Alternativa"
L["Always"] = "Siempre"
L["Always active trigger"] = "Siempre activar disparador"
L["Always include realm"] = "Incluir siempre el reino"
--[[Translation missing --]]
L["Always True"] = "Always True"
L["Amount"] = "Cantidad"
--[[Translation missing --]]
L["And Talent"] = "And Talent"
--[[Translation missing --]]
L["Animations"] = "Animations"
L["Anticlockwise"] = "Sentido antihorario"
--[[Translation missing --]]
L["Anub'Rekhan"] = "Anub'Rekhan"
L["Any"] = "Cualquiera"
L["Any Triggers"] = "Cualquier Disparador"
--[[Translation missing --]]
L["AOE"] = "AOE"
--[[Translation missing --]]
L["Arcane Resistance"] = "Arcane Resistance"
L["Arena"] = "Arena"
L["Armor (%)"] = "Armadura (%)"
--[[Translation missing --]]
L["Armor against Target (%)"] = "Armor against Target (%)"
--[[Translation missing --]]
L["Armor Rating"] = "Armor Rating"
--[[Translation missing --]]
L["Array"] = "Array"
L["Ascending"] = "Ascendente"
--[[Translation missing --]]
L["Assigned Role"] = "Assigned Role"
L["At Least One Enemy"] = "Como Mínimo un Enemigo"
--[[Translation missing --]]
L["At missing Value"] = "At missing Value"
--[[Translation missing --]]
L["At Percent"] = "At Percent"
--[[Translation missing --]]
L["At Value"] = "At Value"
--[[Translation missing --]]
L["Attach to End"] = "Attach to End"
--[[Translation missing --]]
L["Attach to Start"] = "Attach to Start"
--[[Translation missing --]]
L["Attack Power"] = "Attack Power"
L["Attackable"] = "Atacable"
--[[Translation missing --]]
L["Attackable Target"] = "Attackable Target"
L["Aura"] = "Aura"
--[[Translation missing --]]
L["Aura '%s': %s"] = "Aura '%s': %s"
L["Aura Applied"] = "Aura Aplicada"
L["Aura Applied Dose"] = "Aura Aplicada Dosis"
L["Aura Broken"] = "Aura Rota"
L["Aura Broken Spell"] = "Aura Hechizo Roto"
L["Aura Name"] = "Nombre del Aura o ID"
--[[Translation missing --]]
L["Aura Names"] = "Aura Names"
L["Aura Refresh"] = "Aura Refrescada"
L["Aura Removed"] = "Aura Eliminada"
L["Aura Removed Dose"] = "Aura Eliminada Dosis"
L["Aura Stack"] = "Acumulación de Auras"
L["Aura Type"] = "Tipo de Aura"
--[[Translation missing --]]
L["Aura(s) Found"] = "Aura(s) Found"
--[[Translation missing --]]
L["Aura(s) Missing"] = "Aura(s) Missing"
L["Aura:"] = "Aura:"
L["Auras:"] = "Auras:"
--[[Translation missing --]]
L["Author Options"] = "Author Options"
--[[Translation missing --]]
L["Auto"] = "Auto"
--[[Translation missing --]]
L["Autocast Shine"] = "Autocast Shine"
L["Automatic"] = "Automático"
--[[Translation missing --]]
L["Automatic Length"] = "Automatic Length"
--[[Translation missing --]]
L["Automatic Repair Confirmation Dialog"] = "Automatic Repair Confirmation Dialog"
--[[Translation missing --]]
L["Automatic Rotation"] = "Automatic Rotation"
--[[Translation missing --]]
L["Avoidance (%)"] = "Avoidance (%)"
--[[Translation missing --]]
L["Avoidance Rating"] = "Avoidance Rating"
--[[Translation missing --]]
L["Ayamiss the Hunter"] = "Ayamiss the Hunter"
L["Back and Forth"] = "De Atrás a Adelante"
--[[Translation missing --]]
L["Background"] = "Background"
--[[Translation missing --]]
L["Background Color"] = "Background Color"
--[[Translation missing --]]
L["Bar Color"] = "Bar Color"
--[[Translation missing --]]
L["Baron Geddon"] = "Baron Geddon"
L["Battle.net Whisper"] = "Battle.net Mensaje"
L["Battleground"] = "Campo de Batalla"
--[[Translation missing --]]
L["Battleguard Sartura"] = "Battleguard Sartura"
--[[Translation missing --]]
L["BG>Raid>Party>Say"] = "BG>Raid>Party>Say"
L["BG-System Alliance"] = "Campo de Batalla - Alianza"
L["BG-System Horde"] = "Campo de Batalla - Horda"
L["BG-System Neutral"] = "Campo de Batalla - Neutral"
--[[Translation missing --]]
L["Big Number"] = "Big Number"
L["BigWigs Addon"] = "Addon de BigWigs"
--[[Translation missing --]]
L["BigWigs Message"] = "BigWigs Message"
L["BigWigs Timer"] = "Temporizador de BigWigs"
--[[Translation missing --]]
L["Black Wing Lair"] = "Black Wing Lair"
--[[Translation missing --]]
L["Blizzard (2h | 3m | 10s | 2.4)"] = "Blizzard (2h | 3m | 10s | 2.4)"
L["Blizzard Combat Text"] = "Texto de Combate de Blizzard"
L["Block"] = "Bloqueo"
--[[Translation missing --]]
L["Block (%)"] = "Block (%)"
--[[Translation missing --]]
L["Block against Target (%)"] = "Block against Target (%)"
L["Blocked"] = "Bloqueado"
--[[Translation missing --]]
L["Bloodlord Mandokir"] = "Bloodlord Mandokir"
--[[Translation missing --]]
L["Border"] = "Border"
--[[Translation missing --]]
L["Boss"] = "Boss"
L["Boss Emote"] = "Jefe - Emoción"
--[[Translation missing --]]
L["Boss Whisper"] = "Boss Whisper"
L["Bottom"] = "Abajo"
L["Bottom Left"] = "Abajo Izquierda"
L["Bottom Right"] = "Abajo Derecha"
L["Bottom to Top"] = "De Abajo a Arriba"
L["Bounce"] = "Rebotar"
L["Bounce with Decay"] = "Rebotar con Amortiguación"
--[[Translation missing --]]
L["Broodlord Lashlayer"] = "Broodlord Lashlayer"
L["Buff"] = "Beneficio"
L["Buffed/Debuffed"] = "Beneficio activo/Perjuicio activo"
--[[Translation missing --]]
L["Buru the Gorger"] = "Buru the Gorger"
--[[Translation missing --]]
L["Can be used for e.g. checking if \"boss1target\" is the same as \"player\"."] = "Can be used for e.g. checking if \"boss1target\" is the same as \"player\"."
--[[Translation missing --]]
L["Cancel"] = "Cancel"
--[[Translation missing --]]
L["Can't schedule timer with %i, due to a World of Warcraft bug with high computer uptime. (Uptime: %i). Please restart your computer."] = "Can't schedule timer with %i, due to a World of Warcraft bug with high computer uptime. (Uptime: %i). Please restart your computer."
L["Cast"] = "Lanzar Hechizo"
--[[Translation missing --]]
L["Cast Bar"] = "Cast Bar"
L["Cast Failed"] = "Hechizo - Fallido"
L["Cast Start"] = "Hechizo - Empezar"
L["Cast Success"] = "Hechizo - Completado"
L["Cast Type"] = "Tipo de Hechizo"
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
L["Centered Horizontal"] = "Centrado Horizontal"
L["Centered Vertical"] = "Centrado Vertical"
--[[Translation missing --]]
L["Changed"] = "Changed"
L["Channel"] = "Canal"
L["Channel (Spell)"] = "Canalizar Hechizo"
--[[Translation missing --]]
L["Character Stats"] = "Character Stats"
L["Character Type"] = "Tipo de Personaje"
--[[Translation missing --]]
L["Charge gained/lost"] = "Charge gained/lost"
--[[Translation missing --]]
L["Charged Combo Point"] = "Charged Combo Point"
L["Charges"] = "Cargas"
--[[Translation missing --]]
L["Charges Changed Event"] = "Charges Changed Event"
L["Chat Frame"] = "Pantalla de Chat"
L["Chat Message"] = "Mensaje de Chat"
L["Children:"] = "Hijos:"
--[[Translation missing --]]
L["Choose a category"] = "Choose a category"
--[[Translation missing --]]
L["Chromaggus"] = "Chromaggus"
L["Circle"] = "Círculo"
--[[Translation missing --]]
L["Clamp"] = "Clamp"
L["Class"] = "Clase"
--[[Translation missing --]]
L["Class and Specialization"] = "Class and Specialization"
--[[Translation missing --]]
L["Classification"] = "Classification"
--[[Translation missing --]]
L["Clockwise"] = "Clockwise"
--[[Translation missing --]]
L["Clone per Event"] = "Clone per Event"
--[[Translation missing --]]
L["Clone per Match"] = "Clone per Match"
--[[Translation missing --]]
L["Color"] = "Color"
L["Combat Log"] = "Registro de Combate"
L["Conditions"] = "Condiciones"
L["Contains"] = "Contiene"
--[[Translation missing --]]
L["Continuously update Movement Speed"] = "Continuously update Movement Speed"
--[[Translation missing --]]
L["Cooldown"] = "Cooldown"
L["Cooldown Progress (Item)"] = "Recarga en Progreso (Objeto)"
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
L["Create"] = "Crear"
--[[Translation missing --]]
L["Create a Copy"] = "Create a Copy"
L["Critical"] = "Crítico"
--[[Translation missing --]]
L["Critical (%)"] = "Critical (%)"
--[[Translation missing --]]
L["Critical Rating"] = "Critical Rating"
L["Crowd Controlled"] = "Bajo Control"
L["Crushing"] = "Golpe Aplastador"
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
L["Curse"] = "Maldición"
L["Custom"] = "Personalizado"
--[[Translation missing --]]
L["Custom Check"] = "Custom Check"
--[[Translation missing --]]
L["Custom Color"] = "Custom Color"
--[[Translation missing --]]
L["Custom Configuration"] = "Custom Configuration"
L["Custom Function"] = "Función Personalizada"
L["Damage"] = "Daño"
L["Damage Shield"] = "Escudo Dañino"
L["Damage Shield Missed"] = "Escudo Dañino Fallido"
L["Damage Split"] = "Daño Repartido"
L["DBM Announce"] = "Anuncio de DBM"
L["DBM Timer"] = "Temporizador de DBM"
L["Death Knight Rune"] = "Caballero de la Muerte - Runa"
L["Debuff"] = "Perjuicio"
L["Debuff Class"] = "Clase del perjuicio"
L["Debuff Class Icon"] = "Icono de clase del perjuicio"
L["Debuff Type"] = "Tipo de Perjuicio"
L["Deflect"] = "Desviar"
--[[Translation missing --]]
L["Desaturate"] = "Desaturate"
--[[Translation missing --]]
L["Desaturate Background"] = "Desaturate Background"
--[[Translation missing --]]
L["Desaturate Foreground"] = "Desaturate Foreground"
L["Descending"] = "Descendente"
--[[Translation missing --]]
L["Description"] = "Description"
--[[Translation missing --]]
L["Dest Raid Mark"] = "Dest Raid Mark"
--[[Translation missing --]]
L["Destination Affiliation"] = "Destination Affiliation"
--[[Translation missing --]]
L["Destination GUID"] = "Destination GUID"
L["Destination Name"] = "Nombre del Destino"
--[[Translation missing --]]
L["Destination NPC Id"] = "Destination NPC Id"
--[[Translation missing --]]
L["Destination Object Type"] = "Destination Object Type"
--[[Translation missing --]]
L["Destination Reaction"] = "Destination Reaction"
L["Destination Unit"] = "Unidad de Destino"
--[[Translation missing --]]
L["Disable Spell Known Check"] = "Disable Spell Known Check"
--[[Translation missing --]]
L["Disabled Spell Known Check"] = "Disabled Spell Known Check"
L["Disease"] = "Enfermedad"
L["Dispel"] = "Disipar"
L["Dispel Failed"] = "Disipar Fallido"
--[[Translation missing --]]
L["Display"] = "Display"
--[[Translation missing --]]
L["Distance"] = "Distance"
L["Dodge"] = "Esquivar"
--[[Translation missing --]]
L["Dodge (%)"] = "Dodge (%)"
--[[Translation missing --]]
L["Dodge Rating"] = "Dodge Rating"
L["Done"] = "Finalizado"
L["Down"] = "Abajo"
--[[Translation missing --]]
L["Down, then Left"] = "Down, then Left"
--[[Translation missing --]]
L["Down, then Right"] = "Down, then Right"
L["Drain"] = "Drenar"
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
L["Durability Damage"] = "Daño a la Durabilidad"
L["Durability Damage All"] = "Daño a la Durabilidad Total"
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
L["Emote"] = "Emocion"
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
L["Energize"] = "Vigorizar"
L["Enrage"] = "Enfurecido"
--[[Translation missing --]]
L["Enter static or relative values with %"] = "Enter static or relative values with %"
--[[Translation missing --]]
L["Entering"] = "Entering"
--[[Translation missing --]]
L["Entering/Leaving Combat"] = "Entering/Leaving Combat"
--[[Translation missing --]]
L["Entry Order"] = "Entry Order"
L["Environment Type"] = "Tipo de Entorno"
L["Environmental"] = "Ambiental"
--[[Translation missing --]]
L["Equipment Set"] = "Equipment Set"
--[[Translation missing --]]
L["Equipment Set Equipped"] = "Equipment Set Equipped"
--[[Translation missing --]]
L["Equipment Slot"] = "Equipment Slot"
--[[Translation missing --]]
L["Equipped"] = "Equipped"
--[[Translation missing --]]
L["Error"] = "Error"
--[[Translation missing --]]
L["Error Frame"] = "Error Frame"
--[[Translation missing --]]
L["Error not receiving display information from %s"] = "Error not receiving display information from %s"
--[[Translation missing --]]
L[ [=['ERROR: Anchoring %s': 
]=] ] = [=['ERROR: Anchoring %s': 
]=]
L["Evade"] = "Evadir"
L["Event"] = "Evento"
L["Event(s)"] = "Evento(s)"
L["Every Frame"] = "Cada Uno de los Marcos"
--[[Translation missing --]]
L["Every Frame (High CPU usage)"] = "Every Frame (High CPU usage)"
--[[Translation missing --]]
L["Experience (%)"] = "Experience (%)"
--[[Translation missing --]]
L["Extend Outside"] = "Extend Outside"
L["Extra Amount"] = "Cantidad Adicional"
L["Extra Attacks"] = "Ataques Adicional"
L["Extra Spell Name"] = "Nombre del Hechizo Extra"
--[[Translation missing --]]
L["Faction"] = "Faction"
--[[Translation missing --]]
L["Faction Name"] = "Faction Name"
--[[Translation missing --]]
L["Faction Reputation"] = "Faction Reputation"
L["Fade In"] = "Aparecer"
L["Fade Out"] = "Desaparecer"
L["Fail Alert"] = "Alerta de Fallo"
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
L["Flash"] = "Destello"
L["Flex Raid"] = "Banda Flexible"
L["Flip"] = "Voltear"
--[[Translation missing --]]
L["Floor"] = "Floor"
L["Focus"] = "Foco"
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
L["Friendly"] = "Amistoso"
L["Friendly Fire"] = "Fuego Amigo"
L["From"] = "Desde"
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
L["Gained"] = "Obtenido"
--[[Translation missing --]]
L["Garr"] = "Garr"
--[[Translation missing --]]
L["Gehennas"] = "Gehennas"
--[[Translation missing --]]
L["General Rajaxx"] = "General Rajaxx"
L["Glancing"] = "de refilón"
L["Global Cooldown"] = "Recarga Global"
L["Glow"] = "Brillante"
--[[Translation missing --]]
L["Glow External Element"] = "Glow External Element"
--[[Translation missing --]]
L["Gluth"] = "Gluth"
--[[Translation missing --]]
L["Golemagg the Incinerator"] = "Golemagg the Incinerator"
--[[Translation missing --]]
L["Gothik the Harvester"] = "Gothik the Harvester"
L["Gradient"] = "Degradado"
L["Gradient Pulse"] = "Degradado Pulsante"
--[[Translation missing --]]
L["Grand Widow Faerlina"] = "Grand Widow Faerlina"
--[[Translation missing --]]
L["Grid"] = "Grid"
--[[Translation missing --]]
L["Grobbulus"] = "Grobbulus"
L["Group"] = "Grupo"
--[[Translation missing --]]
L["Group Arrangement"] = "Group Arrangement"
L["Grow"] = "Crecer"
L["GTFO Alert"] = "Alerta GTFO"
--[[Translation missing --]]
L["Guardian"] = "Guardian"
L["Guild"] = "Hermandad"
--[[Translation missing --]]
L["Hakkar"] = "Hakkar"
--[[Translation missing --]]
L["Has Target"] = "Has Target"
--[[Translation missing --]]
L["Has Vehicle UI"] = "Has Vehicle UI"
L["HasPet"] = "Mascota viva"
--[[Translation missing --]]
L["Haste (%)"] = "Haste (%)"
--[[Translation missing --]]
L["Haste Rating"] = "Haste Rating"
L["Heal"] = "Cura"
L["Health"] = "Salud"
L["Health (%)"] = "Vida (%)"
--[[Translation missing --]]
L["Heigan the Unclean"] = "Heigan the Unclean"
--[[Translation missing --]]
L["Height"] = "Height"
L["Hide"] = "Ocultar"
--[[Translation missing --]]
L["Hide 0 cooldowns"] = "Hide 0 cooldowns"
L["High Damage"] = "Alto Daño"
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
L["Higher Than Tank"] = "Mayor Que el Tanque"
--[[Translation missing --]]
L["Holy Resistance"] = "Holy Resistance"
L["Horde"] = "Horda"
L["Hostile"] = "Hostil"
L["Hostility"] = "Holstilidad"
L["Humanoid"] = "Humanoide"
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
L["Ignore Rune CD"] = "Ignorar Recarga de Runas"
--[[Translation missing --]]
L["Ignore Rune CDs"] = "Ignore Rune CDs"
--[[Translation missing --]]
L["Ignore Self"] = "Ignore Self"
L["Immune"] = "Inmune"
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
L["In Combat"] = "En Combate"
--[[Translation missing --]]
L["In Encounter"] = "In Encounter"
--[[Translation missing --]]
L["In Group"] = "In Group"
L["In Pet Battle"] = "En duelo de mascotas"
--[[Translation missing --]]
L["In Raid"] = "In Raid"
L["In Vehicle"] = "Conduciendo"
L["Include Bank"] = "Incluye el Banco"
L["Include Charges"] = "Incluye las Cargas"
--[[Translation missing --]]
L["Incoming Heal"] = "Incoming Heal"
--[[Translation missing --]]
L["Increase Precision Below"] = "Increase Precision Below"
--[[Translation missing --]]
L["Information"] = "Information"
L["Inherited"] = "Heredado"
L["Instakill"] = "Muerte Instantanea"
--[[Translation missing --]]
L["Instance"] = "Instance"
--[[Translation missing --]]
L["Instance Difficulty"] = "Instance Difficulty"
--[[Translation missing --]]
L["Instance Size Type"] = "Instance Size Type"
L["Instance Type"] = "Tipo de Instancia"
--[[Translation missing --]]
L["Instructor Razuvious"] = "Instructor Razuvious"
--[[Translation missing --]]
L["Insufficient Resources"] = "Insufficient Resources"
--[[Translation missing --]]
L["Intellect"] = "Intellect"
L["Interrupt"] = "Interrupcion"
--[[Translation missing --]]
L["Interrupt School"] = "Interrupt School"
--[[Translation missing --]]
L["Interrupted School Text"] = "Interrupted School Text"
L["Interruptible"] = "Interrumpible"
L["Inverse"] = "Inverso"
--[[Translation missing --]]
L["Inverse Pet Behavior"] = "Inverse Pet Behavior"
--[[Translation missing --]]
L["Is Away from Keyboard"] = "Is Away from Keyboard"
L["Is Exactly"] = "Es Exactamente"
L["Is Moving"] = "se está moviendo"
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
L["Item"] = "Objeto"
--[[Translation missing --]]
L["Item Bonus Id"] = "Item Bonus Id"
--[[Translation missing --]]
L["Item Bonus Id Equipped"] = "Item Bonus Id Equipped"
L["Item Count"] = "Contar los Objetos"
L["Item Equipped"] = "Objeto Equipado"
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
L["Leech"] = "Parasitar"
--[[Translation missing --]]
L["Leech (%)"] = "Leech (%)"
--[[Translation missing --]]
L["Leech Rating"] = "Leech Rating"
L["Left"] = "Izquierda"
L["Left to Right"] = "De Izquierda a Derecha"
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
L["Level"] = "Nivel"
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
L["Low Damage"] = "Bajo Daño"
L["Lower Than Tank"] = "Menor Que el Tanque"
--[[Translation missing --]]
L["Lucifron"] = "Lucifron"
--[[Translation missing --]]
L["Maexxna"] = "Maexxna"
L["Magic"] = "Magia"
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
L["Master"] = "Maestro"
--[[Translation missing --]]
L["Mastery (%)"] = "Mastery (%)"
--[[Translation missing --]]
L["Mastery Rating"] = "Mastery Rating"
--[[Translation missing --]]
L["Match Count"] = "Match Count"
--[[Translation missing --]]
L["Match Count per Unit"] = "Match Count per Unit"
L["Matches (Pattern)"] = "Corresponde (Patrón)"
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
L["Message"] = "Mensaje"
L["Message Type"] = "Tipo de Mensaje"
L["Message type:"] = "Tipo de Mensaje:"
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
L["Miss"] = "Fallo"
L["Miss Type"] = "Tipo de Fallo"
L["Missed"] = "Fallado"
L["Missing"] = "Ausente"
--[[Translation missing --]]
L["Moam"] = "Moam"
--[[Translation missing --]]
L["Model"] = "Model"
--[[Translation missing --]]
L["Modern Blizzard (1h 3m | 3m 7s | 10s | 2.4)"] = "Modern Blizzard (1h 3m | 3m 7s | 10s | 2.4)"
--[[Translation missing --]]
L["Molten Core"] = "Molten Core"
L["Monochrome"] = "Monocromo"
L["Monochrome Outline"] = "Monocromo"
L["Monochrome Thick Outline"] = "Borde gordo monocromo"
--[[Translation missing --]]
L["Monster Emote"] = "Monster Emote"
--[[Translation missing --]]
L["Monster Party"] = "Monster Party"
--[[Translation missing --]]
L["Monster Say"] = "Monster Say"
--[[Translation missing --]]
L["Monster Whisper"] = "Monster Whisper"
L["Monster Yell"] = "Grito de Monstruo"
--[[Translation missing --]]
L["Most remaining time"] = "Most remaining time"
L["Mounted"] = "Montado"
--[[Translation missing --]]
L["Mouse Cursor"] = "Mouse Cursor"
--[[Translation missing --]]
L["Movement Speed (%)"] = "Movement Speed (%)"
--[[Translation missing --]]
L["Movement Speed Rating"] = "Movement Speed Rating"
L["Multi-target"] = "Objetivo Múltiple"
--[[Translation missing --]]
L["Mythic Keystone"] = "Mythic Keystone"
--[[Translation missing --]]
L["Mythic+ Affix"] = "Mythic+ Affix"
L["Name"] = "Nombre"
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
L["Neutral"] = "Neutral"
L["Never"] = "Nunca"
L["Next"] = "Siguiente"
--[[Translation missing --]]
L["Next Combat"] = "Next Combat"
--[[Translation missing --]]
L["Next Encounter"] = "Next Encounter"
--[[Translation missing --]]
L["No Children"] = "No Children"
--[[Translation missing --]]
L["No Extend"] = "No Extend"
L["No Instance"] = "Fuera de Instancia"
--[[Translation missing --]]
L["No Profiling information saved."] = "No Profiling information saved."
L["None"] = "Nada"
L["Non-player Character"] = "Personaje No Jugador"
L["Normal"] = "Normal"
--[[Translation missing --]]
L["Not in Group"] = "Not in Group"
--[[Translation missing --]]
L["Not on Cooldown"] = "Not on Cooldown"
L["Not On Threat Table"] = "No Está En La Tabla De Amenaza"
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
L["Number"] = "Número"
L["Number Affected"] = "Dependiente de números"
--[[Translation missing --]]
L["Object"] = "Object"
L["Officer"] = "Oficial"
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
L["Opaque"] = "Opaco"
--[[Translation missing --]]
L["Option Group"] = "Option Group"
--[[Translation missing --]]
L["Options will finish loading after combat ends."] = "Options will finish loading after combat ends."
--[[Translation missing --]]
L["Options will open after the login process has completed."] = "Options will open after the login process has completed."
L["Orbit"] = "Orbitar"
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
L["Outline"] = "Linea exterior"
L["Overhealing"] = "Sobre Curación"
L["Overkill"] = "Muerte de Más"
--[[Translation missing --]]
L["Overlay %s"] = "Overlay %s"
--[[Translation missing --]]
L["Overlay Charged Combo Points"] = "Overlay Charged Combo Points"
--[[Translation missing --]]
L["Overlay Cost of Casts"] = "Overlay Cost of Casts"
--[[Translation missing --]]
L["Overlay Latency"] = "Overlay Latency"
L["Parry"] = "Parar"
--[[Translation missing --]]
L["Parry (%)"] = "Parry (%)"
--[[Translation missing --]]
L["Parry Rating"] = "Parry Rating"
L["Party"] = "Grupo"
L["Party Kill"] = "Muerte de Grupo"
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
L["Paused"] = "Pausado"
L["Periodic Spell"] = "Hechizo Periódico"
--[[Translation missing --]]
L["Personal Resource Display"] = "Personal Resource Display"
L["Pet"] = "Mascota"
L["Pet Behavior"] = "Comportamiento de mascota"
--[[Translation missing --]]
L["Pet Specialization"] = "Pet Specialization"
L["Pet Spell"] = "Habilidad de mascota"
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
L["Player"] = "Jugador"
L["Player Character"] = "Personaje Jugador"
L["Player Class"] = "Clase del Jugador"
--[[Translation missing --]]
L["Player Covenant"] = "Player Covenant"
--[[Translation missing --]]
L["Player Effective Level"] = "Player Effective Level"
--[[Translation missing --]]
L["Player Experience"] = "Player Experience"
L["Player Faction"] = "Facción del jugador"
L["Player Level"] = "Nivel del Personaje"
--[[Translation missing --]]
L["Player Name/Realm"] = "Player Name/Realm"
L["Player Race"] = "Raza del Jugador"
L["Player(s) Affected"] = "Jugador(es) Afectados"
L["Player(s) Not Affected"] = "Jugador(es) no Afectados"
--[[Translation missing --]]
L["Player/Unit Info"] = "Player/Unit Info"
L["Poison"] = "Veneno"
L["Power"] = "Poder"
L["Power (%)"] = "Poder  (%)"
L["Power Type"] = "Tipo de Poder"
--[[Translation missing --]]
L["Precision"] = "Precision"
L["Preset"] = "Predefinido"
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
L["Pulse"] = "Pulso"
L["PvP Flagged"] = "Marcado JcJ"
--[[Translation missing --]]
L["PvP Talent %i"] = "PvP Talent %i"
--[[Translation missing --]]
L["PvP Talent selected"] = "PvP Talent selected"
--[[Translation missing --]]
L["PvP Talent Selected"] = "PvP Talent Selected"
--[[Translation missing --]]
L["Queued Action"] = "Queued Action"
L["Radius"] = "Radio"
--[[Translation missing --]]
L["Ragnaros"] = "Ragnaros"
L["Raid"] = "Banda"
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
L["Raid Warning"] = "Alerta de Banda"
--[[Translation missing --]]
L["Raids"] = "Raids"
L["Range"] = "Rango"
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
L["Realm"] = "Reino"
--[[Translation missing --]]
L["Realm Name"] = "Realm Name"
--[[Translation missing --]]
L["Realm of Caster's Target"] = "Realm of Caster's Target"
L["Receiving display information"] = "Recibiendo información de aura de %s..."
L["Reflect"] = "Reflejar"
--[[Translation missing --]]
L["Region type %s not supported"] = "Region type %s not supported"
L["Relative"] = "Relativo"
--[[Translation missing --]]
L["Relative X-Offset"] = "Relative X-Offset"
--[[Translation missing --]]
L["Relative Y-Offset"] = "Relative Y-Offset"
--[[Translation missing --]]
L["Remaining Duration"] = "Remaining Duration"
L["Remaining Time"] = "Tiempo Restante"
--[[Translation missing --]]
L["Remove Obsolete Auras"] = "Remove Obsolete Auras"
--[[Translation missing --]]
L["Repair"] = "Repair"
--[[Translation missing --]]
L["Repeat"] = "Repeat"
--[[Translation missing --]]
L["Report Summary"] = "Report Summary"
L["Requested display does not exist"] = "El aura requerida no existe"
L["Requested display not authorized"] = "El aura requerida no está autorizada"
--[[Translation missing --]]
L["Requesting display information from %s ..."] = "Requesting display information from %s ..."
L["Require Valid Target"] = "Requiere Objetivo Válido"
L["Resist"] = "Resistir"
L["Resisted"] = "Resistido"
L["Resolve collisions dialog"] = "Resolver colisiones en dialogos"
L["Resolve collisions dialog singular"] = "Resolver colisiones en dialogos singulares"
L["Resolve collisions dialog startup"] = "Resolver colisiones en dialogos inicial"
L["Resolve collisions dialog startup singular"] = "Resolver colisiones en dialogos singulares inicial"
--[[Translation missing --]]
L["Rested"] = "Rested"
--[[Translation missing --]]
L["Rested Experience"] = "Rested Experience"
--[[Translation missing --]]
L["Rested Experience (%)"] = "Rested Experience (%)"
L["Resting"] = "Descansado"
L["Resurrect"] = "Resucitar"
L["Right"] = "Derecha"
L["Right to Left"] = "De Derecha a Izquierda"
--[[Translation missing --]]
L["Right, then Down"] = "Right, then Down"
--[[Translation missing --]]
L["Right, then Up"] = "Right, then Up"
--[[Translation missing --]]
L["Role"] = "Role"
L["Rotate Left"] = "Rotar a la Izquierda"
L["Rotate Right"] = "Rotar a la Derecha"
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
L["Rune"] = "Runa"
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
L["Say"] = "Decir"
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
L["Seconds"] = "Segundos"
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
L["Shake"] = "Sacudida"
--[[Translation missing --]]
L["Shazzrah"] = "Shazzrah"
--[[Translation missing --]]
L["Shift-Click to resume addon execution."] = "Shift-Click to resume addon execution."
L["Show"] = "Mostrar"
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
L["Shrink"] = "Encoger"
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
L["Slide from Bottom"] = "Arrastrar Desde Abajo"
L["Slide from Left"] = "Arrastrar Desde la Izquierda"
L["Slide from Right"] = "Arrastrar Desde la Derecha"
L["Slide from Top"] = "Arrastrar Desde Arriba"
L["Slide to Bottom"] = "Arrastrar Hacia Abajo"
L["Slide to Left"] = "Arrastrar Hacia la Izquierda"
L["Slide to Right"] = "Arrastrar Hacia la Derecha"
L["Slide to Top"] = "Arrastrar Hacia Arriba"
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
L["Source Name"] = "Nombre de Origen"
--[[Translation missing --]]
L["Source NPC Id"] = "Source NPC Id"
--[[Translation missing --]]
L["Source Object Type"] = "Source Object Type"
--[[Translation missing --]]
L["Source Raid Mark"] = "Source Raid Mark"
--[[Translation missing --]]
L["Source Reaction"] = "Source Reaction"
L["Source Unit"] = "Unidad Origen"
--[[Translation missing --]]
L["Source Unit Name/Realm"] = "Source Unit Name/Realm"
--[[Translation missing --]]
L["Source: "] = "Source: "
--[[Translation missing --]]
L["Space"] = "Space"
L["Spacing"] = "Espaciado"
--[[Translation missing --]]
L["Spark"] = "Spark"
--[[Translation missing --]]
L["Spec Role"] = "Spec Role"
--[[Translation missing --]]
L["Specific Type"] = "Specific Type"
L["Specific Unit"] = "Unidad Específica"
L["Spell"] = "Hechizo"
L["Spell (Building)"] = "Hechizo (en curso)"
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
L["Spell Name"] = "Nombre del Hechizo"
--[[Translation missing --]]
L["Spell Usable"] = "Spell Usable"
L["Spin"] = "Girar"
L["Spiral"] = "Espiral"
L["Spiral In And Out"] = "Espiral de Dentro a Fuera"
--[[Translation missing --]]
L["Stack Count"] = "Stack Count"
L["Stacks"] = "Acumulaciones"
--[[Translation missing --]]
L["Stagger Scale"] = "Stagger Scale"
--[[Translation missing --]]
L["Stamina"] = "Stamina"
L["Stance/Form/Aura"] = "Impostura/Forma/Aura"
--[[Translation missing --]]
L["Standing"] = "Standing"
--[[Translation missing --]]
L["Star Shake"] = "Star Shake"
--[[Translation missing --]]
L["Start"] = "Start"
--[[Translation missing --]]
L["Start Now"] = "Start Now"
L["Status"] = "Estado"
L["Stolen"] = "Robado"
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
L["Summon"] = "Invocar"
--[[Translation missing --]]
L["Supports multiple entries, separated by commas"] = "Supports multiple entries, separated by commas"
--[[Translation missing --]]
L[ [=[Supports multiple entries, separated by commas
]=] ] = [=[Supports multiple entries, separated by commas
]=]
--[[Translation missing --]]
L["Supports multiple entries, separated by commas. Group Zone IDs must be prefixed with 'g', e.g. g277."] = "Supports multiple entries, separated by commas. Group Zone IDs must be prefixed with 'g', e.g. g277."
L["Swing"] = "Golpe"
L["Swing Timer"] = "Temporizador de Golpes"
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
L["Talent selected"] = "Talento seleccionado"
L["Talent Specialization"] = "Especialización de Talentos"
L["Tanking And Highest"] = "Tanqueando y el más alto"
L["Tanking But Not Highest"] = "Tanqueando pero no el mas alto"
L["Target"] = "Objetivo"
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
L["Thick Outline"] = "Linea exterior gruesa"
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
L["Threat Situation"] = "Situación de la Amenaza"
--[[Translation missing --]]
L["Threat Value"] = "Threat Value"
--[[Translation missing --]]
L["Tick"] = "Tick"
L["Tier "] = "Tier"
--[[Translation missing --]]
L["Time Format"] = "Time Format"
--[[Translation missing --]]
L["Time in GCDs"] = "Time in GCDs"
L["Timed"] = "Temporizado"
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
L["Top"] = "Superior"
L["Top Left"] = "Superior Izquierda"
L["Top Right"] = "Superior Derecha"
L["Top to Bottom"] = "De Arriba a Abajo"
--[[Translation missing --]]
L["Torghast"] = "Torghast"
--[[Translation missing --]]
L["Total"] = "Total"
L["Total Duration"] = "Duración total"
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
L["Totem"] = "Tótem"
L["Totem #%i"] = "Tótem #%i"
L["Totem Name"] = "Nombre del Tótem"
--[[Translation missing --]]
L["Totem Name Pattern Match"] = "Totem Name Pattern Match"
L["Totem Number"] = "Número de tótem"
--[[Translation missing --]]
L["Track Cooldowns"] = "Track Cooldowns"
--[[Translation missing --]]
L["Tracking Charge %i"] = "Tracking Charge %i"
--[[Translation missing --]]
L["Tracking Charge CDs"] = "Tracking Charge CDs"
--[[Translation missing --]]
L["Tracking Only Cooldown"] = "Tracking Only Cooldown"
L["Transmission error"] = "Error de transmisión"
--[[Translation missing --]]
L["Trigger"] = "Trigger"
--[[Translation missing --]]
L["Trigger %i"] = "Trigger %i"
--[[Translation missing --]]
L["Trigger 1"] = "Trigger 1"
--[[Translation missing --]]
L["Trigger State Updater (Advanced)"] = "Trigger State Updater (Advanced)"
L["Trigger Update"] = "Actualización del desencadenador"
L["Trigger:"] = "Desencadenador:"
--[[Translation missing --]]
L["Trivial (Low Level)"] = "Trivial (Low Level)"
L["True"] = "Verdadero"
--[[Translation missing --]]
L["Twin Emperors"] = "Twin Emperors"
L["Type"] = "Tipo"
--[[Translation missing --]]
L["Unaffected"] = "Unaffected"
L["Undefined"] = "No Definido"
L["Unit"] = "Unidad"
L["Unit Characteristics"] = "Características de la unidad"
L["Unit Destroyed"] = "Unidad Destruida"
L["Unit Died"] = "Unit Muerta"
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
L["Up"] = "Arriba"
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
L["Weapon"] = "Arma"
--[[Translation missing --]]
L["Weapon Enchant"] = "Weapon Enchant"
--[[Translation missing --]]
L["Weapon Enchant / Fishing Lure"] = "Weapon Enchant / Fishing Lure"
--[[Translation missing --]]
L["What do you want to do?"] = "What do you want to do?"
L["Whisper"] = "Susurro"
--[[Translation missing --]]
L["Whole Area"] = "Whole Area"
--[[Translation missing --]]
L["Width"] = "Width"
L["Wobble"] = "Temblar"
--[[Translation missing --]]
L["World Boss"] = "World Boss"
--[[Translation missing --]]
L["Wrap"] = "Wrap"
--[[Translation missing --]]
L["Writing to the WeakAuras table is not allowed."] = "Writing to the WeakAuras table is not allowed."
--[[Translation missing --]]
L["X-Offset"] = "X-Offset"
L["Yell"] = "Grito"
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

