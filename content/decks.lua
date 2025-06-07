SMODS.Atlas{
    key = "Decks",
    path = "decks.png",
    px = 71,
    py = 95,
}

SMODS.Back{
    name = "Too Silly Deck",
    key = "silly",
    atlas = 'Decks',
    pos = {x = 0, y = 0},
    loc_txt = {
        name ="Too Silly Deck",
        text={
            "Start run with an {C:red}Eternal{} {C:attention}:3{}"
        },
    },
    discovered = true,
    unlocked = true,
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local card = SMODS.create_card({
                    set = 'Joker',
                    area = G.jokers,
                    key = 'j_cardboard_evil_goober_joker',
                })
                card:add_to_deck()
                G.jokers:emplace(card)
                card:set_eternal(true)
                return true
            end
        }))
    end
}

SMODS.Back{
    name = "Budget Cuts Deck",
    key = "budget",
    atlas = 'Decks',
    pos = {x = 1, y = 0},
    config = {only_one_rank = '3'},
    loc_txt = {
        name ="Budget Cuts Deck",
        text={
            "Start run with only {C:attention}four{} 3s",
            "in deck"
        },
    },
    discovered = true,
    unlocked = true,
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local trandom_s = {
                    "Clubs",
                    "Diamonds",
                    "Hearts",
                    "Spades"
                }

                --if not G.playing_cards then return false end
                for i, v in pairs(G.playing_cards) do
                    v:start_dissolve()
                    if i > 47 then
                        break
                    end
                end

                for _, card in pairs(G.playing_cards) do
                    assert(SMODS.change_base(card, trandom_s[math.random(#trandom_s)], self.config.only_one_rank))
                end
                return true
            end
        }))
    end
}
