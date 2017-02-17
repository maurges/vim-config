setlocal cpoptions+=M
noremap  <buffer> <silent> q :s/^\(-- \)\?/-- /<CR>
noremap  <buffer> <silent> Q :s/^\(-- \)\?//<CR>
