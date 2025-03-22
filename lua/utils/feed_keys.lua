-- Utility for simulating user keypresses
-- This is primarily used for testing to simulate user interactions

---@class FeedKeysOptions
---@field wait_for_animation boolean Whether to wait for any UI animations to complete
---@field delay_ms number|nil Delay in milliseconds between keypresses

---@class FeedKeysUtil
local M = {}

---Feed keys to Neovim to simulate user interaction
---@param keys string The keys to be pressed
---@param mode string The mode to feed the keys in ('n' for normal, 'i' for insert, etc.)
---@param opts FeedKeysOptions|nil Options for feeding keys
function M.feed_keys(keys, mode, opts)
  opts = opts or {}
  local feed_opts = {
    wait = true,
    delay = opts.delay_ms or 0,
  }
  
  -- Replace special key notation with terminal codes
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  
  -- Feed the keys
  vim.api.nvim_feedkeys(keys, mode, feed_opts.wait)
  
  -- Wait if animation is expected
  if opts.wait_for_animation then
    vim.cmd('redraw')
    vim.cmd('sleep 10m') -- Small sleep to allow UI to update
  end
end

---Feed a sequence of keys with a delay between each keystroke
---@param key_sequence string[] List of keys to feed
---@param mode string Mode to feed keys in
---@param delay_ms number|nil Delay between keystrokes in milliseconds
function M.feed_key_sequence(key_sequence, mode, delay_ms)
  for _, keys in ipairs(key_sequence) do
    M.feed_keys(keys, mode, { delay_ms = delay_ms })
    
    -- Add a small delay between keypresses
    if delay_ms and delay_ms > 0 then
      vim.cmd('sleep ' .. math.floor(delay_ms) .. 'm')
    end
  end
end

return M