local t = {
["ACHIEVEMENT_EARNED"] = true,
["ACTIONBAR_HIDEGRID"] = true,
["ACTIONBAR_PAGE_CHANGED"] = true,
["ACTIONBAR_SHOWGRID"] = true,
["ACTIONBAR_SLOT_CHANGED"] = true,
["ACTIONBAR_UPDATE_COOLDOWN"] = true,
["ACTIONBAR_UPDATE_STATE"] = true,
["ACTIONBAR_UPDATE_USABLE"] = true,
["ACTIVE_TALENT_GROUP_CHANGED"] = true,
["ADDON_ACTION_BLOCKED"] = true,
["ADDON_ACTION_FORBIDDEN"] = true,
["ADDON_LOADED"] = true,
["AREA_SPIRIT_HEALER_IN_RANGE"] = true,
["AREA_SPIRIT_HEALER_OUT_OF_RANGE"] = true,
["ARENA_OPPONENT_UPDATE"] = true,
["ARENA_SEASON_WORLD_STATE"] = true,
["ARENA_TEAM_INVITE_REQUEST"] = true,
["ARENA_TEAM_ROSTER_UPDATE"] = true,
["ARENA_TEAM_UPDATE"] = true,
["AUCTION_BIDDER_LIST_UPDATE"] = true,
["AUCTION_HOUSE_CLOSED"] = true,
["AUCTION_HOUSE_DISABLED"] = true,
["AUCTION_HOUSE_SHOW"] = true,
["AUCTION_ITEM_LIST_UPDATE"] = true,
["AUCTION_MULTISELL_FAILURE"] = true,
["AUCTION_MULTISELL_START"] = true,
["AUCTION_MULTISELL_UPDATE"] = true,
["AUCTION_OWNED_LIST_UPDATE"] = true,
["AUTOEQUIP_BIND_CONFIRM"] = true,
["AUTOFOLLOW_BEGIN"] = true,
["AUTOFOLLOW_END"] = true,
["BAG_CLOSED"] = true,
["BAG_OPEN"] = true,
["BAG_UPDATE"] = true,
["BAG_UPDATE_COOLDOWN"] = true,
["BANKFRAME_CLOSED"] = true,
["BANKFRAME_OPENED"] = true,
["BARBER_SHOP_APPEARANCE_APPLIED"] = true,
["BARBER_SHOP_CLOSE"] = true,
["BARBER_SHOP_OPEN"] = true,
["BARBER_SHOP_SUCCESS"] = true,
["BATTLEFIELDS_CLOSED"] = true,
["BATTLEFIELDS_SHOW"] = true,
["BATTLEFIELD_MGR_EJECTED"] = true,
["BATTLEFIELD_MGR_EJECT_PENDING"] = true,
["BATTLEFIELD_MGR_ENTERED"] = true,
["BATTLEFIELD_MGR_ENTRY_INVITE"] = true,
["BATTLEFIELD_MGR_QUEUE_INVITE"] = true,
["BATTLEFIELD_MGR_QUEUE_REQUEST_RESPONSE"] = true,
["BATTLEFIELD_MGR_STATE_CHANGE"] = true,
["BILLING_NAG_DIALOG"] = true,
["BIND_ENCHANT"] = true,
["BN_BLOCK_LIST_UPDATED"] = true,
["BN_CHAT_CHANNEL_CLOSED"] = true,
["BN_CHAT_CHANNEL_CREATE_FAILED"] = true,
["BN_CHAT_CHANNEL_CREATE_SUCCEEDED"] = true,
["BN_CHAT_CHANNEL_INVITE_FAILED"] = true,
["BN_CHAT_CHANNEL_INVITE_SUCCEEDED"] = true,
["BN_CHAT_CHANNEL_JOINED"] = true,
["BN_CHAT_CHANNEL_LEFT"] = true,
["BN_CHAT_CHANNEL_MEMBER_JOINED"] = true,
["BN_CHAT_CHANNEL_MEMBER_LEFT"] = true,
["BN_CHAT_CHANNEL_MEMBER_UPDATED"] = true,
["BN_CHAT_CHANNEL_MESSAGE_BLOCKED"] = true,
["BN_CHAT_CHANNEL_MESSAGE_UNDELIVERABLE"] = true,
["BN_CHAT_WHISPER_UNDELIVERABLE"] = true,
["BN_CONNECTED"] = true,
["BN_CUSTOM_MESSAGE_CHANGED"] = true,
["BN_CUSTOM_MESSAGE_LOADED"] = true,
["BN_DISCONNECTED"] = true,
["BN_FRIEND_ACCOUNT_OFFLINE"] = true,
["BN_FRIEND_ACCOUNT_ONLINE"] = true,
["BN_FRIEND_INFO_CHANGED"] = true,
["BN_FRIEND_INVITE_ADDED"] = true,
["BN_FRIEND_INVITE_LIST_INITIALIZED"] = true,
["BN_FRIEND_INVITE_REMOVED"] = true,
["BN_FRIEND_INVITE_SEND_RESULT"] = true,
["BN_FRIEND_LIST_SIZE_CHANGED"] = true,
["BN_FRIEND_TOON_OFFLINE"] = true,
["BN_FRIEND_TOON_ONLINE"] = true,
["BN_MATURE_LANGUAGE_FILTER"] = true,
["BN_NEW_PRESENCE"] = true,
["BN_REQUEST_FOF_FAILED"] = true,
["BN_REQUEST_FOF_SUCCEEDED"] = true,
["BN_SELF_OFFLINE"] = true,
["BN_SELF_ONLINE"] = true,
["BN_SYSTEM_MESSAGE"] = true,
["BN_TOON_NAME_UPDATED"] = true,
["CALENDAR_ACTION_PENDING"] = true,
["CALENDAR_CLOSE_EVENT"] = true,
["CALENDAR_EVENT_ALARM"] = true,
["CALENDAR_NEW_EVENT"] = true,
["CALENDAR_OPEN_EVENT"] = true,
["CALENDAR_UPDATE_ERROR"] = true,
["CALENDAR_UPDATE_EVENT"] = true,
["CALENDAR_UPDATE_EVENT_LIST"] = true,
["CALENDAR_UPDATE_INVITE_LIST"] = true,
["CALENDAR_UPDATE_PENDING_INVITES"] = true,
["CANCEL_LOOT_ROLL"] = true,
["CANCEL_SUMMON"] = true,
["CHANNEL_COUNT_UPDATE"] = true,
["CHANNEL_FLAGS_UPDATED"] = true,
["CHANNEL_INVITE_REQUEST"] = true,
["CHANNEL_PASSWORD_REQUEST"] = true,
["CHANNEL_ROSTER_UPDATE"] = true,
["CHANNEL_UI_UPDATE"] = true,
["CHANNEL_VOICE_UPDATE"] = true,
["CHARACTER_POINTS_CHANGED"] = true,
["CHAT_MSG_ACHIEVEMENT"] = true,
["CHAT_MSG_ADDON"] = true,
["CHAT_MSG_AFK"] = true,
["CHAT_MSG_BATTLEGROUND"] = true,
["CHAT_MSG_BATTLEGROUND_LEADER"] = true,
["CHAT_MSG_BG_SYSTEM_ALLIANCE"] = true,
["CHAT_MSG_BG_SYSTEM_HORDE"] = true,
["CHAT_MSG_BG_SYSTEM_NEUTRAL"] = true,
["CHAT_MSG_BN_CONVERSATION"] = true,
["CHAT_MSG_BN_CONVERSATION_LIST"] = true,
["CHAT_MSG_BN_CONVERSATION_NOTICE"] = true,
["CHAT_MSG_BN_INLINE_TOAST_ALERT"] = true,
["CHAT_MSG_BN_INLINE_TOAST_BROADCAST"] = true,
["CHAT_MSG_BN_INLINE_TOAST_BROADCAST_INFORM"] = true,
["CHAT_MSG_BN_INLINE_TOAST_CONVERSATION"] = true,
["CHAT_MSG_BN_WHISPER"] = true,
["CHAT_MSG_BN_WHISPER_INFORM"] = true,
["CHAT_MSG_CHANNEL"] = true,
["CHAT_MSG_CHANNEL_JOIN"] = true,
["CHAT_MSG_CHANNEL_LEAVE"] = true,
["CHAT_MSG_CHANNEL_LIST"] = true,
["CHAT_MSG_CHANNEL_NOTICE"] = true,
["CHAT_MSG_CHANNEL_NOTICE_USER"] = true,
["CHAT_MSG_COMBAT_FACTION_CHANGE"] = true,
["CHAT_MSG_COMBAT_HONOR_GAIN"] = true,
["CHAT_MSG_COMBAT_MISC_INFO"] = true,
["CHAT_MSG_COMBAT_XP_GAIN"] = true,
["CHAT_MSG_DND"] = true,
["CHAT_MSG_EMOTE"] = true,
["CHAT_MSG_FILTERED"] = true,
["CHAT_MSG_GUILD"] = true,
["CHAT_MSG_GUILD_ACHIEVEMENT"] = true,
["CHAT_MSG_IGNORED"] = true,
["CHAT_MSG_LOOT"] = true,
["CHAT_MSG_MONEY"] = true,
["CHAT_MSG_MONSTER_EMOTE"] = true,
["CHAT_MSG_MONSTER_PARTY"] = true,
["CHAT_MSG_MONSTER_SAY"] = true,
["CHAT_MSG_MONSTER_WHISPER"] = true,
["CHAT_MSG_MONSTER_YELL"] = true,
["CHAT_MSG_OFFICER"] = true,
["CHAT_MSG_OPENING"] = true,
["CHAT_MSG_PARTY"] = true,
["CHAT_MSG_PARTY_LEADER"] = true,
["CHAT_MSG_PET_INFO"] = true,
["CHAT_MSG_RAID"] = true,
["CHAT_MSG_RAID_BOSS_EMOTE"] = true,
["CHAT_MSG_RAID_BOSS_WHISPER"] = true,
["CHAT_MSG_RAID_LEADER"] = true,
["CHAT_MSG_RAID_WARNING"] = true,
["CHAT_MSG_RESTRICTED"] = true,
["CHAT_MSG_SAY"] = true,
["CHAT_MSG_SKILL"] = true,
["CHAT_MSG_SYSTEM"] = true,
["CHAT_MSG_TARGETICONS"] = true,
["CHAT_MSG_TEXT_EMOTE"] = true,
["CHAT_MSG_TRADESKILLS"] = true,
["CHAT_MSG_WHISPER"] = true,
["CHAT_MSG_WHISPER_INFORM"] = true,
["CHAT_MSG_YELL"] = true,
["CINEMATIC_START"] = true,
["CINEMATIC_STOP"] = true,
["CLOSE_INBOX_ITEM"] = true,
["CLOSE_TABARD_FRAME"] = true,
["CLOSE_WORLD_MAP"] = true,
["COMBAT_LOG_EVENT"] = true,
["COMBAT_LOG_EVENT_UNFILTERED"] = true,
["COMBAT_RATING_UPDATE"] = true,
["COMBAT_TEXT_UPDATE"] = true,
["COMMENTATOR_ENTER_WORLD"] = true,
["COMMENTATOR_MAP_UPDATE"] = true,
["COMMENTATOR_PLAYER_UPDATE"] = true,
["COMMENTATOR_SKIRMISH_MODE_REQUEST"] = true,
["COMMENTATOR_SKIRMISH_QUEUE_REQUEST"] = true,
["COMPANION_LEARNED"] = true,
["COMPANION_UNLEARNED"] = true,
["COMPANION_UPDATE"] = true,
["CONFIRM_BINDER"] = true,
["CONFIRM_DISENCHANT_ROLL"] = true,
["CONFIRM_LOOT_ROLL"] = true,
["CONFIRM_SUMMON"] = true,
["CONFIRM_TALENT_WIPE"] = true,
["CONFIRM_XP_LOSS"] = true,
["CORPSE_IN_INSTANCE"] = true,
["CORPSE_IN_RANGE"] = true,
["CORPSE_OUT_OF_RANGE"] = true,
["CRITERIA_UPDATE"] = true,
["CURRENCY_DISPLAY_UPDATE"] = true,
["CURRENT_SPELL_CAST_CHANGED"] = true,
["CURSOR_UPDATE"] = true,
["CVAR_UPDATE"] = true,
["DELETE_ITEM_CONFIRM"] = true,
["DISABLE_LOW_LEVEL_RAID"] = true,
["DISABLE_TAXI_BENCHMARK"] = true,
["DISABLE_XP_GAIN"] = true,
["DISPLAY_SIZE_CHANGED"] = true,
["DUEL_FINISHED"] = true,
["DUEL_INBOUNDS"] = true,
["DUEL_OUTOFBOUNDS"] = true,
["DUEL_REQUESTED"] = true,
["ENABLE_LOW_LEVEL_RAID"] = true,
["ENABLE_TAXI_BENCHMARK"] = true,
["ENABLE_XP_GAIN"] = true,
["END_BOUND_TRADEABLE"] = true,
["END_REFUND"] = true,
["EQUIPMENT_SETS_CHANGED"] = true,
["EQUIPMENT_SWAP_FINISHED"] = true,
["EQUIPMENT_SWAP_PENDING"] = true,
["EQUIP_BIND_CONFIRM"] = true,
["EXECUTE_CHAT_LINE"] = true,
["FRIENDLIST_UPDATE"] = true,
["GLYPH_ADDED"] = true,
["GLYPH_DISABLED"] = true,
["GLYPH_ENABLED"] = true,
["GLYPH_REMOVED"] = true,
["GLYPH_UPDATED"] = true,
["GMRESPONSE_RECEIVED"] = true,
["GMSURVEY_DISPLAY"] = true,
["GM_PLAYER_INFO"] = true,
["GOSSIP_CLOSED"] = true,
["GOSSIP_CONFIRM"] = true,
["GOSSIP_CONFIRM_CANCEL"] = true,
["GOSSIP_ENTER_CODE"] = true,
["GOSSIP_SHOW"] = true,
["GUILDBANKBAGSLOTS_CHANGED"] = true,
["GUILDBANKFRAME_CLOSED"] = true,
["GUILDBANKFRAME_OPENED"] = true,
["GUILDBANKLOG_UPDATE"] = true,
["GUILDBANK_ITEM_LOCK_CHANGED"] = true,
["GUILDBANK_TEXT_CHANGED"] = true,
["GUILDBANK_UPDATE_MONEY"] = true,
["GUILDBANK_UPDATE_TABS"] = true,
["GUILDBANK_UPDATE_TEXT"] = true,
["GUILDBANK_UPDATE_WITHDRAWMONEY"] = true,
["GUILDTABARD_UPDATE"] = true,
["GUILD_EVENT_LOG_UPDATE"] = true,
["GUILD_INVITE_CANCEL"] = true,
["GUILD_INVITE_REQUEST"] = true,
["GUILD_MOTD"] = true,
["GUILD_REGISTRAR_CLOSED"] = true,
["GUILD_REGISTRAR_SHOW"] = true,
["GUILD_ROSTER_UPDATE"] = true,
["HONOR_CURRENCY_UPDATE"] = true,
["IGNORELIST_UPDATE"] = true,
["IGR_BILLING_NAG_DIALOG"] = true,
["INSPECT_ACHIEVEMENT_READY"] = true,
["INSPECT_HONOR_UPDATE"] = true,
["INSPECT_TALENT_READY"] = true,
["INSTANCE_BOOT_START"] = true,
["INSTANCE_BOOT_STOP"] = true,
["INSTANCE_ENCOUNTER_ENGAGE_UNIT"] = true,
["INSTANCE_LOCK_START"] = true,
["INSTANCE_LOCK_STOP"] = true,
["ITEM_LOCKED"] = true,
["ITEM_LOCK_CHANGED"] = true,
["ITEM_PUSH"] = true,
["ITEM_TEXT_BEGIN"] = true,
["ITEM_TEXT_CLOSED"] = true,
["ITEM_TEXT_READY"] = true,
["ITEM_TEXT_TRANSLATION"] = true,
["ITEM_UNLOCKED"] = true,
["KNOWLEDGE_BASE_ARTICLE_LOAD_FAILURE"] = true,
["KNOWLEDGE_BASE_ARTICLE_LOAD_SUCCESS"] = true,
["KNOWLEDGE_BASE_QUERY_LOAD_FAILURE"] = true,
["KNOWLEDGE_BASE_QUERY_LOAD_SUCCESS"] = true,
["KNOWLEDGE_BASE_SERVER_MESSAGE"] = true,
["KNOWLEDGE_BASE_SETUP_LOAD_FAILURE"] = true,
["KNOWLEDGE_BASE_SETUP_LOAD_SUCCESS"] = true,
["KNOWLEDGE_BASE_SYSTEM_MOTD_UPDATED"] = true,
["KNOWN_CURRENCY_TYPES_UPDATE"] = true,
["KNOWN_TITLES_UPDATE"] = true,
["LANGUAGE_LIST_CHANGED"] = true,
["LEARNED_SPELL_IN_TAB"] = true,
["LEVEL_GRANT_PROPOSED"] = true,
["LFG_BOOT_PROPOSAL_UPDATE"] = true,
["LFG_COMPLETION_REWARD"] = true,
["LFG_LOCK_INFO_RECEIVED"] = true,
["LFG_OFFER_CONTINUE"] = true,
["LFG_OPEN_FROM_GOSSIP"] = true,
["LFG_PROPOSAL_FAILED"] = true,
["LFG_PROPOSAL_SHOW"] = true,
["LFG_PROPOSAL_SUCCEEDED"] = true,
["LFG_PROPOSAL_UPDATE"] = true,
["LFG_QUEUE_STATUS_UPDATE"] = true,
["LFG_ROLE_CHECK_HIDE"] = true,
["LFG_ROLE_CHECK_ROLE_CHOSEN"] = true,
["LFG_ROLE_CHECK_SHOW"] = true,
["LFG_ROLE_CHECK_UPDATE"] = true,
["LFG_ROLE_UPDATE"] = true,
["LFG_UPDATE"] = true,
["LFG_UPDATE_RANDOM_INFO"] = true,
["LOCALPLAYER_PET_RENAMED"] = true,
["LOGOUT_CANCEL"] = true,
["LOOT_BIND_CONFIRM"] = true,
["LOOT_CLOSED"] = true,
["LOOT_OPENED"] = true,
["LOOT_SLOT_CHANGED"] = true,
["LOOT_SLOT_CLEARED"] = true,
["MACRO_ACTION_BLOCKED"] = true,
["MACRO_ACTION_FORBIDDEN"] = true,
["MAIL_CLOSED"] = true,
["MAIL_FAILED"] = true,
["MAIL_INBOX_UPDATE"] = true,
["MAIL_LOCK_SEND_ITEMS"] = true,
["MAIL_SEND_INFO_UPDATE"] = true,
["MAIL_SEND_SUCCESS"] = true,
["MAIL_SHOW"] = true,
["MAIL_SUCCESS"] = true,
["MAIL_UNLOCK_SEND_ITEMS"] = true,
["MERCHANT_CLOSED"] = true,
["MERCHANT_SHOW"] = true,
["MERCHANT_UPDATE"] = true,
["MINIGAME_UPDATE"] = true,
["MINIMAP_PING"] = true,
["MINIMAP_UPDATE_TRACKING"] = true,
["MINIMAP_UPDATE_ZOOM"] = true,
["MIRROR_TIMER_PAUSE"] = true,
["MIRROR_TIMER_START"] = true,
["MIRROR_TIMER_STOP"] = true,
["MODIFIER_STATE_CHANGED"] = true,
["MOVIE_COMPRESSING_PROGRESS"] = true,
["MOVIE_RECORDING_PROGRESS"] = true,
["MOVIE_UNCOMPRESSED_MOVIE"] = true,
["MUTELIST_UPDATE"] = true,
["NEW_AUCTION_UPDATE"] = true,
["NPC_PVPQUEUE_ANYWHERE"] = true,
["OPEN_MASTER_LOOT_LIST"] = true,
["OPEN_TABARD_FRAME"] = true,
["PARTY_CONVERTED_TO_RAID"] = true,
["PARTY_INVITE_CANCEL"] = true,
["PARTY_INVITE_REQUEST"] = true,
["PARTY_LEADER_CHANGED"] = true,
["PARTY_LFG_RESTRICTED"] = true,
["PARTY_LOOT_METHOD_CHANGED"] = true,
["PARTY_MEMBERS_CHANGED"] = true,
["PARTY_MEMBER_DISABLE"] = true,
["PARTY_MEMBER_ENABLE"] = true,
["PETITION_CLOSED"] = true,
["PETITION_SHOW"] = true,
["PETITION_VENDOR_CLOSED"] = true,
["PETITION_VENDOR_SHOW"] = true,
["PETITION_VENDOR_UPDATE"] = true,
["PET_ATTACK_START"] = true,
["PET_ATTACK_STOP"] = true,
["PET_BAR_HIDE"] = true,
["PET_BAR_HIDEGRID"] = true,
["PET_BAR_SHOWGRID"] = true,
["PET_BAR_UPDATE"] = true,
["PET_BAR_UPDATE_COOLDOWN"] = true,
["PET_BAR_UPDATE_USABLE"] = true,
["PET_DISMISS_START"] = true,
["PET_FORCE_NAME_DECLENSION"] = true,
["PET_RENAMEABLE"] = true,
["PET_SPELL_POWER_UPDATE"] = true,
["PET_STABLE_CLOSED"] = true,
["PET_STABLE_SHOW"] = true,
["PET_STABLE_UPDATE"] = true,
["PET_STABLE_UPDATE_PAPERDOLL"] = true,
["PET_TALENT_UPDATE"] = true,
["PET_UI_CLOSE"] = true,
["PET_UI_UPDATE"] = true,
["PLAYERBANKBAGSLOTS_CHANGED"] = true,
["PLAYERBANKSLOTS_CHANGED"] = true,
["PLAYER_ALIVE"] = true,
["PLAYER_AURAS_CHANGED"] = true,
["PLAYER_CAMPING"] = true,
["PLAYER_CONTROL_GAINED"] = true,
["PLAYER_CONTROL_LOST"] = true,
["PLAYER_DAMAGE_DONE_MODS"] = true,
["PLAYER_DEAD"] = true,
["PLAYER_DIFFICULTY_CHANGED"] = true,
["PLAYER_ENTERING_BATTLEGROUND"] = true,
["PLAYER_ENTERING_WORLD"] = true,
["PLAYER_ENTER_COMBAT"] = true,
["PLAYER_EQUIPMENT_CHANGED"] = true,
["PLAYER_FARSIGHT_FOCUS_CHANGED"] = true,
["PLAYER_FLAGS_CHANGED"] = true,
["PLAYER_FOCUS_CHANGED"] = true,
["PLAYER_GAINS_VEHICLE_DATA"] = true,
["PLAYER_GUILD_UPDATE"] = true,
["PLAYER_LEAVE_COMBAT"] = true,
["PLAYER_LEAVING_WORLD"] = true,
["PLAYER_LEVEL_UP"] = true,
["PLAYER_LOGIN"] = true,
["PLAYER_LOGOUT"] = true,
["PLAYER_LOSES_VEHICLE_DATA"] = true,
["PLAYER_MONEY"] = true,
["PLAYER_PVP_KILLS_CHANGED"] = true,
["PLAYER_PVP_RANK_CHANGED"] = true,
["PLAYER_QUITING"] = true,
["PLAYER_REGEN_DISABLED"] = true,
["PLAYER_REGEN_ENABLED"] = true,
["PLAYER_ROLES_ASSIGNED"] = true,
["PLAYER_SKINNED"] = true,
["PLAYER_TALENT_UPDATE"] = true,
["PLAYER_TARGET_CHANGED"] = true,
["PLAYER_TOTEM_UPDATE"] = true,
["PLAYER_TRADE_MONEY"] = true,
["PLAYER_UNGHOST"] = true,
["PLAYER_UPDATE_RESTING"] = true,
["PLAYER_XP_UPDATE"] = true,
["PLAYTIME_CHANGED"] = true,
["PLAY_MOVIE"] = true,
["PREVIEW_PET_TALENT_POINTS_CHANGED"] = true,
["PREVIEW_TALENT_POINTS_CHANGED"] = true,
["PVPQUEUE_ANYWHERE_SHOW"] = true,
["PVPQUEUE_ANYWHERE_UPDATE_AVAILABLE"] = true,
["QUEST_ACCEPTED"] = true,
["QUEST_ACCEPT_CONFIRM"] = true,
["QUEST_COMPLETE"] = true,
["QUEST_DETAIL"] = true,
["QUEST_FINISHED"] = true,
["QUEST_GREETING"] = true,
["QUEST_ITEM_UPDATE"] = true,
["QUEST_LOG_UPDATE"] = true,
["QUEST_POI_UPDATE"] = true,
["QUEST_PROGRESS"] = true,
["QUEST_QUERY_COMPLETE"] = true,
["QUEST_WATCH_UPDATE"] = true,
["RAID_INSTANCE_WELCOME"] = true,
["RAID_ROSTER_UPDATE"] = true,
["RAID_TARGET_UPDATE"] = true,
["RAISED_AS_GHOUL"] = true,
["READY_CHECK"] = true,
["READY_CHECK_CONFIRM"] = true,
["RECEIVED_ACHIEVEMENT_LIST"] = true,
["REPLACE_ENCHANT"] = true,
["RESURRECT_REQUEST"] = true,
["RUNE_POWER_UPDATE"] = true,
["RUNE_TYPE_UPDATE"] = true,
["SCREENSHOT_FAILED"] = true,
["SCREENSHOT_SUCCEEDED"] = true,
["SEND_MAIL_COD_CHANGED"] = true,
["SEND_MAIL_MONEY_CHANGED"] = true,
["SKILL_LINES_CHANGED"] = true,
["SOCKET_INFO_CLOSE"] = true,
["SOCKET_INFO_UPDATE"] = true,
["SOUND_DEVICE_UPDATE"] = true,
["SPELLS_CHANGED"] = true,
["SPELL_UPDATE_COOLDOWN"] = true,
["SPELL_UPDATE_USABLE"] = true,
["START_AUTOREPEAT_SPELL"] = true,
["START_LOOT_ROLL"] = true,
["START_MINIGAME"] = true,
["STOP_AUTOREPEAT_SPELL"] = true,
["SYNCHRONIZE_SETTINGS"] = true,
["SYSMSG"] = true,
["TABARD_CANSAVE_CHANGED"] = true,
["TABARD_SAVE_PENDING"] = true,
["TALENTS_INVOLUNTARILY_RESET"] = true,
["TAXIMAP_CLOSED"] = true,
["TAXIMAP_OPENED"] = true,
["TIME_PLAYED_MSG"] = true,
["TRACKED_ACHIEVEMENT_UPDATE"] = true,
["TRADE_ACCEPT_UPDATE"] = true,
["TRADE_CLOSED"] = true,
["TRADE_MONEY_CHANGED"] = true,
["TRADE_PLAYER_ITEM_CHANGED"] = true,
["TRADE_POTENTIAL_BIND_ENCHANT"] = true,
["TRADE_REPLACE_ENCHANT"] = true,
["TRADE_REQUEST"] = true,
["TRADE_REQUEST_CANCEL"] = true,
["TRADE_SHOW"] = true,
["TRADE_SKILL_CLOSE"] = true,
["TRADE_SKILL_FILTER_UPDATE"] = true,
["TRADE_SKILL_SHOW"] = true,
["TRADE_SKILL_UPDATE"] = true,
["TRADE_TARGET_ITEM_CHANGED"] = true,
["TRADE_UPDATE"] = true,
["TRAINER_CLOSED"] = true,
["TRAINER_DESCRIPTION_UPDATE"] = true,
["TRAINER_SHOW"] = true,
["TRAINER_UPDATE"] = true,
["TUTORIAL_TRIGGER"] = true,
["UI_ERROR_MESSAGE"] = true,
["UI_INFO_MESSAGE"] = true,
["UNIT_ATTACK"] = true,
["UNIT_ATTACK_POWER"] = true,
["UNIT_ATTACK_SPEED"] = true,
["UNIT_AURA"] = true,
["UNIT_CLASSIFICATION_CHANGED"] = true,
["UNIT_COMBAT"] = true,
["UNIT_COMBO_POINTS"] = true,
["UNIT_DAMAGE"] = true,
["UNIT_DEFENSE"] = true,
["UNIT_DISPLAYPOWER"] = true,
["UNIT_ENERGY"] = true,
["UNIT_ENTERED_VEHICLE"] = true,
["UNIT_ENTERING_VEHICLE"] = true,
["UNIT_EXITED_VEHICLE"] = true,
["UNIT_EXITING_VEHICLE"] = true,
["UNIT_FACTION"] = true,
["UNIT_FLAGS"] = true,
["UNIT_FOCUS"] = true,
["UNIT_HAPPINESS"] = true,
["UNIT_HEALTH"] = true,
["UNIT_INVENTORY_CHANGED"] = true,
["UNIT_LEVEL"] = true,
["UNIT_MANA"] = true,
["UNIT_MAXENERGY"] = true,
["UNIT_MAXFOCUS"] = true,
["UNIT_MAXHAPPINESS"] = true,
["UNIT_MAXHEALTH"] = true,
["UNIT_MAXMANA"] = true,
["UNIT_MAXRAGE"] = true,
["UNIT_MAXRUNIC_POWER"] = true,
["UNIT_MODEL_CHANGED"] = true,
["UNIT_NAME_UPDATE"] = true,
["UNIT_PET"] = true,
["UNIT_PET_EXPERIENCE"] = true,
["UNIT_PORTRAIT_UPDATE"] = true,
["UNIT_QUEST_LOG_CHANGED"] = true,
["UNIT_RAGE"] = true,
["UNIT_RANGEDDAMAGE"] = true,
["UNIT_RANGED_ATTACK_POWER"] = true,
["UNIT_RESISTANCES"] = true,
["UNIT_RUNIC_POWER"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
["UNIT_SPELLCAST_FAILED_QUIET"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_INTERRUPTIBLE"] = true,
["UNIT_SPELLCAST_NOT_INTERRUPTIBLE"] = true,
["UNIT_SPELLCAST_SENT"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_SUCCEEDED"] = true,
["UNIT_STATS"] = true,
["UNIT_TARGET"] = true,
["UNIT_THREAT_LIST_UPDATE"] = true,
["UNIT_THREAT_SITUATION_UPDATE"] = true,
["UPDATE_BATTLEFIELD_SCORE"] = true,
["UPDATE_BATTLEFIELD_STATUS"] = true,
["UPDATE_BINDINGS"] = true,
["UPDATE_BONUS_ACTIONBAR"] = true,
["UPDATE_CHAT_COLOR"] = true,
["UPDATE_CHAT_COLOR_NAME_BY_CLASS"] = true,
["UPDATE_CHAT_WINDOWS"] = true,
["UPDATE_EXHAUSTION"] = true,
["UPDATE_FACTION"] = true,
["UPDATE_FLOATING_CHAT_WINDOWS"] = true,
["UPDATE_GM_STATUS"] = true,
["UPDATE_INSTANCE_INFO"] = true,
["UPDATE_INVENTORY_ALERTS"] = true,
["UPDATE_INVENTORY_DURABILITY"] = true,
["UPDATE_LFG_LIST"] = true,
["UPDATE_LFG_LIST_INCREMENTAL"] = true,
["UPDATE_LFG_TYPES"] = true,
["UPDATE_MACROS"] = true,
["UPDATE_MASTER_LOOT_LIST"] = true,
["UPDATE_MOUSEOVER_UNIT"] = true,
["UPDATE_MULTI_CAST_ACTIONBAR"] = true,
["UPDATE_PENDING_MAIL"] = true,
["UPDATE_SHAPESHIFT_COOLDOWN"] = true,
["UPDATE_SHAPESHIFT_FORM"] = true,
["UPDATE_SHAPESHIFT_FORMS"] = true,
["UPDATE_SHAPESHIFT_USABLE"] = true,
["UPDATE_STEALTH"] = true,
["UPDATE_TICKET"] = true,
["UPDATE_TRADESKILL_RECAST"] = true,
["UPDATE_WORLD_STATES"] = true,
["USE_BIND_CONFIRM"] = true,
["USE_GLYPH"] = true,
["VARIABLES_LOADED"] = true,
["VEHICLE_ANGLE_SHOW"] = true,
["VEHICLE_ANGLE_UPDATE"] = true,
["VEHICLE_PASSENGERS_CHANGED"] = true,
["VEHICLE_POWER_SHOW"] = true,
["VEHICLE_UPDATE"] = true,
["VOICE_CHANNEL_STATUS_UPDATE"] = true,
["VOICE_CHAT_ENABLED_UPDATE"] = true,
["VOICE_LEFT_SESSION"] = true,
["VOICE_PLATE_START"] = true,
["VOICE_PLATE_STOP"] = true,
["VOICE_PUSH_TO_TALK_START"] = true,
["VOICE_PUSH_TO_TALK_STOP"] = true,
["VOICE_SELF_MUTE"] = true,
["VOICE_SESSIONS_UPDATE"] = true,
["VOICE_START"] = true,
["VOICE_STATUS_UPDATE"] = true,
["VOICE_STOP"] = true,
["VOTE_KICK_REASON_NEEDED"] = true,
["WEAR_EQUIPMENT_SET"] = true,
["WHO_LIST_UPDATE"] = true,
["WORLD_MAP_NAME_UPDATE"] = true,
["WORLD_MAP_UPDATE"] = true,
["WORLD_STATE_UI_TIMER_UPDATE"] = true,
["WOW_MOUSE_NOT_FOUND"] = true,
["ZONE_CHANGED"] = true,
["ZONE_CHANGED_INDOORS"] = true,
["ZONE_CHANGED_NEW_AREA"] = true,
}

local object = CreateFrame("Frame")
local mt = getmetatable(object).__index

local oldEvent = mt.RegisterEvent
mt.RegisterEvent = function(self, event)
	if not t[event] then
		print(event)
	end

	return oldEvent(self, event)
end


local ipairs = ipairs
local pairs = pairs
local ceil, floor = math.ceil, math.floor

local GetInstanceInfo = GetInstanceInfo
local GetNumGroupMembers = GetNumGroupMembers
local GetNumPartyMembers = GetNumPartyMembers
local GetNumRaidMembers = GetNumRaidMembers

function tInvert(tbl)
	local inverted = {};
	for k, v in pairs(tbl) do
		inverted[v] = k;
	end
	return inverted;
end

function Mixin(object, ...)
	for i = 1, select("#", ...) do
		local mixin = select(i, ...);
		for k, v in pairs(mixin) do
			object[k] = v;
		end
	end

	return object;
end

function CreateFromMixins(...)
	return Mixin({}, ...)
end

function Lerp(startValue, endValue, amount)
	return (1 - amount) * startValue + amount * endValue
end

function Clamp(value, min, max)
	if value > max then
		return max
	elseif value < min then
		return min
	end
	return value
end

function Saturate(value)
	return Clamp(value, 0.0, 1.0)
end

local TARGET_FRAME_PER_SEC = 60.0;
function DeltaLerp(startValue, endValue, amount, timeSec)
	return Lerp(startValue, endValue, Saturate(amount * timeSec * TARGET_FRAME_PER_SEC));
end

function FrameDeltaLerp(startValue, endValue, amount, tickTime)
	return DeltaLerp(startValue, endValue, amount, tickTime)
end

function Round(value)
	if value < 0 then
		return ceil(value - .5);
	end
	return floor(value + .5);
end

function tIndexOf(tbl, item)
	for i, v in ipairs(tbl) do
		if item == v then
			return i;
		end
	end
end

local g_updatingBars = {};

local function IsCloseEnough(bar, newValue, targetValue)
	local min, max = bar:GetMinMaxValues();
	local range = max - min
	if range > 0.0 then
		return math.abs((newValue - targetValue) / range) < .00001
	end

	return true;
end

do
	local f = CreateFrame("Frame")
	f:Show()
	f:SetScript("OnUpdate", function(_, elapsed)
		for bar, targetValue in pairs(g_updatingBars) do
			local effectiveTargetValue = Clamp(targetValue, bar:GetMinMaxValues())
			local newValue = FrameDeltaLerp(bar:GetValue(), effectiveTargetValue, .25, elapsed)

			if IsCloseEnough(bar, newValue, effectiveTargetValue) then
				g_updatingBars[bar] = nil
				bar:SetValue(effectiveTargetValue)
			else
				bar:SetValue(newValue)
			end
		end
	end)
end

SmoothStatusBarMixin = {}

function SmoothStatusBarMixin:ResetSmoothedValue(value)
	local targetValue = g_updatingBars[self]
	if targetValue then
		g_updatingBars[self] = nil
		self:SetValue(value or targetValue)
	elseif value then
		self:SetValue(value)
	end
end

function SmoothStatusBarMixin:SetSmoothedValue(value)
	g_updatingBars[self] = value
end

function SmoothStatusBarMixin:SetMinMaxSmoothedValue(min, max)
	self:SetMinMaxValues(min, max)

	local targetValue = g_updatingBars[self]
	if targetValue then
		local ratio = 1
		if max ~= 0 and self.lastSmoothedMax and self.lastSmoothedMax ~= 0 then
			ratio = max / self.lastSmoothedMax
		end

		g_updatingBars[self] = targetValue * ratio
	end

	self.lastSmoothedMin = min
	self.lastSmoothedMax = max
end

local oldGetInstanceDifficulty = GetInstanceDifficulty
function GetInstanceDifficulty()
	local diff = oldGetInstanceDifficulty()
	if diff == 1 then
		local _, _, difficulty, _, maxPlayers = GetInstanceInfo()
		if difficulty == 1 and maxPlayers == 25 then
			diff = 2
		end
	end
	return diff
end

function IsInGroup()
	return (GetNumRaidMembers() == 0 and GetNumPartyMembers() > 0)
end

function IsInRaid()
	return GetNumRaidMembers() > 0
end

function GetNumSubgroupMembers()
	return GetNumPartyMembers()
end

function GetNumGroupMembers()
	return GetNumRaidMembers()
end

if not C_Timer or C_Timer._version ~= 2 then
	local setmetatable = setmetatable
	local type = type
	local tinsert = table.insert
	local tremove = table.remove

	C_Timer = C_Timer or {}
	C_Timer._version = 2

	local TickerPrototype = {}
	local TickerMetatable = {
		__index = TickerPrototype,
		__metatable = true
	}

	local waitTable = {}
	local waitFrame = TimerFrame or CreateFrame("Frame", "TimerFrame", UIParent)
	waitFrame:SetScript("OnUpdate", function(self, elapsed)
		local total = #waitTable
		local i = 1

		while i <= total do
			local ticker = waitTable[i]

			if ticker._cancelled then
				tremove(waitTable, i)
				total = total - 1
			elseif ticker._delay > elapsed then
				ticker._delay = ticker._delay - elapsed
				i = i + 1
			else
				ticker._callback(ticker)

				if ticker._remainingIterations == -1 then
					ticker._delay = ticker._duration
					i = i + 1
				elseif ticker._remainingIterations > 1 then
					ticker._remainingIterations = ticker._remainingIterations - 1
					ticker._delay = ticker._duration
					i = i + 1
				elseif ticker._remainingIterations == 1 then
					tremove(waitTable, i)
					total = total - 1
				end
			end
		end

		if #waitTable == 0 then
			self:Hide()
		end
	end)

	local function AddDelayedCall(ticker, oldTicker)
		if oldTicker and type(oldTicker) == "table" then
			ticker = oldTicker
		end

		tinsert(waitTable, ticker)
		waitFrame:Show()
	end

	_G.AddDelayedCall = AddDelayedCall

	local function CreateTicker(duration, callback, iterations)
		local ticker = setmetatable({}, TickerMetatable)
		ticker._remainingIterations = iterations or -1
		ticker._duration = duration
		ticker._delay = duration
		ticker._callback = callback

		AddDelayedCall(ticker)

		return ticker
	end

	function C_Timer:After(duration, callback)
		return CreateTicker(duration, callback, 1)
	end

	function C_Timer:NewTimer(duration, callback)
		return CreateTicker(duration, callback, 1)
	end

	function C_Timer:NewTicker(duration, callback, iterations)
		return CreateTicker(duration, callback, iterations)
	end

	function TickerPrototype:Cancel()
		self._cancelled = true
	end
end

RAID_CLASS_COLORS.HUNTER.colorStr = "ffabd473"
RAID_CLASS_COLORS.WARLOCK.colorStr = "ff8788ee"
RAID_CLASS_COLORS.PRIEST.colorStr = "ffffffff"
RAID_CLASS_COLORS.PALADIN.colorStr = "fff58cba"
RAID_CLASS_COLORS.MAGE.colorStr = "ff3fc7eb"
RAID_CLASS_COLORS.ROGUE.colorStr = "fffff569"
RAID_CLASS_COLORS.DRUID.colorStr = "ffff7d0a"
RAID_CLASS_COLORS.SHAMAN.colorStr = "ff0070de"
RAID_CLASS_COLORS.WARRIOR.colorStr = "ffc79c6e"
RAID_CLASS_COLORS.DEATHKNIGHT.colorStr = "ffc41f3b"