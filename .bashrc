# .bashrc

man() {
     env LESS_TERMCAP_mb=$'\E[01;31m' \
     LESS_TERMCAP_md=$'\E[01;38;5;74m' \
     LESS_TERMCAP_me=$'\E[0m' \
     LESS_TERMCAP_se=$'\E[0m' \
     LESS_TERMCAP_so=$'\E[38;5;246m' \
     LESS_TERMCAP_ue=$'\E[0m' \
     LESS_TERMCAP_us=$'\E[04;38;5;146m' \
     man "$@"
    }
 #Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
export PAGER="most"

#parametrage du prompt
if [ $(id -u) -eq 0 ];
then
    PS1='\[\e]2;`basename $PWD`\a\]\[\e[1;36m\][\d \t]\n\[\e[1;37m\] \u@\h \[\e[48;5;27m\]\w]\$\[\e[m'
else

    PS1='\[\e]2;`basename $PWD`\a\]\[\e[1;33m\][\d \t]\n\[\e[1;37m\] \u@\h \[\e[48;5;27m\][\w]\$\[\e[0m '
fi
#-------------------
# Personnal Aliases
#-------------------
alias mkdir='mkdir -p'

alias h='history'
alias j='jobs -l'
alias which='type -a'
alias ..='cd ..'

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'


alias du='du -kh'    # Makes a more readable output.
alias df='df -kTh'

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls).
#-------------------------------------------------------------
# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h --color'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lv --group-directories-first"
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...
#-------------------------------------------------------------
#Gestion de l'historique
#-------------------------------------------------------------
export HISTCONTROL=ignoreboth
export HISTIGNORE='ls -la:ll:la:pwd:date:cd ..'
export HISTSIZE=300
export HISTFILESIZE=1500
export HISTTIMEFORMAT='%D %A:  '

#-------------------------------------------------------------
#Fonctions de compression
#-------------------------------------------------------------

function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}


# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}
