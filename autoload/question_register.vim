" Description: choose a register to use with `"?`

fun! question_register#question_register(mode) abort
	let contents = []
	fun! s:add_nonempty(name, content) closure
		if len(a:content) != 0
			let contents += [[a:name, a:content]]
		endif
	endfun

	call s:add_nonempty("\"", @@)

	call s:add_nonempty("0", @0)
	call s:add_nonempty("1", @1)
	call s:add_nonempty("2", @2)
	call s:add_nonempty("3", @3)
	call s:add_nonempty("4", @4)
	call s:add_nonempty("5", @5)
	call s:add_nonempty("6", @6)
	call s:add_nonempty("7", @7)
	call s:add_nonempty("8", @8)
	call s:add_nonempty("9", @9)

	call s:add_nonempty("-", @-)

	call s:add_nonempty("a", @a)
	call s:add_nonempty("b", @b)
	call s:add_nonempty("c", @c)
	call s:add_nonempty("d", @d)
	call s:add_nonempty("e", @e)
	call s:add_nonempty("f", @f)
	call s:add_nonempty("g", @g)
	call s:add_nonempty("h", @h)
	call s:add_nonempty("i", @i)
	call s:add_nonempty("j", @j)
	call s:add_nonempty("k", @k)
	call s:add_nonempty("l", @l)
	call s:add_nonempty("m", @m)
	call s:add_nonempty("n", @n)
	call s:add_nonempty("o", @o)
	call s:add_nonempty("p", @p)
	call s:add_nonempty("q", @q)
	call s:add_nonempty("r", @r)
	call s:add_nonempty("s", @s)
	call s:add_nonempty("t", @t)
	call s:add_nonempty("u", @u)
	call s:add_nonempty("v", @v)
	call s:add_nonempty("w", @w)
	call s:add_nonempty("x", @x)
	call s:add_nonempty("y", @y)
	call s:add_nonempty("z", @z)

	call s:add_nonempty(":", @:)
	call s:add_nonempty(".", @.)
	call s:add_nonempty("%", @%)
	call s:add_nonempty("#", @#)
	call s:add_nonempty("*", @*)
	call s:add_nonempty("+", @+)
	call s:add_nonempty("/", @/)

	let prompt = "Name Content"
	for [name, content] in contents
		let idx = stridx(content, "\n")
		if idx != -1
			let content = content[0 : idx - 1] .. "\\n..."
		endif
		let content = substitute(content, '\n', '\\n', "g")
		if len(content) > 80
			let content = content[0:80] .. "..."
		endif

		let prompt .= "\n \"" .. name .. "  " .. content
	endfor
	let prompt .= "\nSelect name: "
	echon prompt
	let choice = getchar()
	redraw!

	return nr2char(choice)
endfun
