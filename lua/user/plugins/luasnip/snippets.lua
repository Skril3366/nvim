local ok, ls = pcall(require, "luasnip")
if not ok then
    print("Lua snip filed to run")
    return
end

local s = ls.s -- snippet
local t = ls.t -- text
local i = ls.i -- input
local f = ls.f -- function
local c = ls.c -- choice
-- local d = ls.d -- dynamic
-- local n = ls.n -- nested
-- local p = ls.p -- placeholder
-- local m = ls.m -- mirror
-- local r = ls.r -- regex
-- local l = ls.l -- lambda
-- local v = ls.v -- visual
-- local e = ls.e -- ext

