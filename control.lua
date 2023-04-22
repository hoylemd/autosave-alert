local function hello_world()
    game.print("hello, world")
end

local function RegisterWarningHandler()
    script.on_nth_tick(360, hello_world)
end

local function on_load()
    RegisterWarningHandler()
end

script.on_load(on_load)
