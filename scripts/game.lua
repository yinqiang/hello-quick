
require("config")
require("framework.init")
require("framework.client.init")

-- define global module
game = {}

function game.startup()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    -- display.addSpriteFramesWithFile(GAME_TEXTURE_DATA_FILENAME, GAME_TEXTURE_IMAGE_FILENAME)

    -- preload all sounds
    for k, v in pairs(GAME_SFX) do
        audio.preloadSound(v)
    end

    game.eventManager = require("managers.EventManager")
    print("-- setup " .. game.eventManager:getName())

    game.enterFreshScene()
end

function game.exit()
    CCDirector:sharedDirector():endToLua()
end

function game.enterFreshScene()
	local FreshScene = require("scenes.FreshScene")
	display.replaceScene(FreshScene.new(), "fade", 0.6, display.COLOR_BLACK)
end

function game.enterStartScene()
	local StartScene = require("scenes.StartScene")
	display.replaceScene(StartScene.new(), "fade", 0.6, display.COLOR_BLACK)
end
