require("user.options")

-- if nvim is not called from vscode (see neovim extension!)
if not vim.g.vscode then
	require("user.keymaps")
	require("user.plugins")
end
