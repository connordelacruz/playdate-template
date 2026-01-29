-- ================================================================================
-- Debug Options
-- ================================================================================

-- Names for debug options
local kDebugOptionNames <const> = {
    -- General
    'verbose',
}
-- Bit masks generated from above options
local function generateDebugMasks()
    local masks = {}
    for i = 1, #kDebugOptionNames do
        masks[kDebugOptionNames[i]] = 2 ^ (i - 1)
    end
    return masks
end
-- Global constant
DEBUG_FLAGS = generateDebugMasks()

-- ================================================================================
-- Debug Manager Class
-- ================================================================================
class('DebugManager').extends()

function DebugManager:init()
    self.flags = 0
end

-- --------------------------------------------------------------------------------
-- Flag Functions
--
-- NOTE: debugFlag should be a power of 2 for the corresponding flag,
-- defined in DEBUG_FLAGS.
-- --------------------------------------------------------------------------------

function DebugManager:setFlag(debugFlag)
    self.flags = self.flags | debugFlag
end

function DebugManager:unsetFlag(debugFlag)
    self.flags = self.flags & ~debugFlag
end

function DebugManager:isFlagSet(debugFlag)
    return (self.flags & debugFlag) > 0
end

-- --------------------------------------------------------------------------------
-- Verbose Printing
-- --------------------------------------------------------------------------------

-- NOTE: text param should be able to be parsed into a string with tostring().
function DebugManager:vPrint(text, indentLevel)
    if not self:isFlagSet(DEBUG_FLAGS.verbose) then
        return
    end
    local indent = self:getIndentString(indentLevel)
    print(indent .. tostring(text))
end

-- NOTE: dumping tables can freeze things up pretty bad with nested tables.
-- The default depth for dumping tables is 1 if not specified.
function DebugManager:vPrintTable(table, indentLevel, maxDepth)
    if not self:isFlagSet(DEBUG_FLAGS.verbose) then
        return
    end
    if maxDepth == nil then
        maxDepth = 1
    end
    print(self:tableToString(table, indentLevel, maxDepth))
end

-- --------------------------------------------------------------------------------
-- Logging Utilities
-- --------------------------------------------------------------------------------

function DebugManager:getIndentString(indentLevel)
    if type(indentLevel) ~= 'number' or indentLevel < 0 then
        indentLevel = 0
    end
    return string.rep('  ', indentLevel)
end

-- --------------------------------------------------------------------------------
-- Table Logging Helpers
-- --------------------------------------------------------------------------------

function DebugManager:tableToString(table, indentLevel, maxDepth)
    -- Param defaults
    if maxDepth == nil then
        maxDepth = 999
    end
    if indentLevel == nil then
        indentLevel = 1
    end

    local indent = self:getIndentString(indentLevel)
    local out = '{'

    for k, v in pairs(table) do
        local line = '\n' .. indent .. k .. ' = '
        local vType = type(v)
        if vType == 'table' then
            if indentLevel < maxDepth then
                line = line .. self:tableToString(v, indentLevel + 1)
            else
                line = line .. tostring(v)
            end
        elseif vType == 'string' then
            line = line .. v
        else
            line = line .. tostring(v)
        end
        out = out .. line
    end

    out = out .. '\n' .. indent .. '}'
    return out
end
