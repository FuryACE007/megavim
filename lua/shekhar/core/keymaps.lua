vim.g.mapleader = " "

local keymap = vim.keymap

-- Modes
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Quick save / quit
keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
keymap.set("i", "<C-s>", "<ESC><cmd>w<CR>", { desc = "Save file from insert mode" })
keymap.set("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit all" })
keymap.set("n", "<leader>qw", "<cmd>wqa<CR>", { desc = "Save all and quit" })

-- Window splits
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
keymap.set("n", "<leader>so", "<cmd>only<CR>", { desc = "Close other splits" })

-- Window navigation (also used by christoomey/vim-tmux-navigator)
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom split" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top split" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Better up/down (handle wrapped lines)
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Center after half-page jumps
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down (centered)" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up (centered)" })
keymap.set("n", "n", "nzzzv", { desc = "Next match (centered)" })
keymap.set("n", "N", "Nzzzv", { desc = "Prev match (centered)" })

-- Move lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
keymap.set("v", "<", "<gv", { desc = "Indent left" })
keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Keep yank register on paste over selection
keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })

-- System clipboard convenience (clipboard option already maps to default)
keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
