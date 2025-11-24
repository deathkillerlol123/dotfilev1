local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.snippets = {
  tex = {
    s(
      "beg",
      fmt("\\begin{{{}}}\n\t{}\n\\end{{{}}}", {
        i(1, "environment"),
        i(2),
        rep(1),
      })
    ),
  },
}
