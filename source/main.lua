-- Core libs
import 'CoreLibs/animation'
import 'CoreLibs/animator'
import 'CoreLibs/crank'
import 'CoreLibs/frameTimer'
import 'CoreLibs/graphics'
import 'CoreLibs/keyboard'
import 'CoreLibs/object'
import 'CoreLibs/sprites'
import 'CoreLibs/timer'
import 'CoreLibs/ui'
-- Toybox-managed libraries
-- import 'toyboxes'
-- Common utils
import 'util/__init__'

local pd <const> = playdate
local gfx <const> = pd.graphics

-- ===============================================================================
-- Debug
-- ===============================================================================
DEBUG_MANAGER = DebugManager()
-- --------------------------------------------------------------------------------
-- General Debug Options
-- --------------------------------------------------------------------------------
-- Verbose logging.
DEBUG_MANAGER:setFlag(DEBUG_FLAGS.verbose)

-- ===============================================================================
-- Delta Time
-- ===============================================================================
-- Will store time in seconds since the last frame
DELTA_TIME = 0

local function updateDeltaTime()
    DELTA_TIME = pd.getElapsedTime()
    pd.resetElapsedTime()
end

-- ===============================================================================
-- Game Loop
-- ===============================================================================

function pd.update()
    updateDeltaTime()
    gfx.sprite.update()
    pd.timer.updateTimers()
    pd.frameTimer.updateTimers()
end
