-- [
-- snip_env + autosnippets
-- ]
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
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

-- [
-- personal imports
-- ]
local tex = require("luasnip-latex-snippets.luasnippets.tex.utils.conditions")
local auto_backslash_snippet = require("luasnip-latex-snippets.luasnippets.tex.utils.scaffolding").auto_backslash_snippet
local symbol_snippet = require("luasnip-latex-snippets.luasnippets.tex.utils.scaffolding").symbol_snippet
local single_command_snippet = require("luasnip-latex-snippets.luasnippets.tex.utils.scaffolding").single_command_snippet
local postfix_snippet = require("luasnip-latex-snippets.luasnippets.tex.utils.scaffolding").postfix_snippet

M = {
    -- superscripts
    autosnippet({ trig = "p2", wordTrig = true, snippetType = "autosnippet" },
    { t("^2") },
    { condition = tex.in_math, show_condition = tex.in_math }),
	autosnippet({ trig = "p3", wordTrig = false , snippetType = "autosnippet"},
    { t("^3") },
    { condition = tex.in_math, show_condition = tex.in_math }),
	autosnippet({ trig = "**", wordTrig = false },
    { t("^{c}") },
    { condition = tex.in_math, show_condition = tex.in_math }),
	autosnippet({ trig = "vtr", wordTrig = false , snippetType = "autosnippet"},
    { t("^{T}") },
    { condition = tex.in_math, show_condition = tex.in_math }),
	autosnippet({ trig = "inv", wordTrig = false , snippetType = "autosnippet"},
    { t("^{-1}") },
    { condition = tex.in_math, show_condition = tex.in_math }),

    -- fractions
    autosnippet({ trig='//', name='fraction', dscr="fraction (general)", snippetType = "autosnippet"},
    fmta([[
    \frac{<>}{<>}<>
    ]],
    { i(1), i(2), i(0) }),
    { condition = tex.in_math, show_condition = tex.in_math }),
    autosnippet({ trig="((\\d+)|(\\d*)(\\\\)?([A-Za-z]+)((\\^|_)(\\{\\d+\\}|\\d))*)\\/", name='fraction', dscr='auto fraction 1', trigEngine="ecma"},
    fmta([[
    \frac{<>}{<>}<>
    ]],
    { f(function (_, snip)
        return snip.captures[1]
    end), i(1), i(0) }),
    { condition = tex.in_math, show_condition = tex.in_math }),

	autosnippet({ trig = "lim", name = "lim(sup|inf)", dscr = "lim(sup|inf)", snippetType = "autosnippet" },
    fmta([[ 
    \lim_{{<>} \to {<>}} <>  
    ]],
	{ i(2), i(0), i(1) }),
	{ condition = tex.in_math, show_condition = tex.in_math }),

	autosnippet({ trig = "sum", name = "summation", dscr = "summation", snippetType = "autosnippet" },
	fmta([[
    \sum<> <>
    ]],
    { c(1, {fmta([[_{<>}^{<>}]], {i(1, "i = 0"), i(2, "\\infty")}), t("")}), i(0) }),
    { condition = tex.in_math, show_condition = tex.in_math }),

	autosnippet({ trig = "prod", name = "product", dscr = "product" },
    fmta([[
    \prod<> <>
    ]],
	{ c(1, {fmta([[_{<>}^{<>}]], {i(1, "i = 0"), i(2, "\\infty")}), t("")}), i(0) }),
	{ condition = tex.in_math, show_condition = tex.in_math }),

	autosnippet({ trig = "cprod", name = "coproduct", dscr = "coproduct", snippetType = "autosnippet" },
    fmta([[
    \coprod<> <>
    ]],
	{ c(1, {fmta([[_{<>}^{<>}]], {i(1, "i = 0"), i(2, "\\infty")}), t("")}), i(0) }),
	{ condition = tex.in_math, show_condition = tex.in_math }),

	autosnippet({ trig = "set", name = "set", dscr = "set" }, -- overload with set builders notation because analysis and algebra cannot agree on a singular notation
	fmta([[
    \{<>\}<>
    ]],
	{ c(1, { r(1, ""), sn(nil, { r(1, ""), t(" \\mid "), i(2) }), sn(nil, { r(1, ""), t(" \\colon "), i(2) })}), i(0) }),
	{ condition = tex.in_math, show_condition = tex.in_math }),

    autosnippet({ trig = "matin", name = "math inline", dscr = "math inline" }, -- overload with set builders notation because analysis and algebra cannot agree on a singular notation
	fmta([[
    \( <> \)<>
    ]],
	{ c(1, { r(1, ""), sn(nil, { r(1, ""), t(" \\mid "), i(2) }), sn(nil, { r(1, ""), t(" \\colon "), i(2) })}), i(0) }),
	{ condition = tex.in_text, show_condition = tex.in_text }),

    autosnippet({ trig = "matdi", name = "math display mode", dscr = "math display mode" }, -- overload with set builders notation because analysis and algebra cannot agree on a singular notation
	fmta([[
    \[ <> \]<>
    ]],
	{ c(1, { r(1, ""), sn(nil, { r(1, ""), t(" \\mid "), i(2) }), sn(nil, { r(1, ""), t(" \\colon "), i(2) })}), i(0) }),
	{ condition = tex.in_text, show_condition = tex.in_text }),



	autosnippet({ trig = "nnn", name = "bigcap", dscr = "bigcap", snippetType = "autosnippet" },
	fmta([[
    \bigcap<> <>
    ]],
	{ c(1, {fmta([[_{<>}^{<>}]], {i(1, "i = 0"), i(2, "\\infty")}), t("")}), i(0) }),
	{ condition = tex.in_math, show_condition = tex.in_math }),

	autosnippet({ trig = "uuu", name = "bigcup", dscr = "bigcup" },
    fmta([[
    \bigcup<> <>
    ]],
	{ c(1, {fmta([[_{<>}^{<>}]], {i(1, "i = 0"), i(2, "\\infty")}), t("")}), i(0) }),
    { condition = tex.in_math, show_condition = tex.in_math }),

	autosnippet({ trig = "bnc", name = "binomial", dscr = "binomial (nCR)", snippetType = "autosnippet" },
	fmta([[
    \binom{<>}{<>}<>
    ]],
    { i(1), i(2), i(0) }),
	{ condition = tex.in_math, show_condition = tex.in_math }),

    autosnippet({ trig='partial', name='partial_half', dscr='partial derivative', snippetType = "autosnippet"},
    fmta([[
    \partial <>
    ]],
    { i(0) }),
    { condition = tex.in_math, show_condition = tex.in_math }),


    autosnippet({ trig='pd1', name='partial_1', dscr='first order partial derivative', snippetType = "autosnippet"},
    fmta([[
    \frac{\partial <>}{\partial <>}<>
    ]],
    { i(1), i(2), i(0) }),
    { condition = tex.in_math, show_condition = tex.in_math }),

     autosnippet({ trig='pd2', name='partial_2', dscr='second order partial derivative', snippetType = "autosnippet"},
    fmta([[
    \frac{\partial^2 <>}{\partial <>^2}<>
    ]],
    { i(1), i(2), i(0) }),
    { condition = tex.in_math, show_condition = tex.in_math }),


    autosnippet({ trig='ddx', name='derivative_1', dscr='first order derivative', snippetType = "autosnippet"},
    fmta([[
    \frac{d<>}{d<>}<>
    ]],
    { i(1), i(2), i(0) }),
    { condition = tex.in_math, show_condition = tex.in_math }),

     autosnippet({ trig='d2dx', name='derivative_2', dscr='second order derivative', snippetType = "autosnippet"},
    fmta([[
    \frac{d^2<>}{d<>^2}<>
    ]],
    { i(1), i(2), i(0) }),
    { condition = tex.in_math, show_condition = tex.in_math }), 

    autosnippet({ trig='brak', name='bra-ket', dscr='Internal Product', snippetType = "autosnippet"},
    fmta([[
    \langle <> \rangle <>
    ]],
    { i(1), i(0) }),
    { condition = tex.in_math, show_condition = tex.in_math }), 

    autosnippet({ trig='integ', name='integ_1', dscr='Single Variable Integral', snippetType = "autosnippet"},
    fmta([[
    \int_{<>}^{<>} <>\,dx 
    ]],
    { i(2), i(0), i(1) }),
    { condition = tex.in_math, show_condition = tex.in_math }),


autosnippet({
    trig = 'arcsin',
    name = 'arcsin',
    dscr = 'arcsin function',
},
fmta([[
    \arcsin{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'sin',
    name = 'sin',
    dscr = 'sin function',
},
fmta([[
    \sin{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'arccos',
    name = 'arccos',
    dscr = 'arccos function',
},
fmta([[
    \arccos{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'cos',
    name = 'cos',
    dscr = 'cosine function',
},
fmta([[
    \cos{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'arctan',
    name = 'arctan',
    dscr = 'arctan function',
},
fmta([[
    \arctan{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'tan',
    name = 'tan',
    dscr = 'tangent function',
},
fmta([[
    \tan{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'arccot',
    name = 'arccot',
    dscr = 'arccotangent function',
},
fmta([[
    \arccot{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'cot',
    name = 'cot',
    dscr = 'cotangent function',
},
fmta([[
    \cot{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'arcsec',
    name = 'arcsec',
    dscr = 'arcsecant function',
},
fmta([[
    \arcsec{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'sec',
    name = 'sec',
    dscr = 'secant function',
},
fmta([[
    \sec{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'arccsc',
    name = 'arccsc',
    dscr = 'arccosecant function',
},
fmta([[
    \arccsc{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'csc',
    name = 'csc',
    dscr = 'cosecant function',
},
fmta([[
    \csc{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

-- Add similar snippets for other functions such as log, ln, exp, abs, etc.

autosnippet({
    trig = 'sinh',
    name = 'sinh',
    dscr = 'hyperbolic sine function',
},
fmta([[
    \sinh{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'cosh',
    name = 'cosh',
    dscr = 'hyperbolic cosine function',
},
fmta([[
    \cosh{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'tanh',
    name = 'tanh',
    dscr = 'hyperbolic tangent function',
},
fmta([[
    \tanh{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'coth',
    name = 'coth',
    dscr = 'hyperbolic cotangent function',
},
fmta([[
    \coth{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'sech',
    name = 'sech',
    dscr = 'hyperbolic secant function',
},
fmta([[
    \sech{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'csch',
    name = 'csch',
    dscr = 'hyperbolic cosecant function',
},
fmta([[
    \csch{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'log',
    name = 'log',
    dscr = 'log function',
},
fmta([[
    \log{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'ln',
    name = 'ln',
    dscr = 'ln function',
},
fmta([[
    \ln{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'abs',
    name = 'abs',
    dscr = 'Absolute value',
},
fmta([[
    \abs{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

autosnippet({
    trig = 'exp',
    name = 'exp',
    dscr = 'Exponential function',
},
fmta([[
    \exp{<>}<>
]],
{i(1), i(0)}),
{condition = tex.in_math, show_condition = tex.in_math}),

}

-- Auto backslashes
local auto_backslash_specs = {
	ast = { context = { name = "ast" }, command = [[\ast]] },
	star = { context = { name = "star" }, command = [[\star]] },
	perp = { context = { name = "perp" }, command = [[\perp]] },
	inf = { context = { name = "inf" }, command = [[\infty]] },
	det = { context = { name = "det" }, command = [[\det]] },
	max = { context = { name = "max" }, command = [[\max]] },
	min = { context = { name = "min" }, command = [[\min]] },
	argmax = { context = { name = "argmax" }, command = [[\argmax]] },
	argmin = { context = { name = "argmin" }, command = [[\argmin]] },
	deg = { context = { name = "deg" }, command = [[\deg]] },
	angle = { context = { name = "angle" }, command = [[\angle]] }
}

local auto_backslash_snippets = {}
for k, v in pairs(auto_backslash_specs) do
	table.insert(
		auto_backslash_snippets,
		symbol_snippet(vim.tbl_deep_extend("keep", { trig = k }, v.context), v.command, { condition = tex.in_math })
	)
end
vim.list_extend(M, auto_backslash_snippets)


-- Symbols/Commands
-- TODO: fix symbols once font works
local greek_specs = {
    wedge =  { context = { name = "^" }, command = [[\wedge]] },
	alpha = { context = { name = "α" }, command = [[\alpha]] },
	beta = { context = { name = "β" }, command = [[\beta]] },
	gam = { context = { name = "γ" }, command = [[\gamma]] },
	Gam = { context = { name = "Γ" }, command = [[\Gamma]] },
	omega = { context = { name = "ω" }, command = [[\omega]] },
	Omega = { context = { name = "Ω" }, command = [[\Omega]] },
	delta = { context = { name = "δ" }, command = [[\delta]] },
	DD = { context = { name = "Δ" }, command = [[\Delta]] },
	eps = { context = { name = "ε" , priority = 500 }, command = [[\epsilon]] },
	eta = { context = { name = "θ" , priority = 500}, command = [[\eta]] },
	zeta = { context = { name = "θ" }, command = [[\zeta]] },
	theta = { context = { name = "θ" }, command = [[\theta]] },
	lmbd = { context = { name = "λ" }, command = [[\lambda]] },
	Lmbd = { context = { name = "Λ" }, command = [[\Lambda]] },
	mu = { context = { name = "μ" }, command = [[\mu]] },
	nu = { context = { name = "ν" }, command = [[\nu]] },
	pi = { context = { name = "π" }, command = [[\pi]] },
	rho = { context = { name = "ρ" }, command = [[\rho]] },
	sig = { context = { name = "σ" }, command = [[\sigma]] },
	Sig = { context = { name = "Σ" }, command = [[\Sigma]] },
	tau = { context = { name = "τ" }, command = [[\tau]] },
	xi = { context = { name = "ξ" }, command = [[\xi]] },
	vphi = { context = { name = "φ" }, command = [[\varphi]] },
	veps = { context = { name = "ε" }, command = [[\varepsilon]] },
}

local greek_snippets = {}
for k, v in pairs(greek_specs) do
	table.insert(
		greek_snippets,
		symbol_snippet(vim.tbl_deep_extend("keep", { trig = k }, v.context), v.command, { condition = tex.in_math })
	)
end
vim.list_extend(M, greek_snippets)

local symbol_specs = {
	-- operators
	["!="] = { context = { name = "!=" }, command = [[\neq]] },
	["<="] = { context = { name = "≤" }, command = [[\leq]] },
	[">="] = { context = { name = "≥" }, command = [[\geq]] },
	["<<"] = { context = { name = "<<" }, command = [[\ll]] },
	[">>"] = { context = { name = ">>" }, command = [[\gg]] },
	["~~"] = { context = { name = "~" }, command = [[\sim]] },
	["~="] = { context = { name = "≈" }, command = [[\approx]] },
	["~-"] = { context = { name = "≃" }, command = [[\simeq]] },
	["-~"] = { context = { name = "⋍" }, command = [[\backsimeq]] },
	["-="] = { context = { name = "≡" }, command = [[\equiv]] },
	["=~"] = { context = { name = "≅" }, command = [[\cong]] },
	[":="] = { context = { name = "≔" }, command = [[\definedas]] },
	["**"] = { context = { name = "·", priority = 100 }, command = [[\cdot]] },
	xx = { context = { name = "×" }, command = [[\times]] },
	["!+"] = { context = { name = "⊕" }, command = [[\oplus]] },
	["!*"] = { context = { name = "⊗" }, command = [[\otimes]] },
	-- sets
	NN = { context = { name = "ℕ" }, command = [[\mathbb{N}]] },
	ZZ = { context = { name = "ℤ" }, command = [[\mathbb{Z}]] },
	QQ = { context = { name = "ℚ" }, command = [[\mathbb{Q}]] },
	RR = { context = { name = "ℝ" }, command = [[\mathbb{R}]] },
	CC = { context = { name = "ℂ" }, command = [[\mathbb{C}]] },
	OO = { context = { name = "∅" }, command = [[\emptyset]] },
	pwr = { context = { name = "P" }, command = [[\powerset]] },
	cc = { context = { name = "⊂" }, command = [[\subset]] },
	cq = { context = { name = "⊆" }, command = [[\subseteq]] },
	qq = { context = { name = "⊃" }, command = [[\supset]] },
	qc = { context = { name = "⊇" }, command = [[\supseteq]] },
	["\\\\\\"] = { context = { name = "⧵" }, command = [[\setminus]] },
	Nn = { context = { name = "∩" }, command = [[\cap]] },
	UU = { context = { name = "∪" }, command = [[\cup]] },
	["::"] = { context = { name = ":" }, command = [[\colon]] },
	-- quantifiers and logic stuffs
	AA = { context = { name = "∀" }, command = [[\forall]] },
	EE = { context = { name = "∃" }, command = [[\exists]] },
	inn = { context = { name = "∈" }, command = [[\in]] },
	notin = { context = { name = "∉" }, command = [[\not\in]] },
	["!-"] = { context = { name = "¬" }, command = [[\lnot]] },
	VV = { context = { name = "∨" }, command = [[\lor]] },
	WW = { context = { name = "∧" }, command = [[\land]] },
    ["!W"] = { context = { name = "∧" }, command = [[\bigwedge]] },
	["=>"] = { context = { name = "⇒" }, command = [[\implies]] },
	["=<"] = { context = { name = "⇐" }, command = [[\impliedby]] },
	iff = { context = { name = "⟺" }, command = [[\iff]] },
	["->"] = { context = { name = "→", priority = 250 }, command = [[\to]] },
	["!>"] = { context = { name = "↦" }, command = [[\mapsto]] },
	["<-"] = { context = { name = "↦", priority = 250}, command = [[\gets]] },
    -- differentials 
	dp = { context = { name = "⇐" }, command = [[\partial]] },
	-- arrows
	["-->"] = { context = { name = "⟶", priority = 500 }, command = [[\longrightarrow]] },
	["<->"] = { context = { name = "↔", priority = 500 }, command = [[\leftrightarrow]] },
	["2>"] = { context = { name = "⇉", priority = 400 }, command = [[\rightrightarrows]] },
	upar = { context = { name = "↑" }, command = [[\uparrow]] },
	dnar = { context = { name = "↓" }, command = [[\downarrow]] },
	-- etc
	ooo = { context = { name = "∞" }, command = [[\infty]] },
	lll = { context = { name = "ℓ" }, command = [[\ell]] },
	dag = { context = { name = "†" }, command = [[\dagger]] },
	["+-"] = { context = { name = "†" }, command = [[\pm]] },
	["-+"] = { context = { name = "†" }, command = [[\mp]] },
}

local symbol_snippets = {}
for k, v in pairs(symbol_specs) do
	table.insert(
		symbol_snippets,
		symbol_snippet(vim.tbl_deep_extend("keep", { trig = k }, v.context), v.command, { condition = tex.in_math })
	)
end
vim.list_extend(M, symbol_snippets)

local single_command_math_specs = {
	tt = {
		context = {
			name = "text (math)",
			dscr = "text in math mode",
		},
		command = [[\text]],
	},
	sbf = {
		context = {
			name = "symbf",
			dscr = "bold math text",
		},
		command = [[\symbf]],
	},
	syi = {
		context = {
			name = "symit",
			dscr = "italic math text",
		},
		command = [[\symit]],
	},
	udd = {
		context = {
			name = "underline (math)",
			dscr = "underlined text in math mode",
		},
		command = [[\underline]],
	},
	conj = {
		context = {
			name = "conjugate",
			dscr = "conjugate (overline)",
		},
		command = [[\overline]],
	},
	["__"] = {
		context = {
			name = "subscript",
			dscr = "auto subscript 3",
			wordTrig = false,
		},
		command = [[_]],
	},
	td = {
		context = {
			name = "superscript",
			dscr = "auto superscript alt",
			wordTrig = false,
		},
		command = [[^]],
	},
	sbt = {
		context = {
			name = "substack",
			dscr = "substack for sums/products",
		},
		command = [[\substack]],
	},
	sqrt = {
		context = {
			name = "sqrt",
			dscr = "sqrt",
		},
		command = [[\sqrt]],
		ext = { choice = true },
	},
}

local single_command_math_snippets = {}
for k, v in pairs(single_command_math_specs) do
	table.insert(
		single_command_math_snippets,
		single_command_snippet(
			vim.tbl_deep_extend("keep", { trig = k, snippetType = "autosnippet" }, v.context),
			v.command,
			{ condition = tex.in_math },
			v.ext or {}
		)
	)
end

vim.list_extend(M, single_command_math_snippets)

local postfix_math_specs = {
    mbb = {
        context = {
            name = "mathbb",
            dscr =  "math blackboard bold",
        },
        command = {
            pre = [[\mathbb{]],
            post = [[}]],
        }
    },
    mcal = {
        context = {
            name = "mathcal",
            dscr =  "math calligraphic",
        },
        command = {
            pre = [[\mathcal{]],
            post = [[}]],
        }
    },
    mscr = {
        context = {
            name = "mathscr",
            dscr =  "math script",
        },
        command = {
            pre = [[\mathscr{]],
            post = [[}]],
        },
    },
    mfr = {
        context = {
            name = "mathfrak",
            dscr =  "mathfrak",
        },
        command = {
            pre = [[\mathfrak{]],
            post = [[}]],
        },
    },
    hat = {
		context = {
			name = "hat",
			dscr = "hat",
            snippetType = "autosnippet"
		},
		command = {
            pre = [[\hat{]],
            post = [[}]],
        }
	},
	bar = {
		context = {
			name = "bar",
			dscr = "bar (overline)",
            snippetType = "autosnippet"
		},
		command = {
            pre = [[\overline{]],
            post = [[}]]
        }
	},
	tld = {
		context = {
			name = "tilde",
            priority = 500,
			dscr = "tilde",
		},
		command = {
            pre = [[\tilde{]],
            post = [[}]]
        }
	}
}

local postfix_math_snippets = {}
for k, v in pairs(postfix_math_specs) do
table.insert(
    postfix_math_snippets,
    postfix_snippet(
        vim.tbl_deep_extend("keep", { trig = k, snippetType = "autosnippet" }, v.context),
        v.command,
        { condition = tex.in_math }
    )
)
end
vim.list_extend(M, postfix_math_snippets)

return M
