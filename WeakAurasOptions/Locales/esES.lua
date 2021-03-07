if not WeakAuras.IsCorrectVersion() then return end

if not(GetLocale() == "esES") then
  return
end

local L = WeakAuras.L

-- WeakAuras/Options
	L[" and |cFFFF0000mirrored|r"] = "y |cFFFF0000reflejado|r"
	L["-- Do not remove this comment, it is part of this trigger: "] = "-- No elimines este comentario, es parte de este activador:"
	L[" rotated |cFFFF0000%s|r degrees"] = "rotado |cFFFF0000%s|r grados"
	L["% of Progress"] = "% de Progreso"
	L["%i auras selected"] = "%i auras seleccionados"
	L["%i Matches"] = "%i Correspondencias"
	L["%s - Option #%i has the key %s. Please choose a different option key."] = "%s - La opción #%i tiene el código %s. Por favor selecciona un código diferente."
	L["%s %s, Lines: %d, Frequency: %0.2f, Length: %d, Thickness: %d"] = "%s %s, Líneas: %d, Frecuencia: %0.2f, Longitud: %d, Espesor: %d"
	L["%s %s, Particles: %d, Frequency: %0.2f, Scale: %0.2f"] = "%s %s, Partículas: %d, Frecuencia: %0.2f, Escala: %0.2f"
	L["%s Alpha: %d%%"] = "%s Alfa: %d%%"
	L["%s Color"] = "%s Color"
	L["%s Default Alpha, Zoom, Icon Inset, Aspect Ratio"] = "%s Alfa por defecto, Zoom, Inserción de iconos, Relación de aspecto"
	L["%s Inset: %d%%"] = "%s Inserción: %d%%"
	L["%s is not a valid SubEvent for COMBAT_LOG_EVENT_UNFILTERED"] = "%s no es un válido SubEvent para COMBAT_LOG_EVENT_UNFILTERED"
	L["%s Keep Aspect Ratio"] = "%s Mantener relación de aspecto"
	L["%s total auras"] = "%s auras en total"
	L["%s Zoom: %d%%"] = "%s Zoom: %d%%"
	L["%s, Border"] = "%s, Borde"
	L["%s, Offset: %0.2f;%0.2f"] = "%s, Desplazamiento: %0.2f;%0.2f"
	L["%s, offset: %0.2f;%0.2f"] = "%s, desplazamiento: %0.2f;%0.2f"
	L["%s|cFFFF0000custom|r texture with |cFFFF0000%s|r blend mode%s%s"] = "%s|cFFFF0000textura personalizada|r con |cFFFF0000%s|r modo de mezcla%s%s"
	L["(Right click to rename)"] = "(Clic derecho para cambiar el nombre)"
	L["|c%02x%02x%02x%02xCustom Color|r"] = "|c%02x%02x%02x%02xColor personalizado|r"
	L["|cFFE0E000Note:|r This sets the description only on '%s'"] = "|cFFE0E000Note:|r Esto establece la descripción solo en '%s'"
	L["|cFFE0E000Note:|r This sets the URL on all selected auras"] = "|cFFE0E000Note:|r Esto establece la URL en todas las auras seleccionadas"
	L["|cFFE0E000Note:|r This sets the URL on this group and all its members."] = "|cFFE0E000Note:|r Esto establece la URL en este grupo y todos sus miembros."
	--[[Translation missing --]]
	L["|cFFFF0000Automatic|r length"] = "|cFFFF0000Automatic|r length"
	--[[Translation missing --]]
	L["|cFFFF0000default|r texture"] = "|cFFFF0000default|r texture"
	--[[Translation missing --]]
	L["|cFFFF0000desaturated|r "] = "|cFFFF0000desaturated|r "
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
	L["|cFFffcc00Extra:|r %s and %s %s"] = "|cFFffcc00Extra:|r %s and %s %s"
	--[[Translation missing --]]
	L["|cFFffcc00Font Flags:|r |cFFFF0000%s|r and shadow |c%sColor|r with offset |cFFFF0000%s/%s|r%s%s"] = "|cFFffcc00Font Flags:|r |cFFFF0000%s|r and shadow |c%sColor|r with offset |cFFFF0000%s/%s|r%s%s"
	--[[Translation missing --]]
	L["|cFFffcc00Font Flags:|r |cFFFF0000%s|r and shadow |c%sColor|r with offset |cFFFF0000%s/%s|r%s%s%s"] = "|cFFffcc00Font Flags:|r |cFFFF0000%s|r and shadow |c%sColor|r with offset |cFFFF0000%s/%s|r%s%s%s"
	--[[Translation missing --]]
	L["|cFFffcc00Format Options|r"] = "|cFFffcc00Format Options|r"
	L["1 Match"] = "1 Correspondencia"
	L["A 20x20 pixels icon"] = "Un icono de 20x20 píxeles"
	L["A 32x32 pixels icon"] = "Un icono de 32x32 píxeles"
	L["A 40x40 pixels icon"] = "Un icono de 40x40 píxeles"
	L["A 48x48 pixels icon"] = "Un icono de 48x48 píxeles"
	L["A 64x64 pixels icon"] = "Un icono de 64x64 píxeles"
	L["A group that dynamically controls the positioning of its children"] = "Un grupo que dinámicamente controla la posición de sus hijos"
	L["A Unit ID (e.g., party1)."] = "Una ID de unidad (ej., party1)."
	L["Actions"] = "Acciones"
	L["Add"] = "Añadir"
	L["Add %s"] = "Añadir %s"
	L["Add a new display"] = "Añadir una nueva aura"
	L["Add Condition"] = "Añadir condición"
	L["Add Entry"] = "Añadir entrada"
	L["Add Extra Elements"] = "Añadir elementos extra"
	L["Add Option"] = "Añadir opción"
	L["Add Overlay"] = "Añadir capa sobrepuesta"
	L["Add Property Change"] = "Añadir cambio de propiedad"
	L["Add Snippet"] = "Añadir Snippet"
	L["Add Sub Option"] = "Añadir opción secundaria"
	L["Add to group %s"] = "añadir al grupo %s"
	L["Add to new Dynamic Group"] = "Añadir al nuevo Grupo Dinámico"
	L["Add to new Group"] = "Añadir al nuevo Grupo"
	L["Add Trigger"] = "Añadir disparador"
	L["Additional Events"] = "Eventos adicionales"
	L["Addon"] = "Addon"
	L["Addons"] = "Addons"
	L["Advanced"] = "Avanzado"
	L["Align"] = "Alinear"
	L["Alignment"] = "Alineamiento"
	L["All of"] = "Todo"
	L["Allow Full Rotation"] = "Permitir Rotación Total"
	L["Alpha"] = "Transparencia"
	L["Anchor"] = "Anclaje"
	L["Anchor Point"] = "Punto de Anclaje"
	L["Anchored To"] = "anclado a"
	L["And "] = "y"
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
	L["Angle"] = "Ángulo"
	L["Animate"] = "Animar"
	L["Animated Expand and Collapse"] = "Animar Pliegue y Despliegue"
	--[[Translation missing --]]
	L["Animates progress changes"] = "Animates progress changes"
	--[[Translation missing --]]
	L["Animation End"] = "Animation End"
	--[[Translation missing --]]
	L["Animation Mode"] = "Animation Mode"
	L["Animation relative duration description"] = [=[Duración de la animación relativa a la duración del aura, expresado en fracciones (1/2), porcentaje (50%),  o decimales (0.5).
|cFFFF0000Nota:|r si el aura no tiene progreso (por ejemplo, si no tiene un activador basado en tiempo, si el aura no tiene duración, etc.), la animación no correrá.

|cFF4444FFPor Ejemplo:|r
Si la duración de la animación es |cFF00CC0010%|r, y el disparador del aura es un beneficio que dura 20 segundos, la animación de entrada se mostrará por 2 segundos.
Si la duración de la animación es |cFF00CC0010%|r, y el disparador del aura es un beneficio sin tiempo asignado, la animación de entrada se ignorará."
]=]
	L["Animation Sequence"] = "Secuencia de Animación"
	--[[Translation missing --]]
	L["Animation Start"] = "Animation Start"
	L["Animations"] = "Animaciones"
	--[[Translation missing --]]
	L["Any of"] = "Any of"
	L["Apply Template"] = "Aplicar plantilla"
	L["Arcane Orb"] = "Orbe arcano"
	--[[Translation missing --]]
	L["At a position a bit left of Left HUD position."] = "At a position a bit left of Left HUD position."
	--[[Translation missing --]]
	L["At a position a bit left of Right HUD position"] = "At a position a bit left of Right HUD position"
	--[[Translation missing --]]
	L["At the same position as Blizzard's spell alert"] = "At the same position as Blizzard's spell alert"
	--[[Translation missing --]]
	L[ [=[Aura is
Off Screen]=] ] = [=[Aura is
Off Screen]=]
	--[[Translation missing --]]
	L["Aura Name"] = "Aura Name"
	--[[Translation missing --]]
	L["Aura Name Pattern"] = "Aura Name Pattern"
	--[[Translation missing --]]
	L["Aura Type"] = "Aura Type"
	L["Aura(s)"] = "Aura(s)"
	--[[Translation missing --]]
	L["Author Options"] = "Author Options"
	--[[Translation missing --]]
	L["Auto-Clone (Show All Matches)"] = "Auto-Clone (Show All Matches)"
	--[[Translation missing --]]
	L["Auto-cloning enabled"] = "Auto-cloning enabled"
	--[[Translation missing --]]
	L["Automatic"] = "Automatic"
	--[[Translation missing --]]
	L["Automatic length"] = "Automatic length"
	L["Backdrop Color"] = "Color de fondo"
	--[[Translation missing --]]
	L["Backdrop in Front"] = "Backdrop in Front"
	L["Backdrop Style"] = "Estilo de fondo"
	--[[Translation missing --]]
	L["Background"] = "Background"
	L["Background Color"] = "Color de Fondo"
	--[[Translation missing --]]
	L["Background Inner"] = "Background Inner"
	L["Background Offset"] = "Desplazamiento del Fondo"
	L["Background Texture"] = "Textura del Fondo"
	L["Bar Alpha"] = "Transparencia de la Barra"
	L["Bar Color"] = "Color de la Barra"
	L["Bar Color Settings"] = "Configuración de color de barra"
	L["Bar Texture"] = "Textura de la Barra"
	--[[Translation missing --]]
	L["Big Icon"] = "Big Icon"
	L["Blend Mode"] = "Modo de Mezcla"
	--[[Translation missing --]]
	L["Blue Rune"] = "Blue Rune"
	--[[Translation missing --]]
	L["Blue Sparkle Orb"] = "Blue Sparkle Orb"
	L["Border"] = "Borde"
	--[[Translation missing --]]
	L["Border %s"] = "Border %s"
	--[[Translation missing --]]
	L["Border Anchor"] = "Border Anchor"
	L["Border Color"] = "Color de borde"
	--[[Translation missing --]]
	L["Border in Front"] = "Border in Front"
	L["Border Inset"] = "Borde del recuadro"
	L["Border Offset"] = "Desplazamiento de Borde"
	L["Border Settings"] = "Configuración de bordes"
	L["Border Size"] = "Tamaño del borde"
	L["Border Style"] = "Estilo de borde"
	--[[Translation missing --]]
	L["Bottom"] = "Bottom"
	--[[Translation missing --]]
	L["Bottom Left"] = "Bottom Left"
	--[[Translation missing --]]
	L["Bottom Right"] = "Bottom Right"
	--[[Translation missing --]]
	L["Bracket Matching"] = "Bracket Matching"
	--[[Translation missing --]]
	L["Browse Wago, the largest collection of auras."] = "Browse Wago, the largest collection of auras."
	--[[Translation missing --]]
	L["Can be a Name or a Unit ID (e.g. party1). A name only works on friendly players in your group."] = "Can be a Name or a Unit ID (e.g. party1). A name only works on friendly players in your group."
	--[[Translation missing --]]
	L["Can be a UID (e.g., party1)."] = "Can be a UID (e.g., party1)."
	L["Cancel"] = "Cancelar"
	--[[Translation missing --]]
	L["Cast by Player Character"] = "Cast by Player Character"
	--[[Translation missing --]]
	L["Cast by Players"] = "Cast by Players"
	--[[Translation missing --]]
	L["Center"] = "Center"
	--[[Translation missing --]]
	L["Chat Message"] = "Chat Message"
	--[[Translation missing --]]
	L["Chat with WeakAuras experts on our Discord server."] = "Chat with WeakAuras experts on our Discord server."
	L["Check On..."] = "Chequear..."
	--[[Translation missing --]]
	L["Check out our wiki for a large collection of examples and snippets."] = "Check out our wiki for a large collection of examples and snippets."
	--[[Translation missing --]]
	L["Children:"] = "Children:"
	L["Choose"] = "Escoger"
	--[[Translation missing --]]
	L["Class"] = "Class"
	--[[Translation missing --]]
	L["Clip Overlays"] = "Clip Overlays"
	--[[Translation missing --]]
	L["Clipped by Progress"] = "Clipped by Progress"
	L["Close"] = "Cerrar"
	--[[Translation missing --]]
	L["Collapse"] = "Collapse"
	L["Collapse all loaded displays"] = "Plegar todas las auras"
	L["Collapse all non-loaded displays"] = "Plegar todas las auras no cargadas"
	--[[Translation missing --]]
	L["Collapsible Group"] = "Collapsible Group"
	--[[Translation missing --]]
	L["color"] = "color"
	L["Color"] = "Color"
	--[[Translation missing --]]
	L["Column Height"] = "Column Height"
	--[[Translation missing --]]
	L["Column Space"] = "Column Space"
	--[[Translation missing --]]
	L["Columns"] = "Columns"
	--[[Translation missing --]]
	L["Combinations"] = "Combinations"
	--[[Translation missing --]]
	L["Combine Matches Per Unit"] = "Combine Matches Per Unit"
	--[[Translation missing --]]
	L["Common Text"] = "Common Text"
	--[[Translation missing --]]
	L["Compare against the number of units affected."] = "Compare against the number of units affected."
	--[[Translation missing --]]
	L["Compatibility Options"] = "Compatibility Options"
	L["Compress"] = "Comprimir"
	--[[Translation missing --]]
	L["Condition %i"] = "Condition %i"
	--[[Translation missing --]]
	L["Conditions"] = "Conditions"
	--[[Translation missing --]]
	L["Configure what options appear on this panel."] = "Configure what options appear on this panel."
	L["Constant Factor"] = "Factor Constante"
	--[[Translation missing --]]
	L["Control-click to select multiple displays"] = "Control-click to select multiple displays"
	L["Controls the positioning and configuration of multiple displays at the same time"] = "Controla la posición y configuración de varias auras a la vez"
	--[[Translation missing --]]
	L["Convert to New Aura Trigger"] = "Convert to New Aura Trigger"
	--[[Translation missing --]]
	L["Convert to..."] = "Convert to..."
	--[[Translation missing --]]
	L["Cooldown Edge"] = "Cooldown Edge"
	--[[Translation missing --]]
	L["Cooldown Settings"] = "Cooldown Settings"
	--[[Translation missing --]]
	L["Cooldown Swipe"] = "Cooldown Swipe"
	--[[Translation missing --]]
	L["Copy"] = "Copy"
	--[[Translation missing --]]
	L["Copy settings..."] = "Copy settings..."
	--[[Translation missing --]]
	L["Copy to all auras"] = "Copy to all auras"
	--[[Translation missing --]]
	L["Could not parse '%s'. Expected a table."] = "Could not parse '%s'. Expected a table."
	L["Count"] = "Contar"
	--[[Translation missing --]]
	L["Counts the number of matches over all units."] = "Counts the number of matches over all units."
	L["Creating buttons: "] = "Crear pulsadores: "
	L["Creating options: "] = "Crear opciones: "
	L["Crop X"] = "Cortar X"
	L["Crop Y"] = "Cortar Y"
	--[[Translation missing --]]
	L["Custom"] = "Custom"
	--[[Translation missing --]]
	L["Custom Anchor"] = "Custom Anchor"
	--[[Translation missing --]]
	L["Custom Background"] = "Custom Background"
	--[[Translation missing --]]
	L["Custom Check"] = "Custom Check"
	L["Custom Code"] = "Código Personalizado"
	--[[Translation missing --]]
	L["Custom Color"] = "Custom Color"
	--[[Translation missing --]]
	L["Custom Configuration"] = "Custom Configuration"
	--[[Translation missing --]]
	L["Custom Foreground"] = "Custom Foreground"
	--[[Translation missing --]]
	L["Custom Frames"] = "Custom Frames"
	--[[Translation missing --]]
	L["Custom Function"] = "Custom Function"
	--[[Translation missing --]]
	L["Custom Grow"] = "Custom Grow"
	--[[Translation missing --]]
	L["Custom Options"] = "Custom Options"
	--[[Translation missing --]]
	L["Custom Sort"] = "Custom Sort"
	L["Custom Trigger"] = "Disparador Personalizado"
	L["Custom trigger event tooltip"] = [=[
Escoje qué eventos quieres que chequeen el disparador personalizado.
Múltiples eventos pueden ser especificados, sepáralos con comas o espacios.

|cFF4444FFPor Ejemplo:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED
]=]
	L["Custom trigger status tooltip"] = [=[
Escoje qué eventos quieres que chequeen el disparador personalizado.
Ya que éste es un Disparador del tipo Estado, los eventos especificados pueden ser invocados por WeakAuras sin ningún argumento.
Múltiples eventos pueden ser especificados, sepáralos con comas o espacios.

|cFF4444FFPor Ejemplo:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED
]=]
	L["Custom Untrigger"] = "Disparador No-Personalizado"
	--[[Translation missing --]]
	L["Custom Variables"] = "Custom Variables"
	L["Debuff Type"] = "Tipo de Perjuicio"
	--[[Translation missing --]]
	L["Default"] = "Default"
	--[[Translation missing --]]
	L["Default Color"] = "Default Color"
	--[[Translation missing --]]
	L["Delete"] = "Delete"
	L["Delete all"] = "Eliminar todo"
	--[[Translation missing --]]
	L["Delete children and group"] = "Delete children and group"
	--[[Translation missing --]]
	L["Delete Entry"] = "Delete Entry"
	L["Desaturate"] = "Desaturar"
	--[[Translation missing --]]
	L["Description"] = "Description"
	--[[Translation missing --]]
	L["Description Text"] = "Description Text"
	--[[Translation missing --]]
	L["Determines how many entries can be in the table."] = "Determines how many entries can be in the table."
	--[[Translation missing --]]
	L["Differences"] = "Differences"
	L["Disabled"] = "Desactivado"
	--[[Translation missing --]]
	L["Disallow Entry Reordering"] = "Disallow Entry Reordering"
	L["Discrete Rotation"] = "Rotación Discreta"
	L["Display"] = "Mostrar"
	--[[Translation missing --]]
	L["Display Name"] = "Display Name"
	L["Display Text"] = "Mostrar Texto"
	--[[Translation missing --]]
	L["Displays a text, works best in combination with other displays"] = "Displays a text, works best in combination with other displays"
	L["Distribute Horizontally"] = "Distribución Horizontal"
	L["Distribute Vertically"] = "Distribución Vertical"
	--[[Translation missing --]]
	L["Do not group this display"] = "Do not group this display"
	--[[Translation missing --]]
	L["Documentation"] = "Documentation"
	--[[Translation missing --]]
	L["Done"] = "Done"
	--[[Translation missing --]]
	L["Don't skip this Version"] = "Don't skip this Version"
	--[[Translation missing --]]
	L["Drag to move"] = "Drag to move"
	--[[Translation missing --]]
	L["Duplicate"] = "Duplicate"
	--[[Translation missing --]]
	L["Duplicate All"] = "Duplicate All"
	L["Duration (s)"] = "Duración (s)"
	L["Duration Info"] = "Información de Duración"
	--[[Translation missing --]]
	L["Dynamic Duration"] = "Dynamic Duration"
	L["Dynamic Group"] = "Grupo Dinámico"
	--[[Translation missing --]]
	L["Dynamic Group Settings"] = "Dynamic Group Settings"
	--[[Translation missing --]]
	L["Dynamic Information"] = "Dynamic Information"
	--[[Translation missing --]]
	L["Dynamic information from first active trigger"] = "Dynamic information from first active trigger"
	--[[Translation missing --]]
	L["Dynamic information from Trigger %i"] = "Dynamic information from Trigger %i"
	L["Dynamic text tooltip"] = "Descripción emergente dinámica"
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
	L["Enabled"] = "Activado"
	--[[Translation missing --]]
	L["End Angle"] = "End Angle"
	--[[Translation missing --]]
	L["End of %s"] = "End of %s"
	--[[Translation missing --]]
	L["Enter a Spell ID"] = "Enter a Spell ID"
	L["Enter an aura name, partial aura name, or spell id"] = "Introduce el nombre del aura (total o parcial), o el identificador del aura"
	--[[Translation missing --]]
	L["Enter an Aura Name, partial Aura Name, or Spell ID. A Spell ID will match any spells with the same name."] = "Enter an Aura Name, partial Aura Name, or Spell ID. A Spell ID will match any spells with the same name."
	--[[Translation missing --]]
	L["Enter Author Mode"] = "Enter Author Mode"
	--[[Translation missing --]]
	L["Enter in a value for the tick's placement."] = "Enter in a value for the tick's placement."
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
	L["Event Type"] = "Tipo de Evento"
	--[[Translation missing --]]
	L["Event(s)"] = "Event(s)"
	--[[Translation missing --]]
	L["Everything"] = "Everything"
	--[[Translation missing --]]
	L["Exact Spell ID(s)"] = "Exact Spell ID(s)"
	--[[Translation missing --]]
	L["Exact Spell Match"] = "Exact Spell Match"
	--[[Translation missing --]]
	L["Expand"] = "Expand"
	L["Expand all loaded displays"] = "Desplegar todas las auras"
	L["Expand all non-loaded displays"] = "Desplegar todas las auras no cargadas"
	--[[Translation missing --]]
	L["Expansion is disabled because this group has no children"] = "Expansion is disabled because this group has no children"
	--[[Translation missing --]]
	L["Export to Lua table..."] = "Export to Lua table..."
	--[[Translation missing --]]
	L["Export to string..."] = "Export to string..."
	--[[Translation missing --]]
	L["External"] = "External"
	L["Fade"] = "Apagar"
	--[[Translation missing --]]
	L["Fade In"] = "Fade In"
	--[[Translation missing --]]
	L["Fade Out"] = "Fade Out"
	--[[Translation missing --]]
	L["Fallback"] = "Fallback"
	--[[Translation missing --]]
	L["Fallback Icon"] = "Fallback Icon"
	--[[Translation missing --]]
	L["False"] = "False"
	--[[Translation missing --]]
	L["Fetch Affected/Unaffected Names"] = "Fetch Affected/Unaffected Names"
	--[[Translation missing --]]
	L["Filter by Class"] = "Filter by Class"
	--[[Translation missing --]]
	L["Filter by Group Role"] = "Filter by Group Role"
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
	L["Finish"] = "Finalizar"
	--[[Translation missing --]]
	L["Fire Orb"] = "Fire Orb"
	L["Font"] = "Fuente"
	L["Font Size"] = "Tamaño de fuente"
	--[[Translation missing --]]
	L["Foreground"] = "Foreground"
	L["Foreground Color"] = "Color Frontal"
	L["Foreground Texture"] = "Textura Frontal"
	--[[Translation missing --]]
	L["Format"] = "Format"
	--[[Translation missing --]]
	L["Format for %s"] = "Format for %s"
	--[[Translation missing --]]
	L["Found a Bug?"] = "Found a Bug?"
	L["Frame"] = "Macro"
	--[[Translation missing --]]
	L["Frame Count"] = "Frame Count"
	--[[Translation missing --]]
	L["Frame Rate"] = "Frame Rate"
	--[[Translation missing --]]
	L["Frame Selector"] = "Frame Selector"
	L["Frame Strata"] = "Importancia del Marco"
	--[[Translation missing --]]
	L["Frequency"] = "Frequency"
	--[[Translation missing --]]
	L["From Template"] = "From Template"
	--[[Translation missing --]]
	L["From version %s to version %s"] = "From version %s to version %s"
	--[[Translation missing --]]
	L["Full Circle"] = "Full Circle"
	--[[Translation missing --]]
	L["Get Help"] = "Get Help"
	--[[Translation missing --]]
	L["Global Conditions"] = "Global Conditions"
	--[[Translation missing --]]
	L["Glow %s"] = "Glow %s"
	L["Glow Action"] = "Acción de Destello"
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
	L["Green Rune"] = "Runa verde"
	--[[Translation missing --]]
	L["Grid direction"] = "Grid direction"
	--[[Translation missing --]]
	L["Group"] = "Group"
	--[[Translation missing --]]
	L["Group (verb)"] = "Group (verb)"
	L["Group aura count description"] = [=[La cantidad de miembros del grupo o banda que deben estar afectados por las auras indicadas para la activación.
Si el número introducido es un entero (ej. 5), la cantidad de miembros del grupo o banda que deben estar afectados será absoluta.
Si el número introducido es una fracción (1/2), decimal (0.5) o porcentaje (50%%), se interpretará como que la cantidad de miembros del grupo o banda que deben estar afectados es una fracción del total.

|cFF4444FFPor ejemplo:|r
Con |cFF00CC00> 0|r se activará cuando cualquier miembro del grupo o banda esté afectado.
Con |cFF00CC00= 100%%|r se activará cuando todos los miembros del grupo o banda estén afectados.
Con |cFF00CC00!= 2|r se activará cuando el número de miembros del grupo o banda afectados no sea 2.
Con |cFF00CC00<= 0.8|r se activará cuando menos del 80%% del grupo o banda esté afectado (4 de 5 miembros en grupos, 8 de 10 ó 20 de 25 en bandas).
Con |cFF00CC00> 1/2|r se activará cuando más de la mitad de miembros del grupo o banda estén afectados.
Con |cFF00CC00>= 0|r se activará siempre.]=]
	--[[Translation missing --]]
	L["Group by Frame"] = "Group by Frame"
	--[[Translation missing --]]
	L["Group contains updates from Wago"] = "Group contains updates from Wago"
	--[[Translation missing --]]
	L["Group Description"] = "Group Description"
	--[[Translation missing --]]
	L["Group Icon"] = "Group Icon"
	--[[Translation missing --]]
	L["Group key"] = "Group key"
	L["Group Member Count"] = "Contador del Miembro de Grupo"
	--[[Translation missing --]]
	L["Group Options"] = "Group Options"
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
	--[[Translation missing --]]
	L["Hawk"] = "Hawk"
	L["Height"] = "Alto"
	--[[Translation missing --]]
	L["Help"] = "Help"
	--[[Translation missing --]]
	L["Hide"] = "Hide"
	--[[Translation missing --]]
	L["Hide Cooldown Text"] = "Hide Cooldown Text"
	--[[Translation missing --]]
	L["Hide Glows applied by this aura"] = "Hide Glows applied by this aura"
	--[[Translation missing --]]
	L["Hide on"] = "Hide on"
	--[[Translation missing --]]
	L["Hide this group's children"] = "Hide this group's children"
	L["Hide When Not In Group"] = "Esconder si no Estas Agrupado"
	L["Horizontal Align"] = "Alineado Horizontal"
	--[[Translation missing --]]
	L["Horizontal Bar"] = "Horizontal Bar"
	--[[Translation missing --]]
	L["Hostility"] = "Hostility"
	--[[Translation missing --]]
	L["Huge Icon"] = "Huge Icon"
	--[[Translation missing --]]
	L["Hybrid Position"] = "Hybrid Position"
	--[[Translation missing --]]
	L["Hybrid Sort Mode"] = "Hybrid Sort Mode"
	--[[Translation missing --]]
	L["Icon"] = "Icon"
	L["Icon Info"] = "Información del Icono"
	L["Icon Inset"] = "Interior del Icono"
	--[[Translation missing --]]
	L["Icon Position"] = "Icon Position"
	--[[Translation missing --]]
	L["Icon Settings"] = "Icon Settings"
	--[[Translation missing --]]
	L["Icon Source"] = "Icon Source"
	--[[Translation missing --]]
	L["If"] = "If"
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
	--[[Translation missing --]]
	L["If Trigger %s"] = "If Trigger %s"
	--[[Translation missing --]]
	L["If unchecked, then a default color will be used (usually yellow)"] = "If unchecked, then a default color will be used (usually yellow)"
	--[[Translation missing --]]
	L["If unchecked, then this space will fill the entire line it is on in User Mode."] = "If unchecked, then this space will fill the entire line it is on in User Mode."
	--[[Translation missing --]]
	L["Ignore all Updates"] = "Ignore all Updates"
	--[[Translation missing --]]
	L["Ignore Dead"] = "Ignore Dead"
	--[[Translation missing --]]
	L["Ignore Disconnected"] = "Ignore Disconnected"
	--[[Translation missing --]]
	L["Ignore Lua Errors on OPTIONS event"] = "Ignore Lua Errors on OPTIONS event"
	--[[Translation missing --]]
	L["Ignore out of checking range"] = "Ignore out of checking range"
	--[[Translation missing --]]
	L["Ignore Self"] = "Ignore Self"
	--[[Translation missing --]]
	L["Ignore self"] = "Ignore self"
	L["Ignored"] = "Ignorar"
	--[[Translation missing --]]
	L["Ignored Aura Name"] = "Ignored Aura Name"
	--[[Translation missing --]]
	L["Ignored Exact Spell ID(s)"] = "Ignored Exact Spell ID(s)"
	--[[Translation missing --]]
	L["Ignored Name(s)"] = "Ignored Name(s)"
	--[[Translation missing --]]
	L["Ignored Spell ID"] = "Ignored Spell ID"
	L["Import"] = "Importar"
	L["Import a display from an encoded string"] = "Importar un aura desde un texto cifrado"
	--[[Translation missing --]]
	L["Indent Size"] = "Indent Size"
	--[[Translation missing --]]
	L["Information"] = "Information"
	--[[Translation missing --]]
	L["Inner"] = "Inner"
	--[[Translation missing --]]
	L["Invalid Item Name/ID/Link"] = "Invalid Item Name/ID/Link"
	--[[Translation missing --]]
	L["Invalid Spell ID"] = "Invalid Spell ID"
	--[[Translation missing --]]
	L["Invalid Spell Name/ID/Link"] = "Invalid Spell Name/ID/Link"
	--[[Translation missing --]]
	L["Invalid type for '%s'. Expected 'bool', 'number', 'select', 'string', 'timer' or 'elapsedTimer'."] = "Invalid type for '%s'. Expected 'bool', 'number', 'select', 'string', 'timer' or 'elapsedTimer'."
	--[[Translation missing --]]
	L["Invalid type for property '%s' in '%s'. Expected '%s'"] = "Invalid type for property '%s' in '%s'. Expected '%s'"
	--[[Translation missing --]]
	L["Inverse"] = "Inverse"
	--[[Translation missing --]]
	L["Inverse Slant"] = "Inverse Slant"
	--[[Translation missing --]]
	L["Is Boss Debuff"] = "Is Boss Debuff"
	--[[Translation missing --]]
	L["Is Stealable"] = "Is Stealable"
	L["Justify"] = "Justificar"
	--[[Translation missing --]]
	L["Keep Aspect Ratio"] = "Keep Aspect Ratio"
	--[[Translation missing --]]
	L["Keep your Wago imports up to date with the Companion App."] = "Keep your Wago imports up to date with the Companion App."
	--[[Translation missing --]]
	L["Large Input"] = "Large Input"
	--[[Translation missing --]]
	L["Leaf"] = "Leaf"
	--[[Translation missing --]]
	L["Left"] = "Left"
	--[[Translation missing --]]
	L["Left 2 HUD position"] = "Left 2 HUD position"
	--[[Translation missing --]]
	L["Left HUD position"] = "Left HUD position"
	--[[Translation missing --]]
	L["Length"] = "Length"
	--[[Translation missing --]]
	L["Length of |cFFFF0000%s|r"] = "Length of |cFFFF0000%s|r"
	--[[Translation missing --]]
	L["Limit"] = "Limit"
	--[[Translation missing --]]
	L["Lines & Particles"] = "Lines & Particles"
	L["Load"] = "Cargar"
	L["Loaded"] = "Cargado"
	--[[Translation missing --]]
	L["Lock Positions"] = "Lock Positions"
	--[[Translation missing --]]
	L["Loop"] = "Loop"
	--[[Translation missing --]]
	L["Low Mana"] = "Low Mana"
	--[[Translation missing --]]
	L["Magnetically Align"] = "Magnetically Align"
	L["Main"] = "Principal"
	L["Manage displays defined by Addons"] = "Administra Auras definidas por Addons"
	--[[Translation missing --]]
	L["Match Count"] = "Match Count"
	--[[Translation missing --]]
	L["Matches the height setting of a horizontal bar or width for a vertical bar."] = "Matches the height setting of a horizontal bar or width for a vertical bar."
	--[[Translation missing --]]
	L["Max"] = "Max"
	--[[Translation missing --]]
	L["Max Length"] = "Max Length"
	--[[Translation missing --]]
	L["Medium Icon"] = "Medium Icon"
	--[[Translation missing --]]
	L["Message"] = "Message"
	L["Message Prefix"] = "Prefijo del Mensaje"
	L["Message Suffix"] = "Sufijo del Mensaje"
	--[[Translation missing --]]
	L["Message Type"] = "Message Type"
	--[[Translation missing --]]
	L["Min"] = "Min"
	L["Mirror"] = "Reflejar"
	L["Model"] = "Modelo"
	--[[Translation missing --]]
	L["Model %s"] = "Model %s"
	--[[Translation missing --]]
	L["Model Settings"] = "Model Settings"
	--[[Translation missing --]]
	L["Move Above Group"] = "Move Above Group"
	--[[Translation missing --]]
	L["Move Below Group"] = "Move Below Group"
	--[[Translation missing --]]
	L["Move Down"] = "Move Down"
	--[[Translation missing --]]
	L["Move Entry Down"] = "Move Entry Down"
	--[[Translation missing --]]
	L["Move Entry Up"] = "Move Entry Up"
	--[[Translation missing --]]
	L["Move Into Above Group"] = "Move Into Above Group"
	--[[Translation missing --]]
	L["Move Into Below Group"] = "Move Into Below Group"
	--[[Translation missing --]]
	L["Move this display down in its group's order"] = "Move this display down in its group's order"
	--[[Translation missing --]]
	L["Move this display up in its group's order"] = "Move this display up in its group's order"
	--[[Translation missing --]]
	L["Move Up"] = "Move Up"
	L["Multiple Displays"] = "Múltiples auras"
	L["Multiselect ignored tooltip"] = [=[
|cFFFF0000Ignorado|r - |cFF777777Único|r - |cFF777777Múltiple|r
Ésta opción no será usada al determinar cuándo se mostrará el aura]=]
	L["Multiselect multiple tooltip"] = [=[
|cFF777777Ignorado|r - |cFF777777Único|r - |cFF00FF00Múltiple|r
Cualquier combinación de valores es posible.]=]
	L["Multiselect single tooltip"] = [=[
|cFF777777Ignorado|r - |cFF00FF00Único|r - |cFF777777Múltiple|r
Sólo un valor coincidente puede ser escogido.]=]
	L["Name Info"] = "Información del Nombre"
	--[[Translation missing --]]
	L["Name Pattern Match"] = "Name Pattern Match"
	--[[Translation missing --]]
	L["Name(s)"] = "Name(s)"
	--[[Translation missing --]]
	L["Name:"] = "Name:"
	--[[Translation missing --]]
	L["Nameplate"] = "Nameplate"
	--[[Translation missing --]]
	L["Nameplates"] = "Nameplates"
	L["Negator"] = "Negar"
	--[[Translation missing --]]
	L["New Aura"] = "New Aura"
	--[[Translation missing --]]
	L["New Value"] = "New Value"
	L["No Children"] = "Sin dependientes"
	--[[Translation missing --]]
	L["None"] = "None"
	--[[Translation missing --]]
	L["Not a table"] = "Not a table"
	L["Not all children have the same value for this option"] = "No todos los hijos contienen la misma configuración."
	L["Not Loaded"] = "No Cargado"
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
	L["Okay"] = "Aceptar"
	L["On Hide"] = "Ocultar"
	--[[Translation missing --]]
	L["On Init"] = "On Init"
	L["On Show"] = "Mostrar"
	--[[Translation missing --]]
	L["Only Match auras cast by a player (not an npc)"] = "Only Match auras cast by a player (not an npc)"
	L["Only match auras cast by people other than the player"] = "Solamente corresponder auras conjuradas por otros jugadores"
	--[[Translation missing --]]
	L["Only match auras cast by people other than the player or his pet"] = "Only match auras cast by people other than the player or his pet"
	L["Only match auras cast by the player"] = "Solamente corresponder auras conjuradas por ti"
	--[[Translation missing --]]
	L["Only match auras cast by the player or his pet"] = "Only match auras cast by the player or his pet"
	L["Operator"] = "Operador"
	--[[Translation missing --]]
	L["Option %i"] = "Option %i"
	--[[Translation missing --]]
	L["Option key"] = "Option key"
	--[[Translation missing --]]
	L["Option Type"] = "Option Type"
	--[[Translation missing --]]
	L["Options will open after combat ends."] = "Options will open after combat ends."
	L["or"] = "o"
	--[[Translation missing --]]
	L["or Trigger %s"] = "or Trigger %s"
	--[[Translation missing --]]
	L["Orange Rune"] = "Orange Rune"
	L["Orientation"] = "Orientación"
	--[[Translation missing --]]
	L["Outer"] = "Outer"
	L["Outline"] = "Contorno"
	--[[Translation missing --]]
	L["Overflow"] = "Overflow"
	--[[Translation missing --]]
	L["Overlay %s Info"] = "Overlay %s Info"
	--[[Translation missing --]]
	L["Overlays"] = "Overlays"
	L["Own Only"] = "Solo Mías"
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
	--[[Translation missing --]]
	L["Paste text below"] = "Paste text below"
	--[[Translation missing --]]
	L["Paste Trigger Settings"] = "Paste Trigger Settings"
	--[[Translation missing --]]
	L["Places a tick on the bar"] = "Places a tick on the bar"
	L["Play Sound"] = "Reproducir Sonido"
	--[[Translation missing --]]
	L["Portrait Zoom"] = "Portrait Zoom"
	--[[Translation missing --]]
	L["Position Settings"] = "Position Settings"
	--[[Translation missing --]]
	L["Preferred Match"] = "Preferred Match"
	--[[Translation missing --]]
	L["Premade Snippets"] = "Premade Snippets"
	--[[Translation missing --]]
	L["Preset"] = "Preset"
	--[[Translation missing --]]
	L["Press Ctrl+C to copy"] = "Press Ctrl+C to copy"
	--[[Translation missing --]]
	L["Press Ctrl+C to copy the URL"] = "Press Ctrl+C to copy the URL"
	--[[Translation missing --]]
	L["Prevent Merging"] = "Prevent Merging"
	L["Processed %i chars"] = "%i personajes procesados"
	L["Progress Bar"] = "Barra de Progreso"
	--[[Translation missing --]]
	L["Progress Bar Settings"] = "Progress Bar Settings"
	L["Progress Texture"] = "Texture de Progreso"
	--[[Translation missing --]]
	L["Progress Texture Settings"] = "Progress Texture Settings"
	--[[Translation missing --]]
	L["Purple Rune"] = "Purple Rune"
	--[[Translation missing --]]
	L["Put this display in a group"] = "Put this display in a group"
	--[[Translation missing --]]
	L["Radius"] = "Radius"
	--[[Translation missing --]]
	L["Raid Role"] = "Raid Role"
	L["Re-center X"] = "Re-centrar X"
	L["Re-center Y"] = "Re-centrar Y"
	--[[Translation missing --]]
	L["Regions of type \"%s\" are not supported."] = "Regions of type \"%s\" are not supported."
	--[[Translation missing --]]
	L["Remaining Time"] = "Remaining Time"
	--[[Translation missing --]]
	L["Remove"] = "Remove"
	--[[Translation missing --]]
	L["Remove this display from its group"] = "Remove this display from its group"
	--[[Translation missing --]]
	L["Remove this property"] = "Remove this property"
	--[[Translation missing --]]
	L["Rename"] = "Rename"
	--[[Translation missing --]]
	L["Repeat After"] = "Repeat After"
	--[[Translation missing --]]
	L["Repeat every"] = "Repeat every"
	--[[Translation missing --]]
	L["Report bugs on our issue tracker."] = "Report bugs on our issue tracker."
	--[[Translation missing --]]
	L["Require unit from trigger"] = "Require unit from trigger"
	--[[Translation missing --]]
	L["Required for Activation"] = "Required for Activation"
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
	--[[Translation missing --]]
	L["Right HUD position"] = "Right HUD position"
	L["Right-click for more options"] = "Clic derecho para más opciones"
	L["Rotate"] = "Rotación"
	L["Rotate In"] = "Rotar"
	L["Rotate Out"] = "Rotar"
	L["Rotate Text"] = "Rotar Texto"
	L["Rotation"] = "Rotación"
	--[[Translation missing --]]
	L["Rotation Mode"] = "Rotation Mode"
	--[[Translation missing --]]
	L["Row Space"] = "Row Space"
	--[[Translation missing --]]
	L["Row Width"] = "Row Width"
	--[[Translation missing --]]
	L["Rows"] = "Rows"
	L["Same"] = "Igual"
	--[[Translation missing --]]
	L["Scale"] = "Scale"
	L["Search"] = "Buscar"
	L["Select the auras you always want to be listed first"] = "Selecciona las auras que quieres que siempre sean listadas primero"
	L["Send To"] = "Envar A"
	--[[Translation missing --]]
	L["Separator Text"] = "Separator Text"
	--[[Translation missing --]]
	L["Separator text"] = "Separator text"
	--[[Translation missing --]]
	L["Set Parent to Anchor"] = "Set Parent to Anchor"
	--[[Translation missing --]]
	L["Set Thumbnail Icon"] = "Set Thumbnail Icon"
	--[[Translation missing --]]
	L["Sets the anchored frame as the aura's parent, causing the aura to inherit attributes such as visibility and scale."] = "Sets the anchored frame as the aura's parent, causing the aura to inherit attributes such as visibility and scale."
	--[[Translation missing --]]
	L["Settings"] = "Settings"
	--[[Translation missing --]]
	L["Shadow Color"] = "Shadow Color"
	--[[Translation missing --]]
	L["Shadow X Offset"] = "Shadow X Offset"
	--[[Translation missing --]]
	L["Shadow Y Offset"] = "Shadow Y Offset"
	--[[Translation missing --]]
	L["Shift-click to create chat link"] = "Shift-click to create chat link"
	L["Show all matches (Auto-clone)"] = "Mostrar todas las coincidencias (Auto-clonar)"
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
	--[[Translation missing --]]
	L["Show If Unit Is Invalid"] = "Show If Unit Is Invalid"
	--[[Translation missing --]]
	L["Show Matches for"] = "Show Matches for"
	--[[Translation missing --]]
	L["Show Matches for Units"] = "Show Matches for Units"
	--[[Translation missing --]]
	L["Show Model"] = "Show Model"
	--[[Translation missing --]]
	L["Show model of unit "] = "Show model of unit "
	--[[Translation missing --]]
	L["Show On"] = "Show On"
	--[[Translation missing --]]
	L["Show Spark"] = "Show Spark"
	--[[Translation missing --]]
	L["Show Text"] = "Show Text"
	--[[Translation missing --]]
	L["Show this group's children"] = "Show this group's children"
	--[[Translation missing --]]
	L["Show Tick"] = "Show Tick"
	L["Shows a 3D model from the game files"] = "Muestra un modelo 3D directamente de los ficheros de WoW"
	--[[Translation missing --]]
	L["Shows a border"] = "Shows a border"
	L["Shows a custom texture"] = "Muestra una textura"
	--[[Translation missing --]]
	L["Shows a glow"] = "Shows a glow"
	--[[Translation missing --]]
	L["Shows a model"] = "Shows a model"
	L["Shows a progress bar with name, timer, and icon"] = "Muestra una barra de progreso con nombres, temporizadores, y icono"
	L["Shows a spell icon with an optional cooldown overlay"] = "Muestra un icono como aura con máscaras opcionales"
	--[[Translation missing --]]
	L["Shows a stop motion texture"] = "Shows a stop motion texture"
	L["Shows a texture that changes based on duration"] = "Muestra una textura que cambia con el tiempo"
	L["Shows one or more lines of text, which can include dynamic information such as progress or stacks"] = "Muestra una o varias lineas de texto, capaz de contener información cambiante como acumulaciones y/o progresos"
	--[[Translation missing --]]
	L["Simple"] = "Simple"
	L["Size"] = "Tamaño"
	--[[Translation missing --]]
	L["Skip this Version"] = "Skip this Version"
	--[[Translation missing --]]
	L["Slant Amount"] = "Slant Amount"
	--[[Translation missing --]]
	L["Slant Mode"] = "Slant Mode"
	--[[Translation missing --]]
	L["Slanted"] = "Slanted"
	L["Slide"] = "Arrastrar"
	L["Slide In"] = "Arrastrar Dentro"
	L["Slide Out"] = "Arrastrar"
	--[[Translation missing --]]
	L["Slider Step Size"] = "Slider Step Size"
	--[[Translation missing --]]
	L["Small Icon"] = "Small Icon"
	--[[Translation missing --]]
	L["Smooth Progress"] = "Smooth Progress"
	--[[Translation missing --]]
	L["Snippets"] = "Snippets"
	--[[Translation missing --]]
	L["Soft Max"] = "Soft Max"
	--[[Translation missing --]]
	L["Soft Min"] = "Soft Min"
	L["Sort"] = "Ordenar"
	L["Sound"] = "Sonido"
	L["Sound Channel"] = "Canal de Sonido"
	L["Sound File Path"] = "Ruta al Fichero de Sonido"
	--[[Translation missing --]]
	L["Sound Kit ID"] = "Sound Kit ID"
	--[[Translation missing --]]
	L["Source"] = "Source"
	L["Space"] = "Espacio"
	L["Space Horizontally"] = "Espacio Horizontal"
	L["Space Vertically"] = "Espacio Vertical"
	--[[Translation missing --]]
	L["Spark"] = "Spark"
	--[[Translation missing --]]
	L["Spark Settings"] = "Spark Settings"
	--[[Translation missing --]]
	L["Spark Texture"] = "Spark Texture"
	--[[Translation missing --]]
	L["Specific Unit"] = "Specific Unit"
	L["Spell ID"] = "ID de Hechizo"
	L["Stack Count"] = "Contar Acumulaciones"
	L["Stack Info"] = "Información de Acumulaciones"
	L["Stagger"] = "Tambaleo"
	--[[Translation missing --]]
	L["Star"] = "Star"
	L["Start"] = "Empezar"
	--[[Translation missing --]]
	L["Start Angle"] = "Start Angle"
	--[[Translation missing --]]
	L["Start Collapsed"] = "Start Collapsed"
	--[[Translation missing --]]
	L["Start of %s"] = "Start of %s"
	L["Stealable"] = "Puede Robarse"
	--[[Translation missing --]]
	L["Step Size"] = "Step Size"
	--[[Translation missing --]]
	L["Stop ignoring Updates"] = "Stop ignoring Updates"
	--[[Translation missing --]]
	L["Stop Motion"] = "Stop Motion"
	--[[Translation missing --]]
	L["Stop Motion Settings"] = "Stop Motion Settings"
	--[[Translation missing --]]
	L["Stop Sound"] = "Stop Sound"
	--[[Translation missing --]]
	L["Sub Elements"] = "Sub Elements"
	--[[Translation missing --]]
	L["Sub Option %i"] = "Sub Option %i"
	L["Temporary Group"] = "Grupo Temporal"
	L["Text"] = "Texto"
	--[[Translation missing --]]
	L["Text %s"] = "Text %s"
	L["Text Color"] = "Color del Texto"
	--[[Translation missing --]]
	L["Text Settings"] = "Text Settings"
	L["Texture"] = "Textura"
	L["Texture Info"] = "Información de Textura"
	--[[Translation missing --]]
	L["Texture Settings"] = "Texture Settings"
	--[[Translation missing --]]
	L["Texture Wrap"] = "Texture Wrap"
	L["The duration of the animation in seconds."] = "Duración de la animación (en segundos)."
	--[[Translation missing --]]
	L["The duration of the animation in seconds. The finish animation does not start playing until after the display would normally be hidden."] = "The duration of the animation in seconds. The finish animation does not start playing until after the display would normally be hidden."
	L["The type of trigger"] = "Tipo de Activador"
	--[[Translation missing --]]
	L["Then "] = "Then "
	--[[Translation missing --]]
	L["Thickness"] = "Thickness"
	--[[Translation missing --]]
	L["This adds %tooltip, %tooltip1, %tooltip2, %tooltip3 as text replacements."] = "This adds %tooltip, %tooltip1, %tooltip2, %tooltip3 as text replacements."
	--[[Translation missing --]]
	L["This display is currently loaded"] = "This display is currently loaded"
	--[[Translation missing --]]
	L["This display is not currently loaded"] = "This display is not currently loaded"
	--[[Translation missing --]]
	L["This region of type \"%s\" is not supported."] = "This region of type \"%s\" is not supported."
	--[[Translation missing --]]
	L["This setting controls what widget is generated in user mode."] = "This setting controls what widget is generated in user mode."
	--[[Translation missing --]]
	L["Tick %s"] = "Tick %s"
	--[[Translation missing --]]
	L["Tick Mode"] = "Tick Mode"
	--[[Translation missing --]]
	L["Tick Placement"] = "Tick Placement"
	L["Time in"] = "Contar En"
	L["Tiny Icon"] = "Icono miniatura"
	L["To Frame's"] = "Al macro"
	--[[Translation missing --]]
	L["To Group's"] = "To Group's"
	L["To Personal Ressource Display's"] = "A los recursos del aura personal"
	L["To Screen's"] = "A la pantalla"
	L["Toggle the visibility of all loaded displays"] = "Alterar la visibilidad de todas las auras cargadas"
	L["Toggle the visibility of all non-loaded displays"] = "Alterar la visibilidad de todas las auras no cargadas"
	L["Toggle the visibility of this display"] = "Alterar la visibilidad de esta aura"
	L["Tooltip"] = "Descriptión emergente"
	--[[Translation missing --]]
	L["Tooltip Content"] = "Tooltip Content"
	L["Tooltip on Mouseover"] = "Descripción emergente al pasar el ratón"
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
	L["Top HUD position"] = "Posición superior de la visualización (HUD)"
	--[[Translation missing --]]
	L["Top Left"] = "Top Left"
	--[[Translation missing --]]
	L["Top Right"] = "Top Right"
	--[[Translation missing --]]
	L["Total Angle"] = "Total Angle"
	--[[Translation missing --]]
	L["Total Time"] = "Total Time"
	L["Trigger"] = "Disparador"
	L["Trigger %d"] = "Disparador %d"
	--[[Translation missing --]]
	L["Trigger %s"] = "Trigger %s"
	--[[Translation missing --]]
	L["Trigger Combination"] = "Trigger Combination"
	--[[Translation missing --]]
	L["True"] = "True"
	L["Type"] = "Tipo"
	--[[Translation missing --]]
	L["Type 'select' for '%s' requires a values member'"] = "Type 'select' for '%s' requires a values member'"
	--[[Translation missing --]]
	L["Ungroup"] = "Ungroup"
	--[[Translation missing --]]
	L["Unit"] = "Unit"
	--[[Translation missing --]]
	L["Unit %s is not a valid unit for RegisterUnitEvent"] = "Unit %s is not a valid unit for RegisterUnitEvent"
	--[[Translation missing --]]
	L["Unit Count"] = "Unit Count"
	--[[Translation missing --]]
	L["Unit Frame"] = "Unit Frame"
	--[[Translation missing --]]
	L["Unit Frames"] = "Unit Frames"
	--[[Translation missing --]]
	L["Unit Name Filter"] = "Unit Name Filter"
	--[[Translation missing --]]
	L["UnitName Filter"] = "UnitName Filter"
	--[[Translation missing --]]
	L["Unknown property '%s' found in '%s'"] = "Unknown property '%s' found in '%s'"
	L["Unlike the start or finish animations, the main animation will loop over and over until the display is hidden."] = "Ignorar animaciones de inicio y final: la animación principal se repetirá hasta que el aura se oculte."
	--[[Translation missing --]]
	L["Update %s by %s"] = "Update %s by %s"
	--[[Translation missing --]]
	L["Update Auras"] = "Update Auras"
	L["Update Custom Text On..."] = "Actualizar Texto Personalizado En..."
	--[[Translation missing --]]
	L["Update in Group"] = "Update in Group"
	--[[Translation missing --]]
	L["Update this Aura"] = "Update this Aura"
	--[[Translation missing --]]
	L["URL"] = "URL"
	--[[Translation missing --]]
	L["Use Custom Color"] = "Use Custom Color"
	--[[Translation missing --]]
	L["Use Display Info Id"] = "Use Display Info Id"
	L["Use Full Scan (High CPU)"] = "Escaneo Total (carga el procesador)"
	--[[Translation missing --]]
	L["Use nth value from tooltip:"] = "Use nth value from tooltip:"
	--[[Translation missing --]]
	L["Use SetTransform"] = "Use SetTransform"
	--[[Translation missing --]]
	L["Use Texture"] = "Use Texture"
	L["Use tooltip \"size\" instead of stacks"] = "Usa \"tamaño\" en vez de acumulaciones"
	--[[Translation missing --]]
	L["Use Tooltip Information"] = "Use Tooltip Information"
	--[[Translation missing --]]
	L["Used in Auras:"] = "Used in Auras:"
	--[[Translation missing --]]
	L["Used in auras:"] = "Used in auras:"
	--[[Translation missing --]]
	L["Uses UnitIsVisible() to check if in range. This is polled every second."] = "Uses UnitIsVisible() to check if in range. This is polled every second."
	--[[Translation missing --]]
	L["Value %i"] = "Value %i"
	--[[Translation missing --]]
	L["Values are in normalized rgba format."] = "Values are in normalized rgba format."
	--[[Translation missing --]]
	L["Values:"] = "Values:"
	--[[Translation missing --]]
	L["Version: "] = "Version: "
	L["Vertical Align"] = "Alineado Vertical"
	--[[Translation missing --]]
	L["Vertical Bar"] = "Vertical Bar"
	--[[Translation missing --]]
	L["View"] = "View"
	--[[Translation missing --]]
	L["Wago Update"] = "Wago Update"
	--[[Translation missing --]]
	L["Whole Area"] = "Whole Area"
	L["Width"] = "Ancho"
	--[[Translation missing --]]
	L["wrapping"] = "wrapping"
	L["X Offset"] = "X Posicion"
	--[[Translation missing --]]
	L["X Rotation"] = "X Rotation"
	L["X Scale"] = "X Escala"
	--[[Translation missing --]]
	L["X-Offset"] = "X-Offset"
	--[[Translation missing --]]
	L["x-Offset"] = "x-Offset"
	L["Y Offset"] = "Y Posicion"
	--[[Translation missing --]]
	L["Y Rotation"] = "Y Rotation"
	L["Y Scale"] = "Y Escala"
	--[[Translation missing --]]
	L["Yellow Rune"] = "Yellow Rune"
	--[[Translation missing --]]
	L["Y-Offset"] = "Y-Offset"
	--[[Translation missing --]]
	L["y-Offset"] = "y-Offset"
	--[[Translation missing --]]
	L["You are about to delete %d aura(s). |cFFFF0000This cannot be undone!|r Would you like to continue?"] = "You are about to delete %d aura(s). |cFFFF0000This cannot be undone!|r Would you like to continue?"
	--[[Translation missing --]]
	L["You are about to delete a trigger. |cFFFF0000This cannot be undone!|r Would you like to continue?"] = "You are about to delete a trigger. |cFFFF0000This cannot be undone!|r Would you like to continue?"
	--[[Translation missing --]]
	L["Your Saved Snippets"] = "Your Saved Snippets"
	L["Z Offset"] = "Desplazamiento en Z"
	--[[Translation missing --]]
	L["Z Rotation"] = "Z Rotation"
	L["Zoom"] = "Ampliación"
	L["Zoom In"] = "Acercar"
	L["Zoom Out"] = "Alejar"

