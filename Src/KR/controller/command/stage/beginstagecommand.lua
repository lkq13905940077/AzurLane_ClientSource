class("BeginStageCommand", pm.SimpleCommand).execute = function (slot0, slot1)
	slot4 = getProxy(FleetProxy)
	slot5 = getProxy(PlayerProxy)
	slot6 = nil
	slot7 = getProxy(BayProxy)

	ys.Battle.BattleState.GenerateVertifyData()

	if slot1:getBody().system == SYSTEM_PROLOGUE then
		slot0:sendNotification(GAME.BEGIN_STAGE_DONE, {
			prefabFleet = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(slot9).fleet_prefab,
			stageId = PROLOGUE_DUNGEON,
			system = slot3,
			drops = {}
		})
	else
		if slot3 == SYSTEM_SCENARIO or slot3 == SYSTEM_ROUTINE or slot3 == SYSTEM_DUEL or slot3 == SYSTEM_SHAM or slot3 == SYSTEM_GUILD or slot3 == SYSTEM_CHALLENGE or slot3 == SYSTEM_ACT_BOSS then
			if slot3 ~= SYSTEM_DUEL and slot3 ~= SYSTEM_SHAM and slot3 ~= SYSTEM_CHALLENGE and getProxy(PlayerProxy).getData(slot8).ship_bag_max <= getProxy(BayProxy).getShipCount(slot10) then
				NoPosMsgBox(i18n("switch_to_shop_tip_noDockyard"), openDockyardClear, gotoChargeScene)

				return
			end

			slot8 = {}
			slot9 = 0
			slot10 = 0
			slot11 = 0
			slot12 = 0
			slot13 = nil

			if slot3 == SYSTEM_SCENARIO then
				for slot20, slot21 in ipairs(slot13) do
					slot8[#slot8 + 1] = slot21.id
				end

				slot17, slot18 = slot15:getFleetCost(slot16)
				slot9 = slot17.gold
				slot10 = slot17.oil
				slot11 = slot17.gold + slot18.gold
				slot12 = slot17.oil + slot18.oil
			elseif slot3 == SYSTEM_SHAM then
				for slot20, slot21 in ipairs(slot13) do
					slot8[#slot8 + 1] = slot21.id
				end
			elseif slot3 == SYSTEM_GUILD then
				for slot20, slot21 in ipairs(slot13) do
					slot8[#slot8 + 1] = slot21.id
				end
			elseif slot3 == SYSTEM_CHALLENGE then
				for slot20, slot21 in ipairs(slot13) do
					slot8[#slot8 + 1] = slot21.id
				end
			else
				if slot4:getFleetById(slot2.mainFleetId) == nil or slot6:isEmpty() then
					pg.TipsMgr:GetInstance():ShowTips(i18n("stage_beginStage_error_fleetEmpty"))

					return
				end

				slot14, slot15 = slot6:isLegalToFight()

				if slot14 ~= true then
					pg.TipsMgr:GetInstance():ShowTips(i18n("stage_beginStage_error_teamEmpty", Fleet.C_TEAM_NAME[slot14], slot15))

					return
				end

				slot16 = pg.ship_data_template

				for slot20, slot21 in ipairs(slot13) do
					slot8[#slot8 + 1] = slot21.id
				end

				if slot3 ~= SYSTEM_DUEL then
					slot10 = slot6:getStartCost().oil
					slot12 = slot6:GetCostSum().oil
				end
			end

			slot14 = slot5:getData()

			if slot3 ~= SYSTEM_DUEL and slot3 ~= SYSTEM_SHAM and slot3 ~= SYSTEM_GUILD and slot3 ~= SYSTEM_CHALLENGE and slot14.oil < slot12 then
				pg.TipsMgr:GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

				return
			end

			slot15 = slot4:getFleetById(slot2.supportFleetId)
			slot16 = slot2.stageId
			slot17 = {}
			slot18, slot19 = nil
			slot20 = getProxy(MilitaryExerciseProxy)
			slot21 = slot5:getData()

			if slot3 == SYSTEM_DUEL then
				if not slot20:getSeasonInfo():canExercise() then
					pg.TipsMgr:GetInstance():ShowTips(i18n("exercise_count_insufficient"))

					return
				end

				rivalVO = getProxy(MilitaryExerciseProxy):getRivalById(slot2.rivalId)
			elseif slot3 == SYSTEM_SHAM then
				slot23 = getProxy(ChapterProxy).getShamChapter(slot22)
				rivalVO = slot23:getChapterCell(slot23.fleet.line.row, slot23.fleet.line.column).rival
				slot16 = rivalVO.id
			elseif slot3 == SYSTEM_GUILD then
			elseif slot3 == SYSTEM_CHALLENGE then
			else
				slot17 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[slot16].dungeon_id).fleet_prefab
			end

			if rivalVO then
				slot22 = 0

				for slot26, slot27 in ipairs(rivalVO.mainShips) do
					slot22 = slot22 + slot27.level
				end

				for slot26, slot27 in ipairs(rivalVO.vanguardShips) do
					slot22 = slot22 + slot27.level
				end

				RivalLevelVertiry = slot22
			end

			for slot26, slot27 in pairs(slot22) do
				if not slot27:attrVertify() then
					BattleVertify.playerShipVertifyFail = true

					break
				end
			end

			pg.ConnectionMgr.GetInstance():Send(40001, {
				data = slot16,
				system = slot3,
				ship_id_list = slot8
			}, 40002, function (slot0)
				if slot0.result == 0 then
					slot1 = {}

					for slot5, slot6 in ipairs(slot0.drop_performance) do
						if slot1[slot6.enemy_id] == nil then
							slot1[slot6.enemy_id] = {}
						end

						table.insert(slot1[slot6.enemy_id], {
							resourceCount = slot6.resource_num,
							itemCount = slot6.other_num
						})
					end

					if slot0 == SYSTEM_DUEL then
						slot1 = ys.Battle.BattleConfig.ARENA_LIST[math.random(#ys.Battle.BattleConfig.ARENA_LIST)]
					elseif slot0 == SYSTEM_SHAM then
						slot3 = getProxy(ChapterProxy).getShamChapter(slot2)
						slot1 = (slot3:getConfig("rival_index")[slot3.progress + 1] and slot4[3]) or 90001
					elseif slot0 == SYSTEM_GUILD then
						slot1 = pg.guild_boss_template[slot1].dungeon_id
					elseif slot0 == SYSTEM_CHALLENGE then
					else
						slot2:consume({
							gold = slot3,
							oil = 
						})

						slot2 = pg.gameset.battle_consume_energy.key_value

						if slot0 == SYSTEM_SCENARIO and getProxy(ChapterProxy).getActiveChapter(slot3).getPlayType(slot4) == ChapterConst.TypeExtra then
							slot2 = 0
						end

						for slot6, slot7 in ipairs(slot5) do
							slot7:cosumeEnergy(slot2)
							slot6:updateShip(slot7)
						end
					end

					slot7:updatePlayer(slot7.updatePlayer)

					slot2 = nil

					slot9:sendNotification(GAME.BEGIN_STAGE_DONE, {
						mainFleetId = ((slot0 ~= SYSTEM_SCENARIO and slot0 ~= SYSTEM_SHAM and slot0 ~= SYSTEM_GUILD and slot0 ~= SYSTEM_CHALLENGE) or nil) and slot8.id,
						prefabFleet = slot10,
						rivalId = slot11,
						stageId = slot1,
						system = slot0,
						token = slot0.key,
						drops = slot1
					})
				elseif slot0.result == 10 then
					pg.TipsMgr:GetInstance():ShowTips(ERROR_MESSAGE[10])
				else
					pg.TipsMgr:GetInstance():ShowTips(errorTip("stage_beginStage", slot0.result))
					slot9:sendNotification(GAME.BEGIN_STAGE_ERRO, slot0.result)
				end
			end)

			return
		end

		if slot3 == SYSTEM_DEBUG then
			slot8 = PROLOGUE_DUNGEON

			if slot4:getFleetById(1) == nil or slot9:isEmpty() then
				pg.TipsMgr:GetInstance():ShowTips(i18n("stage_beginStage_error_fleetEmpty"))

				return
			end

			slot0:sendNotification(GAME.BEGIN_STAGE_DONE, {
				mainFleetId = 1,
				prefabFleet = {},
				stageId = slot8,
				system = slot3,
				drops = {}
			})
		elseif slot3 == SYSTEM_PERFORM then
			slot8 = slot2.stageId

			function slot9(slot0)
				slot1:sendNotification(GAME.BEGIN_STAGE_DONE, {
					prefabFleet = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(slot1).fleet_prefab,
					stageId = slot0,
					system = slot2,
					token = slot0,
					drops = {},
					memory = slot3.memory,
					exitCallback = slot3.exitCallback
				})
			end

			if slot2.memory then
				slot9()
			else
				pg.ConnectionMgr.GetInstance():Send(40001, {
					data = slot8,
					system = slot3,
					ship_id_list = {}
				}, 40002, function (slot0)
					if slot0.result == 0 then
						slot0:sendNotification(GAME.STORY_UPDATE, {
							storyId = pg.StoryMgr:GetInstance():GetStoryByName("index")[slot1]
						})
						slot0.sendNotification(slot0.key)
					elseif slot0.result == 10 then
						pg.TipsMgr:GetInstance():ShowTips(ERROR_MESSAGE[10])
					else
						pg.TipsMgr:GetInstance():ShowTips(errorTip("stage_beginStage", slot0.result))
						slot0:sendNotification(GAME.BEGIN_STAGE_ERRO, slot0.result)
					end
				end)
			end
		elseif slot3 == SYSTEM_DODGEM then
			slot0:sendNotification(GAME.BEGIN_STAGE_DONE, {
				prefabFleet = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(slot9).fleet_prefab,
				stageId = slot2.stageId,
				system = slot3,
				drops = {}
			})
		end
	end
end

return class("BeginStageCommand", pm.SimpleCommand)
