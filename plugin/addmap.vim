" Description: a simple way to decorate a mapping

" remaps lhs in mode: will execute rhs before it's initial mapping
fun! AddMap(lhs, rhs, mode, options) abort
	let d = maparg(a:lhs, a:mode, 0, 1)
	"if mapping does not exists, make the most basic map
	if d == {}
		command = a:mode . "noremap ". a:options . " " . a:lhs . " " . a:rhs
		exec command
		return
	endif

	let command = a:mode

	if d.noremap
		let command .= "noremap "
	else
		let command .= "map "
	endif

	if d.silent
		let command .= "<silent> "
	endif

	if d.expr
		let command .= "<expr> "
	endif

	if d.buffer
		let command .= "<buffer> "
	endif

	if d.nowait
		let command .= "<nowait> "
	endif

	let command .= d.lhs . " " . a:rhs . d.rhs

	exec command
endfun
