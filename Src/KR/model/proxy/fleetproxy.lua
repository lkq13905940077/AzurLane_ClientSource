slot0 = class("FleetProxy", import(".NetProxy"))
slot0.FLEET_ADDED = "fleet added"
slot0.FLEET_UPDATED = "fleet updated"
slot0.FLEET_RENAMED = "fleet renamed"
slot0.PVP_FLEET_ID = 101

function slot0.register(slot0)
	slot0:on(12101, function (slot0)
		slot0.data = {}

		for slot4, slot5 in ipairs(slot0.group_list) do
			slot6 = Fleet.New(slot5)

			slot6:display("loaded")

			slot0.data[slot6.id] = slot6
		end

		for slot4 = 1, FormationUI.MAX_FLEET_NUM, 1 do
			if not slot0.data[slot4] then
				slot0.data[slot4] = Fleet.New({
					name = "",
					id = slot4,
					ship_list = {},
					commanders = {}
				})
			end
		end

		if not slot0.data[slot1.PVP_FLEET_ID] then
			slot0.data[slot1.PVP_FLEET_ID] = Fleet.New({
				name = "",
				id = slot1.PVP_FLEET_ID,
				ship_list = {},
				commanders = {}
			})
		end

		if LOCK_SUBMARINE then
			for slot4, slot5 in pairs(slot0.data) do
				if slot5.id == 11 or slot5.id == 12 then
					slot0.data[slot4] = nil
				end
			end
		end
	end)
	slot0:on(12106, function (slot0)
		if slot0.data[Fleet.New(slot0.group).id] then
			slot0:updateFleet(slot1)
		else
			slot0:addFleet(slot1)
		end
	end)
end

function slot0.addFleet(slot0, slot1)
	slot0.data[slot1.id] = slot1:clone()

	slot0.data[slot1.id]:display("added")
	slot0.facade:sendNotification(slot0.FLEET_ADDED, slot1:clone())
end

function slot0.updateFleet(slot0, slot1)
	slot0.data[slot1.id] = slot1:clone()

	slot0.data[slot1.id]:display("updated")
	slot0.facade:sendNotification(slot0.FLEET_UPDATED, slot1.id)
end

function slot0.saveEdittingFleet(slot0)
	if slot0.editSrcCache == nil then
		slot0.editSrcCache = Clone(slot0.data)
	end

	if slot0.EdittingFleet ~= nil then
		slot0.data[slot0.EdittingFleet.id] = slot0.EdittingFleet
	end
end

function slot0.commitEdittingFleet(slot0, slot1)
	if slot0.EdittingFleet ~= nil then
		slot0.facade:sendNotification(GAME.UPDATE_FLEET, {
			fleet = slot0.EdittingFleet,
			callback = function ()
				slot0.editSrcCache = nil
				slot0.EdittingFleet = nil

				if nil then
					slot1()
				end
			end
		})
	elseif slot1 then
		slot1()
	end
end

function slot0.abortEditting(slot0)
	if slot0.editSrcCache then
		slot0.data = slot0.editSrcCache
		slot0.editSrcCache = nil
	end

	slot0.EdittingFleet = nil
end

function slot0.getCount(slot0)
	return table.getCount(slot0.data)
end

function slot0.getFleetById(slot0, slot1)
	if slot0.data[slot1] ~= nil then
		return slot0.data[slot1]:clone()
	end

	return nil
end

function slot0.getAllShipIds(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.data) do
		for slot10, slot11 in ipairs(slot6.ships) do
			table.insert(slot1, slot11)
		end
	end

	return slot1
end

function slot0.getFirstFleetShipCount(slot0)
	slot1 = 0

	for slot5, slot6 in ipairs(slot0.data[1].ships) do
		slot1 = slot1 + 1
	end

	return slot1
end

function slot0.inPvpFleet(slot0, slot1)
	if slot0.data[FleetProxy.PVP_FLEET_ID]:containShip(slot1) then
		return true
	end

	return false
end

function slot0.getFleetByShip(slot0, slot1)
	for slot5, slot6 in pairs(slot0.data) do
		if slot6:containShip(slot1) then
			return slot6:clone()
		end
	end

	return nil
end

function slot0.renameFleet(slot0, slot1, slot2)
	slot3 = slot0:getFleetById(slot1)
	slot3.name = slot2

	slot0:updateFleet(slot3)
	slot0.facade:sendNotification(slot0.FLEET_RENAMED, slot3:clone())
end

function slot0.getCommandersInFleet(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.data) do
		for slot10, slot11 in pairs(slot6:getCommanders()) do
			table.insert(slot1, slot11.id)
		end
	end

	return slot1
end

function slot0.getCommanders(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.data) do
		for slot10, slot11 in pairs(slot6:getCommanders()) do
			table.insert(slot1, {
				fleetId = slot6.id,
				pos = slot10,
				commanderId = slot11.id
			})
		end
	end

	return slot1
end

return slot0
