local spans = require('spans')

local function hello_world()
    game.print("hello, world")
end

local function inflect(count, singular, plural)
    if count == 1 then
        return count .. ' ' .. singular
    end

    if plural == nil then
        plural = singular .. 's'
    end
    return count .. ' ' .. plural
end

local function humanize_ticks(total_ticks)
    local ticks = total_ticks

    local hours = math.floor(ticks / spans.one_hour)
    ticks = ticks - hours * spans.one_hour

    local minutes = math.floor(ticks / spans.one_minute)
    ticks = ticks - minutes * spans.one_minute

    local seconds = math.floor(ticks / spans.one_second)
    ticks = ticks - seconds * spans.one_second

    local readout = ''
    if hours > 0 then
        readout = readout .. inflect(hours, 'hour')
    end

    if minutes > 0 then
        if readout ~= '' then
            readout = readout .. ', '
        end
        readout = readout .. inflect(minutes, 'minute')
    end

    if seconds > 0 then
        if readout ~= '' then
            readout = readout .. ', '
        end
        readout = readout .. inflect(seconds, 'second')
    end

    return readout
end

local function on_offset_interval(event)
    if event.tick == 0 then
        -- don't do anything on tick 0
        return
    end
    local current_offset = event.tick % global.autosave_interval
    local ticks_to_autosave = global.autosave_interval - current_offset

    if current_offset == 0 then
        -- remove sub-minute handler?
        return
    end

    for i,offset in ipairs(global.warnings) do
        if ticks_to_autosave == offset then
            game.print('Autosave in ' .. humanize_ticks(ticks_to_autosave))
        end
    end

    -- add sub-minute handler?
    -- if current_offset <= spans.one_minute do
end

local function RegisterWarningHandler()
    script.on_nth_tick(spans.one_minute, on_offset_interval)
end

local function update_settings()
    local autosave_minutes = settings.global['autosaveAlert_interval'].value
    global.autosave_interval = spans.one_minute * autosave_minutes

    global.warnings = {}
    global.warnings[1] = spans.one_minute
    global.warnings[2] = spans.one_minute * 2
    global.warnings[3] = spans.one_minute * 5
end

local function on_init()
    -- register handler
    RegisterWarningHandler()
    update_settings()
end

local function on_load()
    -- register handler
    RegisterWarningHandler()
end

local function on_runtime_mod_setting_changed(args)
    if args.setting == 'autosaveAlert_interval' and args.setting_type == 'runtime-global' then
        update_settings()
    end
end

script.on_load(on_load)
script.on_init(on_init)
script.on_event(defines.events.on_runtime_mod_setting_changed, on_runtime_mod_setting_changed)
-- TODO: trigger update_settings when settings change or when player joins?
