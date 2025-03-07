local suits = {'hearts', 'clubs', 'diamonds', 'spades'}
local ranks_full = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'}
local ranks_num = {'Ace', '2', '3', '4', '5', '6', '7', '8', '9', '10'}
local ranks_face = {'Jack', 'Queen', 'King'}
local display_ranks = {'Ace', 'King', 'Queen', 'Jack', '10'}

-- style_map: construct mapping to atlas for selected style
--     contrast: 'lc', 'hc' (low contrast, high contrast)
--     suit_idx: 1-numbered index of suit as it is in atlas (and in suits table)
--     flavor: 'face-only', 'k1-ace', 'k10-ace'

function style_map(contrast, suit_idx, flavor)
    local map = {}

    for idx, rank in ipairs(ranks_full) do
        map[rank] = {
            atlas = 'rw-full-'..contrast,
            pos = {x = idx - 1, y = suit_idx - 1}
        }
    end

    if flavor == 'k1-ace' then
        for idx, rank in ipairs(ranks_num) do
            map[rank] = {
                atlas = 'rw-k1ace-'..contrast,
                pos = {x = idx - 1, y = suit_idx - 1}
            }
        end
    end

    return map
end


-- generate atlases
local atlas_path = {
    {'RW-Full-LC.png', 'rw-full-lc'},
    {'RW-Full-HC.png', 'rw-full-hc'},
    {'RW-K1-Aces-LC.png', 'rw-k1ace-lc'},
    {'RW-K1-Aces-HC.png', 'rw-k1ace-hc'}
}
for _, x in ipairs(atlas_path) do
    SMODS.Atlas{
        key = x[2],
        px = 71,
        py = 95,
        path = x[1],
        prefix_config = {key = false},
    }
end

-- generate entries
for idx, suit in ipairs(suits) do
    SMODS.DeckSkin{
        key = suit.."_skin",
        suit = suit:gsub("^%l", string.upper),
        loc_txt = { ['en-us'] = "Rain World" },
        palettes = {{
                key = 'k10ace-lc',
                ranks = ranks_full,
                display_ranks = display_ranks,
                atlas = 'rw-full-lc',
                posStyle = style_map('lc', idx, 'k10-ace'),
                loc_txt = {['en-us'] = "K10 Aces"},
            },
            {
                key = 'k10ace-hc',
                ranks = ranks_full,
                display_ranks = display_ranks,
                atlas = 'rw-full-lc',
                posStyle = style_map('hc', idx, 'k10-ace'),
                loc_txt = {['en-us'] = "K10 Aces (High Contrast)"},
                hc_default = true
            },
            {
                key = 'k1ace-lc',
                ranks = ranks_full,
                display_ranks = display_ranks,
                atlas = 'rw-full-lc',
                posStyle = style_map('lc', idx, 'k1-ace'),
                loc_txt = {['en-us'] = "K1 Aces"},
            },
            {
                key = 'k1ace-hc',
                ranks = ranks_full,
                display_ranks = display_ranks,
                atlas = 'rw-full-lc',
                posStyle = style_map('hc', idx, 'k1-ace'),
                loc_txt = {['en-us'] = "K1 Aces (High Contrast)"},
                hc_default = true
            },
            {
                key = 'faceonly-lc',
                ranks = ranks_face,
                display_ranks = display_ranks,
                atlas = 'rw-full-lc',
                posStyle = style_map('lc', idx, 'face-only'),
                loc_txt = {['en-us'] = "Face Cards"},
            },
            {
                key = 'faceonly-hc',
                ranks = ranks_face,
                display_ranks = display_ranks,
                atlas = 'rw-full-lc',
                posStyle = style_map('hc', idx, 'face-only'),
                loc_txt = {['en-us'] = "Face Cards (High Contrast)"},
                hc_default = true
            }
        }
    }
end
