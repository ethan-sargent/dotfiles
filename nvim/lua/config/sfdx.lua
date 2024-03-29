local Job = require("plenary.job")

-- Example pleneary job result:
--{ "Deploying v56.0 metadata to ethan.sargent@health.gov.au.r3dev using the v57.0 REST API",
--"Deploy ID: 0AfBm000002fLybKAE",
--"",
--"=== Deployed Source",
--"",
--" FULL NAME         TYPE                     PROJECT PATH                                                               ",
--" ───────────────── ───────────────          ────────────────────────────────────────────────────────────────────────── ",
--" omniNamespaceForm LightningComponentBundle force-app/main/default/lwc/omniNamespaceForm/omniNamespaceForm.css         ",
--" omniNamespaceForm LightningComponentBundle force-app/main/default/lwc/omniNamespaceForm/omniNamespaceForm.html        ",
--" omniNamespaceForm LightningComponentBundle force-app/main/default/lwc/omniNamespaceForm/omniNamespaceForm.js          ",
--" omniNamespaceForm LightningComponentBundle force-app/main/default/lwc/omniNamespaceForm/omniNamespaceForm.js-meta.xml ",
--"Deploy Succeeded."
--}

-- Prints complete plenary job result to message buffer.
-- Print will be scheduled with 0ms delay as multiline echo is not async.
local function print_results_table(results)
	vim.defer_fn(function()
		local _result = {}
		for i, value in ipairs(results) do
			table.insert(_result, { value .. "\n" })
		end
		-- this api isn't api-fast, causing the function to be deferred by 0ms
		vim.api.nvim_echo(_result, false, {})
	end, 0)
end

local function sfdx_job(_args, start_msg)
	return Job:new({
		command = "sfdx",
		args = _args,
		cwd = ".",
		on_start = function()
			print(start_msg)
		end,
		on_exit = function(j, _return_code)
      print(j:result())
			print_results_table(j:result())
		end,
		on_stdout = function(_error, data, _self)
			print(data)
		end,
		on_stderr = function(_error, data, _self)
			print(data)
		end,
	})
end

local function create_deploy_job()
	return sfdx_job(
		{ "force", "source", "deploy", "-p", vim.api.nvim_buf_get_name(0) },
		"Deploying source..."
	)
end
local function create_retrieve_job()
	return sfdx_job(
		{ "project", "retrieve", "start", "--ignore-conflicts", "--source-dir", vim.api.nvim_buf_get_name(0) },
		"Retrieving source..."
	)
end

local function GetVisualSelection(preserve_newlines)
	local s_start = vim.api.nvim_buf_get_mark(0, "<")
	local s_end = vim.api.nvim_buf_get_mark(0, ">")
	local lines = vim.api.nvim_buf_get_text(0, s_start[1] - 1, s_start[2], s_end[1] - 1, s_end[2], {})
	local separator
	if preserve_newlines then
		separator = "\n"
	else
		separator = ""
	end
	return string.gsub(table.concat(lines, separator), "%%", [[%%]])
end

local function SfdxVisualQuery()
	vim.cmd(string.format('!sfdx data query -q "%s"', GetVisualSelection(false)))
end
vim.keymap.set("v", "<leader>sq", SfdxVisualQuery, {})

local function SFDXCreateApexClass(commandTable)
	local classname = commandTable.fargs[1]
	local template = commandTable.fargs[2] or "DefaultApexClass"
	local outputdir = commandTable.fargs[3] or "force-app/main/default/classes"
	sfdx_job(
		{ "apex", "generate", "class", "--name", classname, "--template", template, "--output-dir", outputdir },
		"Creating new apex class..."
	):start()
end
vim.api.nvim_create_user_command("SFDXCreateApexClass", SFDXCreateApexClass, {})

local function SwcCompile()
	vim.cmd('!npx swc "%" -o "%:r.js"')
end
vim.api.nvim_create_user_command("SwcCompile", SwcCompile, {})
vim.api.nvim_set_keymap("n", "<leader>swc", "<cmd>SwcCompile<CR>", { noremap = true })

vim.keymap.set("n", "<leader>sd", function()
	create_deploy_job():start()
end, { noremap = true })

vim.keymap.set("n", "<leader>sr", function()
	create_retrieve_job():start()
end, { noremap = true })

vim.keymap.set("n", "<leader>sae", function()
	sfdx_job(
        { "apex", "run", "--file", vim.api.nvim_buf_get_name(0) },
        "Executing anonymous Apex..."
  ):start()
end, { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>sq", ':!sfdx data query --file "%" <Enter>', { noremap = true })

vim.api.nvim_set_keymap(
	"n",
	"<leader>st",
	':!sfdx apex run test --tests "%:t:r" --synchronous<Enter>',
	{ noremap = true }
)

vim.api.nvim_set_keymap("n", "<leader>so", ":!sfdx org open<Enter>", {})

-- shortcut for org switching zsh alias
vim.api.nvim_set_keymap("n", "<leader>dxd", ":!dxd ", { noremap = true })
