local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep

return {
    --logs
    s("lgD", fmt("private final EventLog logger = EventLog.defaults({}.class);", { i(1, "default") })),
    s("lgd", fmt('var log = logger.event().m("{}");', { i(1, "") })),
    s("lgi", t("log.state(State.NEW).info();")),
    s("lgf", fmt("log.state(State.FAILURE).error({});", { i(1, "") })),
    s("lgp", t("log.state(State.PROCESSED).info();"))
}
