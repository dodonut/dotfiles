local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep

return {
    s('gcmake',
        fmt([[
        cmake_minimum_required (VERSION {})
        set(CMAKE_CXX_STANDARD {})
        set(CMAKE_CXX_STANDARD_REQUIRED ON)

        project ({} VERSION 1.0)
        add_executable ({} main.cpp)
        ]], { t("3.14"), t("17"), i(1, "hello"), rep(1) })
    )
}
