-- settings:
-- autosave interval
data:extend({
    {
        name = 'autosaveAlert_interval',
        type = 'int-setting',
        setting_type = 'runtime-global',
        default_value = 10,
        order = "0500"
    }
})

-- warnings active:
--  TODO: 10s countdown
--  TODO: 10s warning
--  TODO: 30s warning
--  1m warning
--  2m warning
--  5m warning
--  TODO: 10m warning
-- TODO: play sound? (maybe per warning?)
