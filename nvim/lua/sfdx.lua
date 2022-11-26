
vim.api.nvim_create_augroup("sfdx", {
  clear = true
});

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  group = "sfdx",
  pattern = {
    "*.cls",
    "*.apex",
    "*.trigger"
  },
  command = "set filetype=apexcode",
});

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  group = "sfdx",
  pattern = {
    "*.soql",
  },
  command = "set filetype=soql",
});


function GetVisualSelection(preserve_newlines)
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  if next(lines) == nil then
    return nil
  end
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  local separator
  if preserve_newlines then
    separator = '\n'
  else
    separator = ''
  end
  return table.concat(lines, separator)
end

function SfdxVisualQuery()
  vim.cmd(string.format('!sfdx force:data:soql:query -q "%s"', GetVisualSelection(false)));
end


vim.api.nvim_set_keymap("v", "<leader>sq", "<cmd>:lua SfdxVisualQuery()<CR>", {})

function SwcCompile()
   vim.cmd('!npx swc "%" -o "%:r.js"');
end

vim.api.nvim_set_keymap("n", "<leader>swc", "<cmd>:lua SwcCompile()<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>sd", ":w  <bar> !sfdx force:source:deploy --sourcepath \"%\"<Enter>", {});
vim.api.nvim_set_keymap("n", "<leader>sr", ":!sfdx force:source:retrieve --sourcepath \"%\"<Enter>", {});
vim.api.nvim_set_keymap("n", "<leader>sq", ":!sfdx force:data:soql:query  --soqlqueryfile \"%\" <Enter>", {});
vim.api.nvim_set_keymap("n", "<leader>sae", ":!sfdx force:apex:execute --apexcodefile \"%\" <Enter>", {});
vim.api.nvim_set_keymap("n", "<leader>st", ":!sfdx force:apex:test:run --tests \"%:t:r\" --synchronous<Enter>", {});
vim.api.nvim_set_keymap("n", "<leader>so", ":!sfdx force:org:open<Enter>", {});

vim.api.nvim_set_keymap("n", "<leader>sc", ":!dxd ", {});

