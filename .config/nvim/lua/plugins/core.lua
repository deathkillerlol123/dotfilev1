return {
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    opts = {
      position = "right",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "kiyoon/python-import.nvim",
    lazy = false,
    -- build = "pipx install . --force",
    build = "uv tool install . --force --reinstall",
    keys = {
      {
        "<space><space>",
        function()
          require("python_import.api").add_import_current_word_and_notify()
        end,
        mode = { "i", "n" },
        silent = true,
        desc = "Add python import",
        ft = "python",
      },
      {
        "<M-CR>",
        function()
          require("python_import.api").add_import_current_selection_and_notify()
        end,
        mode = "x",
        silent = true,
        desc = "Add python import",
        ft = "python",
      },
      {
        "<space>c",
        function()
          require("python_import.api").add_import_current_word_and_move_cursor()
        end,
        mode = "n",
        silent = true,
        desc = "Add python import and move cursor",
        ft = "python",
      },
      {
        "<space>i",
        function()
          require("python_import.api").add_import_current_selection_and_move_cursor()
        end,
        mode = "x",
        silent = true,
        desc = "Add python import and move cursor",
        ft = "python",
      },
      {
        "<space>tr",
        function()
          require("python_import.api").add_rich_traceback()
        end,
        silent = true,
        desc = "Add rich traceback",
        ft = "python",
      },
    },
    opts = {
      -- Example 1:
      -- Default behaviour for `tqdm` is `from tqdm.auto import tqdm`.
      -- If you want to change it to `import tqdm`, you can set `import = {"tqdm"}` and `import_from = {tqdm = vim.NIL}` here.
      -- If you want to change it to `from tqdm import tqdm`, you can set `import_from = {tqdm = "tqdm"}` here.

      -- Example 2:
      -- Default behaviour for `logger` is `import logging`, ``, `logger = logging.getLogger(__name__)`.
      -- If you want to change it to `import my_custom_logger`, ``, `logger = my_custom_logger.get_logger()`,
      -- you can set `statement_after_imports = {logger = {"import my_custom_logger", "", "logger = my_custom_logger.get_logger()"}}` here.
      extend_lookup_table = {
        ---@type string[]
        import = {
          -- "tqdm",
        },

        ---@type table<string, string|vim.NIL>
        import_as = {
          -- These are the default values. Here for demonstration.
          -- np = "numpy",
          -- pd = "pandas",
        },

        ---@type table<string, string|vim.NIL>
        import_from = {
          -- tqdm = vim.NIL,
          -- tqdm = "tqdm",
        },

        ---@type table<string, string[]|vim.NIL>
        statement_after_imports = {
          -- logger = { "import my_custom_logger", "", "logger = my_custom_logger.get_logger()" },
        },
      },

      ---Return nil to indicate no match is found and continue with the default lookup
      ---Return a table to stop the lookup and use the returned table as the result
      ---Return an empty table to stop the lookup. This is useful when you want to add to wherever you need to.
      ---@type fun(winnr: integer, word: string, ts_node: TSNode?): string[]?
      custom_function = function(winnr, word, ts_node)
        -- if vim.endswith(word, "_DIR") then
        --   return { "from my_module import " .. word }
        -- end
      end,
    },
  },
  {
    "rcarriga/nvim-notify", -- optional
    lazy = true,
  },
  {
    "elihunter173/dirbuf.nvim",
    lazy = true,
  },
  {
    "stevearc/oil.nvim",
    lazy = true,
  },
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "latexmk"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "okuuva/auto-save.nvim",
    version = "^1.0.0", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      -- your config goes here
      -- or just leave it empty :)
    },
  },
  {
    "hat0uma/csvview.nvim",
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {
      parser = { comments = { "#", "//" } },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        -- Excel-like navigation:
        -- Use <Tab> and <S-Tab> to move horizontally between fields.
        -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
        -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  },
  {
    "jbyuki/nabla.nvim",
  },
  {
    "zk-org/zk-nvim",
    config = function()
      require("zk").setup({
        -- See Setup section below
      })
    end,
  },
}
