-- .luacheckrc
-- This file configures luacheck to recognize Neovim globals and standard libraries.

globals = {
    "vim",
}

-- Optional: Ignore some common warnings in Neovim configs
ignore = {
    "631", -- max_line_length (let stylua handle this)
}

-- Use LuaJIT as the target (since Neovim uses LuaJIT)
std = "luajit"
