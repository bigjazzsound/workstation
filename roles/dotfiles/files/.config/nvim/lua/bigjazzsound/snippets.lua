local ls = require 'luasnip'
local s = ls.s
local sn = ls.sn
local t = ls.t
local i = ls.i
local f = ls.f
local c = ls.c
local d = ls.d

ls.snippets = {
  all = {},
  lua = {
    s({trig='fun'}, {
      t({"function()", ""}),
      t({'  '}), i(0),
      t({"", "end"}),
    })
  },
  terraform = {
    s({trig='res'}, {
      t({'resource "'}), i(1), t({'" "'}), i(2), t({'" {', ""}),
      t({'  '}), i(0),
      t({"", "}"}),
    }),
    s({trig='mod'}, {
      t({'module "'}), i(1), t({'" {', ""}),
      t({'  source = "'}), i(0), t({'"'}),
      t({"", "}"}),
    }),
  },
  yaml = {
    s({trig='var'}, {
      t({'"{{ '}), i(0), t({' }}"'}),
    }),
  }
}

vim.cmd [[
imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
imap <silent><expr> <c-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

snoremap <silent> <c-j> <cmd>lua ls.jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua ls.jump(-1)<Cr>
]]
