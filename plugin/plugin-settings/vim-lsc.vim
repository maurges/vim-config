let g:lsc_server_commands = {'haskell': 'hie-wrapper.exe'}

let g:lsc_auto_map = {
	\ 'GoToDefinition': '<C-]>',
	\ 'GoToDefinitionSplit': ['<C-W>]', '<C-W><C-]>'],
	\ 'FindReferences': 'gr',
	\ 'FindImplementations': 'gd',
	\ 'FindCodeActions': '\ca',
	\ 'Rename': '\r',
	\ 'ShowHover': '\h',
	\ 'Completion': 'omnifunc',
	\}
