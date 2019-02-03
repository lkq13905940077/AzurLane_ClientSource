slot0 = class("ChatConst")
slot0.CODE_BANED = 100
slot0.CODE_GUILDBOSS_OPEN = 200
slot0.CODE_ACTBOSS_MSG_ADDED = 300
slot0.ChannelAll = 1
slot0.ChannelWorld = 2
slot0.ChannelPublic = 3
slot0.ChannelFriend = 4
slot0.ChannelGuild = 5
slot0.SendChannels = {
	slot0.ChannelWorld,
	slot0.ChannelGuild
}
slot0.RecvChannels = {
	slot0.ChannelAll,
	slot0.ChannelWorld,
	slot0.ChannelPublic,
	slot0.ChannelFriend,
	slot0.ChannelGuild
}

function slot0.GetChannelName(slot0)
	return i18n("channel_name_" .. slot0)
end

function slot0.GetChannelSprite(slot0)
	if slot0 == slot0.ChannelWorld then
		return "world"
	elseif slot0 == slot0.ChannelPublic then
		return "public"
	elseif slot0 == slot0.ChannelFriend then
		return "friend"
	elseif slot0 == slot0.ChannelGuild then
		return "guild"
	elseif slot0 == slot0.ChannelAll then
		return "total"
	end
end

slot0.EmojiCommon = 0
slot0.EmojiDefault = 1
slot0.EmojiAnimate = 2
slot0.EmojiPixel = 3
slot0.EmojiTypes = {
	slot0.EmojiCommon,
	slot0.EmojiDefault,
	slot0.EmojiAnimate,
	slot0.EmojiPixel
}
slot0.EmojiCode = "{777#code#777}"
slot0.EmojiCodeMatch = "{777#(%d+)#777}"
slot0.EMOJI_SAVE_TAG = "emoji_regular_used_"

return slot0
