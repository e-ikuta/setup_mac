######## default PATH #######
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

######## for brew ##########
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_AUTO_UPDATE=1 # 自動的に brew update しない

####### vim #######
# <C-s>が効くようにする
stty start undef
stty stop undef
setopt noflowcontrol

####### packages #######
# https://github.com/zsh-users/zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# https://github.com/zsh-users/zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# https://github.com/rupa/z
source ~/.zsh.d/z.sh

eval "$(rbenv init - zsh)"
eval "$(nodenv init -)"

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
# 同一ホストで自分が動かしているすべてのzshのプロセスで履歴を共有
setopt share_history

####### completion #######
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

####### alias #######
alias ghl='cd $(ghq root)/$(ghq list | peco)'
alias v='vim .'
alias vz='vim ~/.zshrc'
alias vv='vim ~/.vimrc'
alias sz='source ~/.zshrc'
alias va='vim ~/.aws/credentials'
alias gl='git log'
alias gpl='git pull'
alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gc='git commit -m'
alias gd='git diff'
alias gdc='git diff --cached'
alias go='git checkout'
alias gsl='git stash list'
alias grh='git reset --hard head'
alias ghb='gh browse'
alias dc='docker-compose'
alias da='docker attach'
alias ssm='aws ssm start-session --profile gadev --target $(grep -w Host ~/.ssh/config | awk '\''{print $2}'\'' | peco | head -n1 | awk -F "-" '\''{print $(NF-1) "-" $NF}'\'')'

########## function ############
gsa () {
  git stash apply stash@{$1}
}
gsp () {
  git stash pop stash@{$1}
}
grep_rails () {
  grep -rlI --exclude-dir={vendor,log,coverage,node_modules,tmp,public} "$1" "$2"/*
}
grep_rails_regex () {
  grep -rlIE --exclude-dir={vendor,log,coverage,node_modules,tmp} "$1" "$2"/*
}
grep_rails_more () {
  grep -rI --exclude-dir={vendor,log,coverage,node_modules,tmp,public} "$1" "$2"/*
}
replace_rails () {
  grep -rlI --exclude-dir={vendor,log,coverage,node_modules,tmp} "$1" "$3"/* | xargs sed -i '' -e "s/$1/$2/g"
}
aws_ssm () {
  aws ssm start-session --target $1
}

########## ga-tech personal access token ###########
export GITHUB_TOKEN=`cat ~/.secrets/github/personal_access_token`
export GITHUB_ACCESS_TOKEN=`cat ~/.secrets/github/personal_access_token`

######## backlog リリース対象チケット取得用 #######
export BACKLOG_API_KEY=`cat ~/.secrets/backlog/api_key`

######### for RENOSY_FORM #########
export AWS_DEFAULT_PROFILE=default

echo '******* .zshrc loaded *******'
