-- Core libs
import 'CoreLibs/object'
import 'CoreLibs/graphics'
import 'CoreLibs/sprites'
import 'CoreLibs/animation'
import 'CoreLibs/animator'
import 'CoreLibs/timer'
import 'CoreLibs/frameTimer'
import 'CoreLibs/crank'
import 'CoreLibs/ui'
import 'CoreLibs/keyboard'
-- Toybox-managed libraries
-- import 'toyboxes'

local pd <const> = playdate
local gfx <const> = pd.graphics

-- ===============================================================================
-- Game Loop
-- ===============================================================================

function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
end
