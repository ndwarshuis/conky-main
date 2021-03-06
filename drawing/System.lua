local M = {}

local Util			= require 'Util'
local Common		= require 'Common'

local __string_match = string.match

local _TEXT_SPACING_ = 20

local header = Common.Header(
	_G_INIT_DATA_.LEFT_X,
	_G_INIT_DATA_.TOP_Y,
	_G_INIT_DATA_.SECTION_WIDTH,
	'SYSTEM'
)

local rows = Common.initTextRows(
	_G_INIT_DATA_.LEFT_X,
	header.bottom_y,
    _G_INIT_DATA_.SECTION_WIDTH,
	_TEXT_SPACING_,
	{'Kernel', 'Uptime', 'Last Upgrade', 'Last Sync'}
)

_TEXT_SPACING_ = nil

M.draw_static = function(cr)
   Common.drawHeader(cr, header)
   Common.text_rows_draw_static(rows, cr)
end

M.draw_dynamic = function(cr, pacman_stats)
   local last_update, last_sync = "N/A", "N/A"
   if pacman_stats then
      last_update, last_sync = __string_match(pacman_stats, "^%d+%s+([^%s]+)%s+([^%s]+).*")
   end
   Common.text_rows_set(rows, cr, 1, Util.conky('$kernel'))
   Common.text_rows_set(rows, cr, 2, Util.conky('$uptime'))
   Common.text_rows_set(rows, cr, 3, last_update)
   Common.text_rows_set(rows, cr, 4, last_sync)
   Common.text_rows_draw_dynamic(rows, cr)
end

return M
