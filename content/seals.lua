SMODS.Atlas{
    key = "Seals",
    path = "seals.png",
    px = 71,
    py = 95,
}

SMODS.Seal{
    name = "Blue Peg",
    key = "blue_peg",
    badge_colour = HEX("3773ed"),
    atlas = "Seals",
    pos = {x = 1, y = 0},
    config = {x_chips = 1.5},
    discovered = true,
    loc_txt = {
        label = "Blue Peg",
        -- Tooltip description
        name = 'Blue Peg',
        text = {
            "{X:chips,C:white}X#1#{} Chips"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.x_chips} }
    end,
    -- self - this seal prototype
    -- card - card this seal is applied to
    calculate = function(self, card, context)
        -- main_scoring context is used whenever the card is scored
        if context.main_scoring and context.cardarea == G.play then
            return {
                x_chips = self.config.x_chips
            }
        end
    end
}

SMODS.Seal{
    name = "Orange Peg",
    key = "orange_peg",
    badge_colour = HEX("eb7a34"),
    atlas = "Seals",
    pos = {x = 0, y = 0},
    config = {x_mult = 1, x_mult_gain = 0.2},
    discovered = true,
    loc_txt = {
        label = "Orange Peg",
        -- Tooltip description
        name = 'Orange Peg',
        text = {
            "Gains {X:mult,C:white}X#2#{} Mult",
            "when this card is played and scored",
            "{C:inactive}Currently {X:mult,C:white}X#1#{}{C:inactive} Mult"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.seal.x_mult, self.config.x_mult_gain} }
    end,
    -- self - this seal prototype
    -- card - card this seal is applied to
    calculate = function(self, card, context)
        -- main_scoring context is used whenever the card is scored
        if context.main_scoring and context.cardarea == G.play then
            card.ability.seal.x_mult = card.ability.seal.x_mult + self.config.x_mult_gain
            return {
                x_mult = card.ability.seal.x_mult
            }
        end
    end
}


--Score
SMODS.Consumable {
    key = 'score',
    set = 'Spectral',
    atlas = "Spectrals",
    object_type = "Consumable",
    pos = { x = 2, y = 0 },
    loc_txt = {
        name = "Score",
        text = {
            "Add a {C:green,E:2}random Peg{}",
            "to {C:attention}1{} selected",
            "card in your hand"
        }
    },
    cost = 4,
    discovered = true,      -- Mark as discovered.
    unlocked = true,        -- Available by default.
    config = {max_highlighted = 1},
    use = function(self, card, area, copier)
        local pegs = {
            "cardboard_blue_peg",
            "cardboard_orange_peg"
        }

        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
            G.E_MANAGER:add_event(Event({func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true end }))
            
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.hand.highlighted[i]:set_seal(pseudorandom_element(pegs, pseudoseed('score')), nil, true)
                return true end }))
            
            delay(0.5)
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end
}


