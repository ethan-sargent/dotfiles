local Job = require("plenary.job")

local function create_deploy_job()
	return Job:new({
		command = "sfdx",
		args = { "force", "source", "deploy", "--sourcepath", vim.api.nvim_buf_get_name(0) },
		cwd = ".",
		on_start = function()
			print("Deploying source")
		end,
		on_exit = function(j, return_val)
			-- print(return_val)
      print("Done.")
		end,
		on_stdout = function(error, data, self)
			-- print(return_val)
			print(data)
		end,
		on_stderr = function(error, data, self)
			-- print(return_val)
			-- print(inspect())
		end,
	})
end
local function create_sfdx_job(args)
	return Job:new({
		command = "sfdx",
		args = { "force", "source", "deploy", "--sourcepath", vim.api.nvim_buf_get_name(0) },
		cwd = ".",
		on_start = function()
			print("Deploying source")
		end,
		on_exit = function(j, return_val)
			-- print(return_val)
			vim.print(j:result())
		end,
		on_stdout = function(error, data, self)
			-- print(return_val)
			print(data)
		end,
		on_stderr = function(error, data, self)
			-- print(return_val)
			-- print(inspect())
		end,
	})
end
vim.keymap.set("n", "<leader>sd", function()
	create_deploy_job():start()
end, { noremap = true })

local function GetVisualSelection(preserve_newlines)
	local s_start = vim.api.nvim_buf_get_mark(0, "<")
	local s_end = vim.api.nvim_buf_get_mark(0, ">")
	local lines = vim.api.nvim_buf_get_text(0, s_start[1], s_start[2], s_end[1], s_end[2], false)
	if next(lines) == nil then
		return nil
	end
	local separator
	if preserve_newlines then
		separator = "\n"
	else
		separator = ""
	end
  print(table.concat(lines, separator))
	return string.gsub(table.concat(lines, separator), "%%", [[%%]])
end

local function SfdxVisualQuery()
	vim.cmd(string.format('!sfdx force:data:soql:query -q "%s"', GetVisualSelection(false)))
end
vim.api.nvim_create_user_command("SOQLQuerySelected", SfdxVisualQuery, {})

local function SwcCompile()
	vim.cmd('!npx swc "%" -o "%:r.js"')
end
vim.api.nvim_create_user_command("SwcCompile", SwcCompile, {})

local function SFDXCreateApexClass(commandTable)
	local classname = commandTable.fargs[1]
	local template = commandTable.fargs[2] or "DefaultApexClass"
	local outputdir = commandTable.fargs[3] or "force-app/main/default/classes"
	vim.cmd(
		string.format(
			'!sfdx force:apex:class:create --classname %s --template %s --outputdir "%s"',
			classname,
			template,
			outputdir
		)
	)
end
vim.api.nvim_create_user_command("SFDXCreateApexClass", SFDXCreateApexClass, {})

vim.api.nvim_set_keymap("n", "<leader>swc", "<cmd>SwcCompile<CR>", { noremap = true })

-- vim.api.nvim_set_keymap("n", "<leader>sd", ":w  <bar> !sfdx force source deploy --sourcepath \"%\"<Enter>", {noremap = true});
vim.api.nvim_set_keymap("n", "<leader>sr", ':!sfdx force source retrieve --sourcepath "%"<Enter>', { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>sq", ':!sfdx data query  --file "%" <Enter>', { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>sq", "<cmd>:SOQLQuerySelected()<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>sae", ':!sfdx apex run --file "%" <Enter>', { noremap = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>st",
	':!sfdx apex run test --tests "%:t:r" --synchronous<Enter>',
	{ noremap = true }
)

vim.api.nvim_set_keymap("n", "<leader>so", ":!sfdx force:org:open<Enter>", {})

-- shortcut for org switching zsh alias
vim.api.nvim_set_keymap("n", "<leader>dxd", ":!dxd ", { noremap = true })
