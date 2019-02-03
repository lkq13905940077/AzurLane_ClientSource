slot0 = class("ActivityConst")
slot0.ACTIVITY_TYPE_BUILDSHIP_1 = 1
slot0.ACTIVITY_TYPE_BUILDSHIP_2 = 2
slot0.ACTIVITY_TYPE_7DAYSLOGIN = 3
slot0.ACTIVITY_TYPE_LEVELAWARD = 4
slot0.ACTIVITY_TYPE_LEVELPLAN = 5
slot0.ACTIVITY_TYPE_MONTHSIGN = 6
slot0.ACTIVITY_TYPE_MILITARY_EXERCISE = 7
slot0.ACTIVITY_TYPE_PROGRESSLOGIN = 8
slot0.ACTIVITY_TYPE_CHARGEAWARD = 9
slot0.ACTIVITY_TYPE_EVENT = 11
slot0.ACTIVITY_TYPE_ZPROJECT = 12
slot0.ACTIVITY_TYPE_TASKS = 13
slot0.ACTIVITY_TYPE_SHOP = 14
slot0.ACTIVITY_TYPE_DAILY_TASK = 15
slot0.ACTIVITY_TYPE_PT_RANK = 16
slot0.ACTIVITY_TYPE_TASK_LIST = 18
slot0.ACTIVITY_TYPE_VOTE = 19
slot0.ACTIVITY_TYPE_BB = 20
slot0.ACTIVITY_TYPE_PUZZLA = 21
slot0.ACTIVITY_TYPE_LOTTERY = 22
slot0.ACTIVITY_TYPE_CHALLENGE_RANK = 24
slot0.ACTIVITY_TYPE_BUILD = 26
slot0.ACTIVITY_TYPE_SHOP_STREET = 27
slot0.ACTIVITY_TYPE_MIRROR = 28
slot0.ACTIVITY_TYPE_BUFF = 30
slot0.ACTIVITY_TYPE_COLORING = 31
slot0.ACTIVITY_TYPE_HITMONSTERNIAN = 32
slot0.ACTIVITY_TYPE_CARD_PAIRS = 33
slot0.ACTIVITY_TYPE_BOSS_BATTLE = 34
slot0.ACTIVITY_TYPE_ANSWER = 35
slot0.ACTIVITY_TYPE_EXTRA_CHAPTER_RANK = 36
slot0.ACTIVITY_TYPE_CHALLENGE = 37
slot0.ACTIVITY_TYPE_SUMMARY = 38
slot0.ACTIVITY_TYPE_TASK_LIST_MONITOR = 39
slot0.ACTIVITY_TYPE_TASK_RES = 40
slot0.ACTIVITY_TYPE_SUMMARY = 40
slot0.ACTIVITY_TYPE_VIRTUAL_BAG = 41
slot0.ACTIVITY_TYPE_REFLUX = 42
slot0.ACTIVITY_TYPE_COLORING_ALPHA = 43
slot0.ACTIVITY_TYPE_GUIDE_TASKS = 44
slot0.ACTIVITY_TYPE_LINK_LINK = 45
slot0.ACTIVITY_TYPE_SHOP_DISCOUNT = 48
slot0.ACTIVITY_TYPE_LOTTERY_AWARD = 49
slot0.ACTIVITY_TYPE_DODGEM = 50
slot0.ACTIVITY_TYPE_MONOPOLY = 51
slot0.TASK_ACTIVITY_ID = 16
slot0.MILITARY_EXERCISE_ACTIVITY_ID = 7
slot0.ANNIVERSARY_TASK_LIST_ID = 116
slot0.CHANGMENLUAO_BATTLE_ACTIVITY_ID = 114
slot0.CHANGMEN_7DAYS_LOGIN = 122
slot0.CHANGMEN_TASK_LIST = 118
slot0.ACT_BOSS_TASK_LIST = 20066
slot0.ACT_NPC_SHIP_ID = 184
slot0.ACTIVITY_BATTLE_MAP_ID = 1070000
slot0.BATTLE_MAP_TYPE = 1
slot0.SELECT_MAP_DIFFICULT = false
slot0.SWITCH_ACT_MAP_LIMIT = false
slot0.QIXI_ACTIVITY_ID = 27
slot0.JYHZ_ACTIVITY_ID = 31
slot0.MIRROR_ACTIVITY_ID = -1
slot0.XIAOTIANE_ACTIVITY_ID = 30005
slot0.KELEIWEN_ACTIVITY_ID = 30004
slot0.Z23_ACTIVITY_ID = 30038
slot0.GR_ACTIVITY_ID = 107
slot0.WOWS_ACTIVITY_ID = 10088
slot0.BILI_ACTIVITY_ID = 125
slot0.BILI_TASK_LIST_PT_ID = 124
slot0.RUYUE_ACTIVITY_ID = 109
slot0.AOERLIANG_TASK_ID = 135
slot0.AOERLIANG_SIGN_ID = 136
slot0.ACTIVITY_TYPE_TASK_RES_ID = 146
slot0.VAMPIRE_SIGN_ID = 147
slot0.CENTAUR_ACTIVITY_ID = 148
slot0.XIAOBEIFA_ACTIVITY_PT_ID = 151
slot0.MIKASA_MUSEUM_DAILY_TASK_ID = 153
slot0.MIKASA_MUSEUM_ACTIVITY_ID = 155
slot0.LINK_RES_GOLD_ID = 157
slot0.LINE_SIGN_ID = 158
slot0.LOGIN_YEAR_ID = 161
slot0.SHOW_DRESS_ACTIVITY_ID = 159
slot0.SKIN_YAMASHIRO = 166
slot0.BOSS_BATTLE_PT = 171
slot0.SKIN_BEILI = 30026
slot0.UTAWARERU_ACTIVITY_PT_ID = 181
slot0.UTAWARERU_PREVIEW_ID = 185
slot0.UTAWARERU_TASK_LIST_ID = 187
slot0.SIPEI_RERE_ACTIVITY_ID = 30062
slot0.LONGXIANG_ACTIVITY_PT_ID = 199
slot0.SKIN_OSHIO = 204
slot0.LOGIN_SANTA = 206
slot0.AMAGI_PREVIEW_ID = 207
slot0.AMAGI_ACTIVITY_PT_ID = 212
slot0.OMIKUJI_LOTTERY_AWARD_ID = 215
slot0.LINK_RES_RE = 217
slot0.LINK_RES = 218
slot0.LINE_SIGN_ID_RE = 219
slot0.AOERLIANG_RE_PREVIEW_ID = 220
slot0.AOERLIANG_RE_TASK_ID = 222
slot0.AOERLIANG_RE_SIGN_ID = 223
slot0.WINTER_RE_PREVIEW_ID = 224
slot0.PIG_YEAR_RED_POCKET_SHIP_ID = 232
slot0.NEW_YEAR_OVERVIEW = 30064
slot0.LOGIN_SANTA = 30047
slot0.OMIKUJI_LOTTERY_AWARD_ID = 30049
slot0.AMAGI_PREVIEW_ID = 30050
slot0.AMAGI_ACTIVITY_PT_ID = 30055
slot0.PINTU_TASK_ID = 30028
slot0.ELITE_AWARD_ACTIVITY_ID = 40
slot0.HIDE_PT_PANELS = false
slot0.WITHOUT_ACTIVITY = 0
slot0.MONOPOLY_OP_THROW = 1
slot0.MONOPOLY_OP_MOVE = 2
slot0.MONOPOLY_OP_TRIGGER = 3
slot0.MONOPOLY_OP_AWARD = 4

function slot0.BBRule(slot0)
	_.each(slot0, function (slot0)
		slot0[slot0] = slot0[slot0] + 1
	end)

	slot2 = 7

	if _.all({
		0,
		0,
		0,
		0,
		0,
		0
	}, function (slot0)
		return slot0 == 1
	end) then
		slot2 = 2
	else
		for slot6, slot7 in ipairs(slot1) do
			if slot6 == 4 then
				if slot7 >= 4 then
					slot2 = math.min(slot2, 1)
				elseif slot7 >= 3 then
					slot2 = math.min(slot2, 3)
				elseif slot7 >= 2 then
					slot2 = math.min(slot2, 5)
				elseif slot7 >= 1 then
					slot2 = math.min(slot2, 6)
				end
			elseif slot7 >= 5 then
				slot2 = math.min(slot2, 1)
			elseif slot7 >= 4 then
				slot2 = math.min(slot2, 4)
			end
		end
	end

	return slot2
end

return slot0
