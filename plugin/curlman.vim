" Description: sort of like postman. Can send environment variables and run
" curl commands (any commands, really)

if !exists("g:curlman_switch_to_result")
	let g:curlman_switch_to_result = v:false
endif

" global so one could disable it
if !exists("g:curlman_did_source_env")
	let g:curlman_did_source_env = v:false
endif

command! -nargs=0 Curl :call curlman#run_in_file()
command! -nargs=1 -complete=environment -range=% CurlSet :call curlman#set_env(<q-args>, curlman#get_visual_selection())
