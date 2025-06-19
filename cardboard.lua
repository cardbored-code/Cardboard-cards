--splitting jokers and decks into separate files so it's easier to look at
local mod_contents = {
    "jokers",
    "decks",
	"consumeables",
	"seals"
}

--load mod files
for k, v in pairs(mod_contents) do 
    assert(SMODS.load_file("/content/"..v..".lua"))()
    print("CARDBOARD: /content/"..v..".lua loaded")
end

--danke cryptid and mathisfun :3
--and yahoomouse since i actually grabbed this code from his mod lmao
G.C.CDPURPLE = HEX("655dfc")
G.C.CDBLUE = HEX("34009c")
G.C.mid_flash = 0
G.C.vort_time = 7
G.C.vort_speed = 0.4

-- from cryptid :}
local oldfunc = Game.main_menu
Game.main_menu = function(change_context)
	local ret = oldfunc(change_context)
	G.SPLASH_BACK:define_draw_steps({
			{
				shader = "splash",
				send = {
					{ name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
           			{name = 'vort_speed', val = G.C.vort_speed},
            		{name = 'colour_1', ref_table = G.C, ref_value = 'CDPURPLE'},
            		{name = 'colour_2', ref_table = G.C, ref_value = 'CDBLUE'},
            		{name = 'mid_flash', ref_table = G.C, ref_value = 'mid_flash'},
				},
			},
		})
	return ret
end