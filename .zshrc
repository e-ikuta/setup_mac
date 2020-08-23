######## PATH #######
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

####### vim #######
export PATH=/usr/local/Cellar/vim/8.2.1500/bin:$PATH
# <C-s>が効くようにする
stty stop undef
setopt noflowcontrol

####### nodeenv #######
eval "$(nodenv init -)"

####### rbenv ########
eval "$(rbenv init -)"

####### packages ####### 
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# https://github.com/rupa/z
source ~/.zsh.d/z.sh

####### prompt #######
PROMPT='%F{magenta}%~ $ %f'
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd() { vcs_info }
RPROMPT='${vcs_info_msg_0_}'

###### colors ######
# lsで表示されるファイル・フォルダの色を見やすくする http://d.hatena.ne.jp/edvakf/20080413/1208042916
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

####### history #######
SAVEHIST=100000

####### completion #######
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

####### alias #######
alias k9='kill -9'
alias vz='vim ~/.zshrc'
alias vv='vim ~/.vimrc'
alias sz='source ~/.zshrc'
alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gc='git commit -m'
alias gd='git diff'
alias go='git checkout'
alias gsl='git stash list'
alias be='bundle exec'
alias reload='exec zsh -l'
alias dc='docker-compose'
alias ecu='ec2ssh update'
alias ssm='aws ssm start-session --profile gadev --target $(grep -w Host ~/.ssh/config | awk '\''{print $2}'\'' | peco | head -n1 | awk -F "-" '\''{print $(NF-1) "-" $NF}'\'')'
alias rails_db_set='bundle exec rails db:environment:set RAILS_ENV=development'

########## function ############
gsa () {
  git stash apply stash@{$1}
}
grep_rails () {
  grep -rlI --exclude-dir="vendor" --exclude-dir="log" --exclude-dir="coverage" "$1" "$2"/*
}
grep_rails_more () {
  grep -rI --exclude-dir="vendor" --exclude-dir="log" --exclude-dir="coverage" "$1" "$2"/*
}
replace_rails () {
  grep -rlI --exclude-dir="vendor" --exclude-dir="log" --exclude-dir="coverage" "$1" "$3"/* | xargs sed -i '' -e "s/$1/$2/g"
}

########### fzf ################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

########## ga-tech github personal access token ###########
export GITHUB_TOKEN=`cat ~/.secrets/github/personal_access_token`

########## docker ############
export DOCKER_CLIENT_TIMEOUT=120
export COMPOSE_HTTP_TIMEOUT=120
