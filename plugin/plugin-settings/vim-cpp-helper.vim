"add abbreviation to quickly edit class
cabbrev <expr> ec (getcmdpos() == 3 && getcmdtype() == ":") ? "EditClass" : "ec"
cabbrev <expr> tabec (getcmdpos() == 6 && getcmdtype() == ":") ? "TabEditClass" : "tabec"
