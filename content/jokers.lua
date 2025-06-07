SMODS.Atlas{
    key = "Jokers",
    path = "jokers.png",
    px = 71,
    py = 95,
}

--INFO: This is required cause talisman is weird and won't let me do comparisions between values unless I add these lines
--Remember to add to_big(whatever) to that stuff
if not to_big then
    to_big = function(num)
        return num
    end
end

--X3
SMODS.Joker{
    key = "goober_joker",
    loc_txt = {
        name = "X3",
        text = {
            "{X:mult,C:white}X#1#{} Mult"
        }
    },
    atlas = "Jokers",
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    cost = 6,
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 6, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { extra = {
        Xmult = 3
    }},
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.Xmult}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then 
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = "X" .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
    end
}

--Sliced Joker
SMODS.Joker{
    key = "sliced_joker",
    loc_txt = {
        name = "Sliced Joker",
        text = {
            "Gains {C:mult}+#2#{} Mult",
            "for every Mult card scored",
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
        }
    },
    atlas = "Jokers",
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    cost = 7,
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 4, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { extra = {
        mult = 0,
        mult_gain = 3
    }},
    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_mult
        return {vars = {card.ability.extra.mult, card.ability.extra.mult_gain}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then 
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if SMODS.has_enhancement(context.other_card, "m_mult") then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
				    message = 'Upgraded!',
				    colour = G.C.MULT,
				    -- The return value, "card", is set to the variable "card", which is the joker.
				    -- Basically, this tells the return value what it's affecting, which if it's the joker itself, it's usually card.
				    -- It can be things like card = context.other_card in some cases, so specifying card (return value) = card (variable from function) is required.
				    card = card
			    }
            end
        end
    end
}

--Dice Cat
SMODS.Joker{
    key = "dice_cat",
    loc_txt = {
        name = "Dice Cat",
        text = {
            "Gives a {C:attention}D6 Tag {}",
            "after defeating a Boss Blind"
        }
    },
    atlas = "Jokers",
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    cost = 4,
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = G.P_TAGS.tag_d_six
    end,
    calculate = function(self,card,context)
        if context.end_of_round and context.cardarea == G.jokers and G.GAME.blind.boss and not context.blueprint then
            add_tag(Tag('tag_d_six')) --REMEMBER TO LOOK AT LOCALIZATION FILES
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            return {
                message = 'D6!',
                colour = G.C.GREEN
            }
        end
    end
}

--High-roller Cat
SMODS.Joker{
    key = "rerolldollar_cat",
    loc_txt = {
        name = "High-roller Cat",
        text = {
            "Earn {C:money}$#1#{} every time",
            "you reroll"
        }
    },
    atlas = "Jokers",
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    cost = 6,
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 3, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { extra = {
        money = 2
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.money}}
    end,
    calculate = function(self,card,context)
        if context.reroll_shop and not context.blueprint then
            return {
                dollars = card.ability.extra.money
            }
        end
    end
}

--Deckfixing my beloved
SMODS.Joker{
    key = "deckfixing_joker",
    loc_txt = {
        name = "Deckfixing my beloved",
        text = {
            "Kings are awesome",
            "Kings are awesome",
            "{C:attention}Scored Kings on first hand{}",
            "{C:attention}create a copy of themselves{}",
            "Kings are awesome"
        }
    },
    atlas = "Jokers",
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    cost = 9,
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 5, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { extra = {
        copy = 1
    }},
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.copy}}
    end,
    calculate = function(self,card,context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.individual and context.cardarea == G.play and G.GAME.current_round.hands_played == 0 then
            if context.other_card:get_id() == 13 then --check if is king or nah
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local copy_card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
                copy_card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, copy_card)
                G.hand:emplace(copy_card)
                copy_card.states.visible = nil

                G.E_MANAGER:add_event(Event({
                    func = function()
                        copy_card:start_materialize()
                        return true
                    end
                }))
                return {
                    message = localize('k_copied_ex'),
                    colour = G.C.CHIPS,
                    func = function() -- This is for timing purposes, it runs after the message
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.calculate_context({ playing_card_added = true, cards = { copy_card } })
                                return true
                            end
                        }))
                    end
                }
            end
        end
    end
}

--Angry Pussy
SMODS.Joker{
    key = "mult_cat",
    loc_txt = {
        name = "Angry Pussy",
        text = {
            "Turns all scored {C:attention}face{} cards",
            "into {C:mult}Mult{} cards",
            "{C:inactive,s:0.8}I can understand a cute kitty,",
            "{C:inactive,s:0.8}but I cant understand angry pussi",
            "{C:inactive,s:0.7}-Vsauce Joey, 2015{}",
            "{C:red,s:0.7}NOTE: crashes Cryptid"
        }
    },
    atlas = "Jokers",
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    cost = 6,
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 2, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    --[[config = { extra = {
        Xmult = 4
    }},]]
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = G.P_CENTERS.m_mult
        --return {vars = {center.ability.extra.Xmult}}
    end,
    calculate = function(self,card,context)
        if context.before and not context.blueprint then 
            local faces = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:is_face() then
                    faces[#faces+1] = scored_card
                    scored_card:set_ability("m_mult", nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if #faces > 0 then 
                return {
                    message = localize('k_mult'),
                    colour = G.C.MULT,
                    card = self
                }
            end
        end
    end
}

--:3
SMODS.Joker{
    key = "evil_goober_joker",
    loc_txt = {
        name = ":3",
        text = {
            --"{X:mult,C:white}:#1#{} Mult"
            "{X:purple,C:white}:3{} Mult"
        }
    },
    atlas = "Jokers",
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    cost = 6,
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { extra = {
        Xmult = 1/3
    }},
    --[[loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.Xmult}}
    end,]]
    calculate = function(self,card,context)
        if context.joker_main then 
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                --message = ":" .. math.floor(card.ability.extra.Xmult),
                message = ":3",
                colour = G.C.MULT
            }
        end
    end
}

--Leaf Joker
SMODS.Joker{
    key = "leaf_joker",
    loc_txt = {
        name = "Leaf Joker",
        text = {
            "Gains {C:chips}+#2#{} Chips",
            "for every {C:clubs}Club{} card scored",
            "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
            "{C:inactive,s:0.8}yes i know clubs aren't green but",
            "{C:inactive,s:0.8}im saving this joker for later"
        }
    },
    atlas = "Jokers",
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    cost = 5,
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 7, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { extra = {
        chips = 0,
        chips_gain = 5
    }},
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.chips, card.ability.extra.chips_gain}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then 
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card:is_suit("Clubs") then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
                return {
				    message = 'Upgraded!',
				    colour = G.C.CHIPS,
				    -- The return value, "card", is set to the variable "card", which is the joker.
				    -- Basically, this tells the return value what it's affecting, which if it's the joker itself, it's usually card.
				    -- It can be things like card = context.other_card in some cases, so specifying card (return value) = card (variable from function) is required.
				    card = card
			    }
            end
        end
    end
}

--Ugly Color Palette Joker
SMODS.Joker{
    key = "ugly_color_joker",
    loc_txt = {
        name = "Ugly Color Palette Joker",
        text = {
            "Gains {C:chips}+#2#{} Chips at end of round,",
            "increases exponentially",
            "{C:inactive}Resets at {C:attention}512{}{C:inactive} Chips",
            "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
        }
    },
    atlas = "Jokers",
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    cost = 8,
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { extra = {
        chips = 2,
        chips_gain = 2
    }},
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.chips, card.ability.extra.chips_gain}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then 
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
            if card.ability.extra.chips < 512 then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
                card.ability.extra.chips_gain = card.ability.extra.chips_gain * 2
                return {
                    message = 'Upgraded!',
                    colour = G.C.CHIPS,
                    -- The return value, "card", is set to the variable "card", which is the joker.
                    -- Basically, this tells the return value what it's affecting, which if it's the joker itself, it's usually card.
                    -- It can be things like card = context.other_card in some cases, so specifying card (return value) = card (variable from function) is required.
                    card = card
                }
            end
            if card.ability.extra.chips >= 512 then
                card.ability.extra.chips = 2
                card.ability.extra.chips_gain = 2
                return {
                    message = 'Reset',
                    colour = G.C.CHIPS,
                    card = card
                }
            end
        end
    end
}

--Integer Overflow
SMODS.Joker{
    key = "overflow_joker",
    loc_txt = {
        name = "Integer Overflow",
        text = {
            --"{X:mult,C:white}:#1#{} Mult"
            "Gives a {C:red}Rare Tag{} at end of round",
            "if round score is over {C:red}twice{} the blind score"
        }
    },
    atlas = "Jokers",
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    cost = 8,
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = G.P_TAGS.tag_rare
    end,
    calculate = function(self,card,context)
        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then 
            if to_big(G.GAME.chips) / to_big(G.GAME.blind.chips) >= to_big(2) then --this shit apparently breaks talisman lmao
                add_tag(Tag('tag_rare')) --REMEMBER TO LOOK AT LOCALIZATION FILES
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return {
                    message = 'Balatro!',
                    colour = G.C.MULT
                }
            end
        end
    end
}

--Integer Underflow
SMODS.Joker{
    key = "underflow_joker",
    loc_txt = {
        name = "Integer Underflow",
        text = {
            "{C:money}$#1#{} at end of round",
            "if {C:attention}final hand{} doesn't score more",
            "than {C:attention}half{} of the blind score"
        }
    },
    atlas = "Jokers",
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    cost = 7,
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 2, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { extra = {
        money = 6
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.money}}
    end,
    calculate = function(self,card,context)
        if context.final_scoring_step then
           card.ability.extra.final_hand_score = hand_chips * mult --hand_chips * mult is hand score 
        end
    end,
    calc_dollar_bonus = function(self, card)
		local bonus = card.ability.extra.money
        if G.GAME.current_round.hands_left == 0 and to_big(card.ability.extra.final_hand_score) < (to_big(G.GAME.blind.chips) / to_big(2)) then 
		    if bonus > 0 then 
                return bonus 
            end
        end
	end
}

--Purple Seal Joker
SMODS.Joker{
    key = "purple_seal_joker",
    loc_txt = {
        name = "Purple Seal Joker",
        text = {
            "Adds a {C:purple}Purple Seal{} to all",
            "scored cards on first hand"
        }
    },
    atlas = "Jokers",
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    cost = 5,
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 3, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { extra = {
        seal = "Purple"
    }},
    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue+1] = {key = "purple_seal", set = "Other", vars = {}}
        --return {vars = {card.ability.extra.Xmult}}
    end,
    calculate = function(self,card,context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.before and G.GAME.current_round.hands_played == 0 and not context.blueprint then 
            for i, scored_card in ipairs(context.scoring_hand) do
                scored_card:set_seal(card.ability.extra.seal, nil, true)
            end
            return {
                message = 'Purple Seal!',
                colour = G.C.PURPLE
            }
        end
    end
}

--Purple Joker
SMODS.Joker{
    key = "purple_joker",
    loc_txt = {
        name = "Purple Joker",
        text = {
            "{X:mult,C:white}X#1#{} Mult if played hand",
            "only has scoring {C:hearts}Hearts{} and/or {C:clubs}Clubs{}"
        }
    },
    atlas = "Jokers",
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    cost = 6,
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 4, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { extra = {
        Xmult = 2.5
    }},
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.Xmult}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then 
            local hearts_or_clubs = true
            for _, scored_card in ipairs(context.scoring_hand) do
                if not (scored_card:is_suit('Hearts') or scored_card:is_suit('Clubs')) then
                    hearts_or_clubs = false
                end
            end
            if hearts_or_clubs == true then
                return { --ples put this always
                    card = card,
                    Xmult_mod = card.ability.extra.Xmult,
                    message = "X" .. card.ability.extra.Xmult,
                    colour = G.C.MULT
                }
            end
        end
    end
}