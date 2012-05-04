
# aliases
alias ls='ls -G'
alias vi='vim'

# ssh_agent
check_ssh_agent=$HOME/bin/check_ssh_agent
test -r ${check_ssh_agent} && ${check_ssh_agent}

# fink init
test -r /sw/bin/init.sh && . /sw/bin/init.sh

# terminal colors
color_Black="$(tput setaf 0)"
color_BlackBG="$(tput setab 0)"
color_DarkGrey="$(tput bold ; tput setaf 0)"
color_LightGrey="$(tput setaf 7)"
color_LightGreyBG="$(tput setab 7)"
color_White="$(tput bold ; tput setaf 7)"
color_Red="$(tput setaf 1)"
color_RedBG="$(tput setab 1)"
color_LightRed="$(tput bold ; tput setaf 1)"
color_Green="$(tput setaf 2)"
color_GreenBG="$(tput setab 2)"
color_LightGreen="$(tput bold ; tput setaf 2)"
color_Brown="$(tput setaf 3)"
color_BrownBG="$(tput setab 3)"
color_Yellow="$(tput bold ; tput setaf 3)"
color_Blue="$(tput setaf 4)"
color_BlueBG="$(tput setab 4)"
color_LightBlue="$(tput bold ; tput setaf 4)"
color_Purple="$(tput setaf 5)"
color_PurpleBG="$(tput setab 5)"
color_Pink="$(tput bold ; tput setaf 5)"
color_Cyan="$(tput setaf 6)"
color_CyanBG="$(tput setab 6)"
color_LightCyan="$(tput bold ; tput setaf 6)"
color_NC="$(tput sgr0)" # No Color

# terminal Prompt String 1
function stopedjobs { 
	n=`jobs -s | wc -l | sed "s/ //g"`
	[[ $n -ne 0 ]] && echo "[$n]"
}

# \t : time 24hours format - \u : username - \h : hostname - \W : current directory basename - \$ : $ if user # if root
# without colors
export PS1='[\t \u@\h \W]`stopedjobs`\$ '
# with colors
export PS1='[\[$color_Purple\]\t \[$color_NC\]\u@\h \W]\[$color_Green\]`stopedjobs`\[$color_NC\]\$ '

