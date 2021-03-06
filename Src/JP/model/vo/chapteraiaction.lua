slot0 = class("ChapterAIAction", import(".BaseVO"))

function slot0.Ctor(slot0, slot1)
	slot0.line = {
		row = slot1.ai_pos.row,
		column = slot1.ai_pos.column
	}
	slot0.stgId = slot1.strategy_id

	if slot1.target_pos then
		slot0.stgTarget = {
			row = slot1.target_pos.row,
			column = slot1.target_pos.column
		}
	end

	slot0.movePath = _.map(slot1.move_path, function (slot0)
		return {
			row = slot0.row,
			column = slot0.column
		}
	end)
	slot0.shipUpdate = _.map(slot1.ship_update, function (slot0)
		return {
			id = slot0.id,
			hpRant = slot0.hp_rant
		}
	end)
end

function slot0.applyTo(slot0, slot1, slot2)
	if slot1:getChampion(slot0.line.row, slot0.line.column) then
		return slot0:applyToChampion(slot1, slot3, slot2)
	end

	return false, "can not find any object at: [" .. slot0.line.row .. ", " .. slot0.line.column .. "]"
end

function slot0.applyToChampion(slot0, slot1, slot2, slot3)
	slot4 = 0

	if slot2.flag == 1 then
		return false, "can not apply ai to dead champion at: [" .. slot0.line.row .. ", " .. slot0.line.column .. "]"
	end

	slot5 = 0

	if slot0.stgId > 0 then
		if not pg.strategy_data_template[slot0.stgId] then
			return false, "can not find strategy: " .. slot0.stgId
		end
	elseif #slot0.movePath > 0 then
		if _.any(slot0.movePath, function (slot0)
			return not slot0:getChapterCell(slot0.row, slot0.column) or not slot1.walkable
		end) then
			return false, "invalide move path"
		end

		if not slot3 then
			slot2.row = slot0.movePath[#slot0.movePath].row
			slot2.column = slot0.movePath[#slot0.movePath].column
			slot5 = bit.bor(slot5, ChapterConst.DirtyChampion)

			if slot1:existFleet(FleetType.Submarine, slot2.row, slot2.column) then
				slot5 = bit.bor(slot5, ChapterConst.DirtyFleet)
			end
		end
	end

	return true, slot5
end

return slot0
