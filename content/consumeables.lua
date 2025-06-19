SMODS.Atlas{
    key = "Spectrals",
    path = "spectrals.png",
    px = 71,
    py = 95,
}

--Greed
SMODS.Consumable {
    key = 'greed',
    set = 'Spectral',
    atlas = "Spectrals",
    object_type = "Consumable",
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Greed",
        text = {
            "Creates one",
            "{C:attention}Steel Red Seal{}",
            "{C:attention}King of Hearts{}"
        }
    },
    cost = 4,
    discovered = true,      -- Mark as discovered.
    unlocked = true,        -- Available by default.
    config = {},
    use = function(self, card, area, copier)
        local used_tarot = copier or card

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                used_tarot:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = function()
                local card = create_playing_card({ front = G.P_CARDS["H_K"], center = G.P_CENTERS.m_steel }, G.hand, nil, { G.C.SECONDARY_SET.Spectral })
                card:set_seal("Red") --apparently it's that easy
                SMODS.calculate_context({ playing_card_added = true, cards = card })
                return true
            end
        }))
        delay(0.3)
    end,

    can_use = function(self, card)
        return G.hand and #G.hand.cards > 1
    end
}

--Ticket
SMODS.Consumable {
    key = 'value',
    set = 'Spectral',
    atlas = "Spectrals",
    pos = { x = 1, y = 0 },
    loc_txt = {
        name = "Value",
        text = {
            "Gain {C:money}money{} based on",
            "the {C:chips}chip{} value of",
            "{C:attention}one random card{}",
            "in your hand",
            "{C:inactive,s:0.8}(e.g. a 3 gives $3, Kings give $10 etc.)"
        }
    },
    cost = 4,
    discovered = true,      -- Mark as discovered.
    unlocked = true,        -- Available by default.
    config = {},

    use = function(self, card, area, copier)
        local selected_card = pseudorandom_element(G.hand.cards, pseudoseed('random_select'))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                selected_card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.5)
        ease_dollars(selected_card.base.nominal)
        delay(0.3)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end
}