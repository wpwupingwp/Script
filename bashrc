# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=100000

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '

eval `dircolors .dircolorsdb`
# some more ls aliases
alias ls='ls -CF --color=auto'
alias ll='ls -sail'
alias la='ls -A'
alias l='ls -CF'
alias df='df -h'
alias gcc='gcc -pedantic -Wall -Wextra -Werror -g'

#server
export TERM='xterm-256color'
s='lichanghao@192.168.70.85'
#scp path
c='lichanghao@192.168.70.85:/home/zhangxianchun/lichanghao/CT/wp'
#git python
p='/home/wp/git/python/'
gae='/home/wp/Downloads/goagent/proxy.py'
