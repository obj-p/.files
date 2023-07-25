-- Sets relative numbers when in motion, absolute when not.
-- Based on: https://jeffkreeftmeijer.com/vim-number/

local line_numbers_id = vim.api.nvim_create_augroup("LineNumbers", { clear = true })

vim.api.nvim_create_autocmd({"BufEnter", "FocusGained", "InsertLeave", "WinEnter"}, {
    group = line_numbers_id,
    callback = function()
        if vim.opt.number:get() and vim.api.nvim_get_mode().mode ~= "i" then
            vim.opt.rnu = true 
        end
    end
})

vim.api.nvim_create_autocmd({"BufLeave", "FocusLost", "InsertEnter", "WinLeave"}, {
    group = line_numbers_id,
    callback = function()
        if vim.opt.number:get() then
            vim.opt.rnu = false 
        end
    end
})

