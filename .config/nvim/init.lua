-- to disable any plugin .. just go to its file .. suffix its extension with # >> mini.lua -> mini.lua#
-- sourcing {grap and connect} the config separate files to the starting point {init.lua}
vim.g.mapleader=" " -- <leader> as space
vim.g.maplocalleader=" "
require("config.lazy") --lazy FIRST, but actually before that map the leader keys
--require("folder.file")
--or: require("folder/file")
require("keymaps") --files inside lua/ folder .. can be sourced directly like this
require("options") -- same as: require("lua.options")
require("colorscheme")
