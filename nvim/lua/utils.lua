local M = {}

local function override_query(lang, query_name, file)
  -- Read file into string
  local f, err = io.open(file, "r")
  if f then
    local text = f:read("*a")
    f:close()
    vim.treesitter.query.set(lang, query_name, text)
  else
    error(err)
  end
end

function M.override_query(lang, query_name)
  override_query(lang, query_name, vim.fn.stdpath("config") .. "/after/queries/" .. lang .. "/" .. query_name .. ".scm")
  -- restart tree-sitter
  vim.treesitter.start(vim.fn.bufnr(), lang)
end

return M
