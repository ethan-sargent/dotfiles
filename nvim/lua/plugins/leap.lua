local _M = {
  "ggandor/leap.nvim",
  event = "VeryLazy"
};

_M.config = function ()
  require('leap').add_default_mappings();
end

return _M;
