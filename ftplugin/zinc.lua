-- Zinc language ftplugin

-- Keywords and types for completion
local zinc_keywords = {
  -- Keywords
  "struct", "type", "foreign", "if", "else", "while", "for", "return",
  "and", "or", "not",
  -- Types
  "void", "char", "u8", "u16", "u32", "u64", "i8", "i16", "i32", "i64", "f32", "f64",
}

-- Omnifunc for Zinc completion
function _G.zinc_omnifunc(findstart, base)
  if findstart == 1 then
    -- Find start of word
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local start = col
    while start > 0 and line:sub(start, start):match('[%w_]') do
      start = start - 1
    end
    return start
  else
    -- Find matching completions
    local matches = {}
    for _, kw in ipairs(zinc_keywords) do
      if kw:find('^' .. base) then
        table.insert(matches, { word = kw, kind = kw:match('^[iu]%d') or kw == 'void' or kw == 'char' })
      end
    end
    return matches
  end
end

vim.bo.omnifunc = 'v:lua.zinc_omnifunc'

-- Set comment string
vim.bo.commentstring = '// %s'

-- Set indentation
vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
