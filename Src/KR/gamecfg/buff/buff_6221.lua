return {
	time = 8,
	name = "剑鱼(818中队)",
	init_effect = "",
	picture = "",
	desc = "8s减速",
	stack = 1,
	id = 6221,
	icon = 6221,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAddAttrRatio",
			trigger = {
				"onAttach",
				"onStack",
				"onRemove"
			},
			arg_list = {
				number = -6000,
				attr = "velocity",
				group = {
					id = 18,
					level = 2
				}
			}
		}
	}
}