slot0 = class("ChapterPreCombatMediator", import("..base.ContextMediator"))
slot0.ON_START = "ChapterPreCombatMediator:ON_START"
slot0.ON_SWITCH_SHIP = "ChapterPreCombatMediator:ON_SWITCH_SHIP"
slot0.ON_SWITCH_FLEET = "ChapterPreCombatMediator:ON_SWITCH_FLEET"
slot0.ON_OP = "ChapterPreCombatMediator:ON_OP"
slot0.ON_AUTO = "ChapterPreCombatMediator:ON_AUTO"

function slot0.register(slot0)
	slot0:bind(slot0.ON_SWITCH_SHIP, function (slot0, slot1, slot2)
		slot3 = getProxy(ChapterProxy)

		slot3:getActiveChapter().fleet.switchShip(slot5, slot1, slot2)
		slot3:updateChapter(slot3.getActiveChapter(), ChapterConst.DirtyFleet)
	end)
	slot0:bind(slot0.ON_AUTO, function (slot0, slot1)
		slot0:onAutoBtn(slot1)
	end)
	slot0:bind(slot0.ON_START, function (slot0)
		slot2 = getProxy(ChapterProxy).getActiveChapter(slot1)
		slot4 = slot2:getStageId(slot2.fleet.line.row, slot2.fleet.line.column)
		slot5 = false
		slot6 = ""

		for slot10, slot11 in pairs(slot2.fleet.ships) do
			if slot11.energy == Ship.ENERGY_LOW then
				slot5 = true
				slot6 = slot6 .. "「" .. slot11:getConfig("name") .. "」"
			end
		end

		if slot5 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("ship_energy_low_warn", slot3.name, slot6),
				onYes = function ()
					slot0:sendNotification(GAME.BEGIN_STAGE, {
						system = SYSTEM_SCENARIO,
						stageId = slot0
					})
				end
			})
		else
			slot8 = ""

			if getProxy(PlayerProxy):getData():GoldMax(1) then
				slot8 = i18n("gold_max_tip_title") .. i18n("resource_max_tip_battle")
			end

			if slot8 ~= "" then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = slot8,
					onYes = function ()
						slot0:sendNotification(GAME.BEGIN_STAGE, {
							system = SYSTEM_SCENARIO,
							stageId = slot0
						})
					end
				})
			else
				slot0:sendNotification(GAME.BEGIN_STAGE, {
					system = SYSTEM_SCENARIO,
					stageId = slot4
				})
			end
		end
	end)
	slot0:bind(slot0.ON_OP, function (slot0, slot1)
		slot0:sendNotification(GAME.CHAPTER_OP, slot1)
	end)
	slot0.viewComponent:setPlayerInfo(getProxy(PlayerProxy):getRawData())
	slot0:display()
end

function slot0.onAutoBtn(slot0, slot1)
	slot0:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = slot1.isOn,
		toggle = slot1.toggle
	})
end

function slot0.listNotificationInterests(slot0)
	return {
		PlayerProxy.UPDATED,
		GAME.BEGIN_STAGE_ERRO,
		GAME.CHAPTER_OP_DONE
	}
end

function slot0.handleNotification(slot0, slot1)
	slot3 = slot1:getBody()

	if slot1:getName() == PlayerProxy.UPDATED then
		slot0.viewComponent:setPlayerInfo(getProxy(PlayerProxy):getRawData())
	elseif slot2 == GAME.BEGIN_STAGE_ERRO then
		setActive(slot0.viewComponent._startBtn, true)

		if slot3 == 3 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("battle_preCombatMediator_timeout"),
				onYes = function ()
					slot0.viewComponent:emit(BaseUI.ON_CLOSE)
				end
			})
		end
	elseif slot2 == GAME.CHAPTER_OP_DONE and (slot3.type == ChapterConst.OpStrategy or slot3.type == ChapterConst.OpRepair or slot3.type == ChapterConst.OpRequest) then
		slot0:display()
	end
end

function slot0.display(slot0)
	slot0.viewComponent:updateChapter(getProxy(ChapterProxy).getActiveChapter(slot1))
end

return slot0