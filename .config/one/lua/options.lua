-- options
local op= vim.o --faster

    --linenumber
op.number = true
vim.wo.relativenumber = false --better be off if u do this too much => :65 {go to line 65}
op.ruler = false -- true to show the cursor position on the file

    --indent, tab, space
op.expandtab = true --convert \t into spaces --btw bad for a MakeFile
op.tabstop = 2 -- \t would be 2 spaces wide
op.softtabstop = 2
op.shiftwidth = 2 -- using >> or << would be 2 spaces wide
op.smartindent = true
op.autoindent = true                          -- Copy indent from current line

    --search
op.ignorecase = true -- /hello matches Hello hello heLLoW
op.smartcase = true -- but /Hello would only match Hello
op.hlsearch = true 
op.incsearch = true --show matches as you type

    --good visuals
op.termguicolors = true                       -- Enable 24-bit colors
op.cursorline = true -- highlight the line the curson on
op.signcolumn = "yes" --left sidebar space for lsp, breakepoints, git changes ..etc
op.colorcolumn = "90"                        -- Show column at 90 characters
op.wrap = true --break the line if too long
op.linebreak = true -- properly
op.splitbelow = true
op.splitright = true
op.timeoutlen = 300 -- not to leave you hanging too much
-- op.scrolloff = 10                             -- Keep 10 lines above/below cursor 
-- op.sidescrolloff = 8                          -- Keep 8 columns left/right of cursor
-- vim.opt.showmatch = true                           -- Highlight matching brackets
-- vim.opt.matchtime = 2                              -- How long to show matching bracket
-- vim.opt.cmdheight = 1                              -- Command line height
-- vim.opt.completeopt = "menuone,noinsert,noselect"  -- Completion options 
-- vim.opt.showmode = false                           -- Don't show mode in command line 
-- vim.opt.pumheight = 10                             -- Popup menu height 
-- vim.opt.pumblend = 10                              -- Popup menu transparency 
-- vim.opt.winblend = 0                               -- Floating window transparency 
-- vim.opt.conceallevel = 0                           -- Don't hide markup 
-- vim.opt.concealcursor = ""                         -- Don't hide cursor line markup 
-- vim.opt.lazyredraw = true                          -- Don't redraw during macros
-- vim.opt.synmaxcol = 300                            -- Syntax highlighting limit 
    -- -- File handling
-- vim.opt.backup = false                             -- Don't create backup files
-- vim.opt.writebackup = false                        -- Don't create backup before writing
-- vim.opt.swapfile = false                           -- Don't create swap files
-- vim.opt.undofile = true                            -- Persistent undo
-- vim.opt.undodir = vim.fn.expand("~/.vim/undodir")  -- Undo directory
-- vim.opt.updatetime = 300                           -- Faster completion
-- vim.opt.timeoutlen = 500                           -- Key timeout duration
-- vim.opt.ttimeoutlen = 0                            -- Key code timeout
-- vim.opt.autoread = true                            -- Auto reload files changed outside vim
-- vim.opt.autowrite = false                          -- Don't auto save
--
    -- Behavior settings
-- vim.opt.hidden = true                              -- Allow hidden buffers
-- vim.opt.errorbells = false                         -- No error bells
-- vim.opt.backspace = "indent,eol,start"             -- Better backspace behavior
-- vim.opt.autochdir = false                          -- Don't auto change directory
-- vim.opt.iskeyword:append("-")                      -- Treat dash as part of word
-- vim.opt.path:append("**")                          -- include subdirectories in search
-- vim.opt.selection = "exclusive"                    -- Selection behavior
-- vim.opt.mouse = "a"                                -- Enable mouse support
-- vim.opt.clipboard:append("unnamedplus")            -- Use system clipboard
-- vim.opt.modifiable = true                          -- Allow buffer modifications
-- vim.opt.encoding = "UTF-8"                         -- Set encoding
--     -- Cursor settings
-- vim.opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
--
--     -- Folding settings
-- vim.opt.foldmethod = "expr"                        -- Use expression for folding
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"    -- Use treesitter for folding
-- vim.opt.foldlevel = 99                             -- Start with all folds open
--
--     -- Split behavior
-- vim.opt.splitbelow = true                          -- Horizontal splits go below
-- vim.opt.splitright = true                          -- Vertical splits go right

    --clipboard
op.clipboard = "unnamedplus" -- use system clipboard instead

    --undofile, swap
-- op.undofile = true
op.swapfile = false



