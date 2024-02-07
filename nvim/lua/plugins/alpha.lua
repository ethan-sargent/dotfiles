local _M = {
    'goolord/alpha-nvim',
}

_M.config = function()
  local dashboard = require'alpha.themes.dashboard';

  local hydra = {
    [[⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆          ]],
    [[   ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤ ⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦      ]],
    [[     ⠈   ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄    ]],
    [[          ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀ ⠢⣀⡀⠈⠙⠿    ]],
    [[  ⢀      ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀  ]],
    [[  ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿  ]],
    [[ ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾   ]],
    [[⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄ ]],
    [[⠙⠃   ⣼⣿⡟⠌ ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿⠐⣿⣿⡇ ⠛⠻⢷⣄]],
    [[     ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆   ⠁]],
    [[      ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃    ]],
  };

  dashboard.section.header.val = hydra

  dashboard.section.buttons.val = {
    dashboard.button( "n", "  New file" , "<cmd>ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "󰈞  Find file", '<cmd>lua require("plugins.telescope").project_files()<CR>'),
    dashboard.button( "r", "  Recent"   , '<cmd>lua require("telescope.builtin").oldfiles()<CR>'),
    -- dashboard.button( "s", "  Settings" , "<cmd>e $MYVIMRC | :cd %:p:h<CR> | :pwd<CR>"),
    dashboard.button( "q", "󰅚  Quit NVIM", "<cmd>qa<CR>"),
  }

  require("alpha").setup(dashboard.config)

end

return _M;
