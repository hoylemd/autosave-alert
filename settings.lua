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
--  10s countdown
--  10s warning
--  30s warning
--  1m warning
--  5m warning
--  10m warning
-- play sound? (maybe per warning?)
