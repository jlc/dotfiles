# based on robbyrussell's theme

#PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
PROMPT='%{$fg[white]%}%n@%m %{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

#
# Example how to execute a function when rendering the right prompt
#
# function number_of_jobs {
#   if [[ $(jobs | wc -l) -gt 0 ]]; then echo '%j'
#   else echo 'no jobs'
#   fi
# }
# RPROMPT='$(number_of_jobs)'
#
# Zsh way :)
# If nb jobs > 0, display it, if == 0, show 'no jobs'
# RPROMPT='%(1j.%j.)%(0j.no jobs.)'
#

# with colors
RPROMPT='%(1j.%{$fg_bold[green]%}[%j]%{$reset_color%}.)'

#ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
