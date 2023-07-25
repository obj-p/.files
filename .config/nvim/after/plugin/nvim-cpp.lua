-- https://github.com/hrsh7th/nvim-cmp#recommended-configuration

local cmp = require("cmp")

local cmp_mapping_s_tab = function(fallback) 
    if cmp.visible() then
        cmp.select_prev_item()
    else
        fallback()
    end
end

local cmp_mapping_tab = function(fallback) 
    if cmp.visible() then
        cmp.select_next_item()
    else
        fallback()
    end
end

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<S-Tab>"] = cmp.mapping(cmp_mapping_s_tab, { "i", "s" }),
        ["<Tab>"] = cmp.mapping(cmp_mapping_tab, { "i", "s" })
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "vsnip" },
    }, {
        { name = "buffer" },
    })
})

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" }
    }
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" }
    }, {
        { name = "cmdline" }
    })
})

