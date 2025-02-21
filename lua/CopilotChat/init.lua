local utils = require('CopilotChat.utils')

local M = {}

local default_prompts = {
  Explain = 'Explain how it works.',
  Tests = 'Briefly how selected code works then generate unit tests.',
}

-- Set up the plugin
---@param options (table | nil)
--       - mode: ('newbuffer' | 'split') default: newbuffer.
--       - prompts: (table?) default: default_prompts.
M.setup = function(options)
  vim.g.copilot_chat_view_option = options and options.mode or 'newbuffer'

  -- Merge the provided prompts with the default prompts
  local prompts = vim.tbl_extend('force', default_prompts, options and options.prompts or {})

  --  Loop through merged table and generate commands based on keys.
  for key, value in pairs(prompts) do
    utils.create_cmd('CopilotChat' .. key, function()
      vim.cmd('CopilotChatInner ' .. value)
    end, { nargs = '*', range = true })
  end
end

return M
