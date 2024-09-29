set --global fish_greeting
fish_config theme choose "Mono Smoke"
set --global fish_autosuggestion_enabled 0

set --global --export EDITOR "/usr/bin/env nvim"

if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
    set --global fish_autosuggestion_enabled 0

    # Disable vi-mode indicator
    function fish_mode_prompt; end

    function fish_prompt --description 'Write out the prompt'
        function format_jobs
            read --local jobs_amount
            if [ $jobs_amount = 0 ]
                echo ""
            else
                echo "-$jobs_amount"
            end
        end

        set --local nix_prefix ""
        set --local nix_suffix ""
        if set --query IN_NIX_SHELL
            set nix_prefix "["
            set nix_suffix "]"
        end
        set --local level ""
        if [ $SHLVL -gt 1 ]
            set level "<$SHLVL>"
        end
        set --local jobs $(jobs | wc -l | tr -d " \\n" | format_jobs)

        string join '' -- (set_color green) $nix_prefix $USER $level "@" (prompt_hostname) $jobs $nix_suffix ":" (set_color blue) (prompt_pwd --dir-length=0) (set_color normal) "> "
    end
end

alias vim "nvim"
alias ls "ls --color=auto"
alias gdb "gdb -q"
alias g "grep -i"
abbr --add objdump objdump --disassembler-options=intel
abbr --add find find 2>/dev/null
alias o less
abbr --add jcurl curl -H "Content-Type: application/json"

function disas
    objdump --disassembler-options=intel -D $argv | less
end

set --global --export NIX_BUILD_SHELL fshell
