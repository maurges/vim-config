iabbrev <buffer> main: if __name__ == "__main__":
iabbrev <buffer> header# #!/usr/bin/python2<CR>from sys import argv
iabbrev <buffer> read_array# map(int, raw_input().strip().split(' '))

setlocal noexpandtab shiftwidth=4 tabstop=4 

setlocal omnifunc=python3complete#Complete
