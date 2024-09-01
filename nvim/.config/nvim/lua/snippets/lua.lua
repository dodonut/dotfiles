local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet

return {
    s("simple", t "wow, you were right!"),
    s("trigger", {
        t({ "After expanding, the cursor is here ->" }), i(1),
        t({ "", "After jumping forward once, cursor is here ->" }), i(2),
        t({ "", "After jumping once more, the snippet is exited there ->" }), i(0),
    }),
    s({ trig = "date" }, {
        f(function()
            return string.format(string.gsub(vim.bo.commentstring, "%%s", " %%s"), os.date())
        end, {}),
    }),
    s("dyn", {
        t "text: ", i(1), t { "", "copy: " },
        d(2, function(args)
                -- the returned snippetNode doesn't need a position; it's inserted
                -- "inside" the dynamicNode.
                return sn(nil, {
                    -- jump-indices are local to each snippetNode, so restart at 1.
                    i(1, args[1])
                })
            end,
            { 1 })
    }),
    s("example1", fmt("just an {iNode1}", {
        iNode1 = i(1, "example")
    })),
    s("example2", fmt([[
      if {} then
        {}
      end
      ]], {
        -- i(1) is at nodes[1], i(2) at nodes[2].
        i(1, "not now"), i(2, "when")
    })),
}
