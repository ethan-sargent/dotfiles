local _M = {
  "ggandor/leap.nvim"
};

_M.config = function ()
  require('leap').add_default_mappings();
end

return _M;
