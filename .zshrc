######## default PATH #######
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

####### add PATH ########
export PATH=/Users/e_ikuta/.ebcli-virtual-env/executables:$PATH
export PATH=/Users/e_ikuta/.pyenv/versions/3.7.2/bin:$PATH
export PATH="/usr/local/opt/gettext/bin:$PATH"
# mactex
export PATH=$PATH:/usr/local/texlive/2021/bin/universal-darwin

####### ghq #######
alias ghl='cd $(ghq root)/$(ghq list | peco)'

####### vim #######
# <C-s>が効くようにする
stty start undef
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
setopt share_history                  # 同一ホストで自分が動かしているすべてのzshのプロセスで履歴を共有

####### completion #######
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

####### alias #######
alias k9='kill -9'
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
alias grh^='git reset head^'
alias grh='git reset --hard head'
alias gri='git rebase -i'
alias ghb='gh browse'
alias be='bundle exec'
alias rm-cache="bundle exec rails r 'Rails.cache.clear'"
alias reload='exec zsh -l'
alias dc='docker-compose'
alias da='docker attach'
alias thrud_db='mysql -P 3026 -u root -h 127.0.0.1 --skip-password'
alias ecu='ec2ssh update'
alias ssm='aws ssm start-session --profile gadev --target $(grep -w Host ~/.ssh/config | awk '\''{print $2}'\'' | peco | head -n1 | awk -F "-" '\''{print $(NF-1) "-" $NF}'\'')'
alias rails_db_set='bundle exec rails db:environment:set RAILS_ENV=development'
alias lint_default='git diff --cached --name-only --diff-filter=AM | xargs bundle exec rubocop --force-exclusion -a --config ~/.rubocop.yml'
alias lint='git diff --cached --name-only --diff-filter=AM | xargs bundle exec rubocop --force-exclusion -a'
alias config_rubocop='vim ~/.rubocop.yml'
alias vn='vim /usr/local/etc/nginx'

########## 便利コマンド集 #############
# AWSユーザー情報
# aws sts get-caller-identity

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

######### postgres ############
#qt is keg-only, which means it was not symlinked into /usr/local,
#because Qt 5 has CMake issues when linked.
#
#If you need to have qt first in your PATH run:
#  echo 'export PATH="/usr/local/opt/qt/bin:$PATH"' >> ~/.zshrc
#
#For compilers to find qt you may need to set:
#  export LDFLAGS="-L/usr/local/opt/qt/lib"
#  export CPPFLAGS="-I/usr/local/opt/qt/include"
#
#For pkg-config to find qt you may need to set:
#  export PKG_CONFIG_PATH="/usr/local/opt/qt/lib/pkgconfig"

########## mysql@5.7 ###########
#We've installed your MySQL database without a root password. To secure it run:
#    mysql_secure_installation
#
#MySQL is configured to only allow connections from localhost by default
#
#To connect run:
#    mysql -uroot
#
#mysql@5.7 is keg-only, which means it was not symlinked into /usr/local,
#because this is an alternate version of another formula.
#
#If you need to have mysql@5.7 first in your PATH run:
#  echo 'export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"' >> ~/.zshrc
#
#For compilers to find mysql@5.7 you may need to set:
#  export LDFLAGS="-L/usr/local/opt/mysql@5.7/lib"
#  export CPPFLAGS="-I/usr/local/opt/mysql@5.7/include"
#
#For pkg-config to find mysql@5.7 you may need to set:
#  export PKG_CONFIG_PATH="/usr/local/opt/mysql@5.7/lib/pkgconfig"
#
#
#To have launchd start mysql@5.7 now and restart at login:
#  brew services start mysql@5.7
#Or, if you don't want/need a background service you can just run:
#  /usr/local/opt/mysql@5.7/bin/mysql.server start

########### mysql5.7を使用時はここをコメントインする ##############
# export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
# export LDFLAGS="-L/usr/local/opt/mysql@5.7/lib"
# export CPPFLAGS="-I/usr/local/opt/mysql@5.7/include"
# export PKG_CONFIG_PATH="/usr/local/opt/mysql@5.7/lib/pkgconfig"
# export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
##################################################################

#export DYLD_LIBRARY_PATH=/usr/local/opt/mysql/lib:$DYLD_LIBRARY_PATH

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

######## backlog リリース対象チケット取得用 #######
export BACKLOG_API_KEY=`cat ~/.secrets/backlog/api_key`

echo '******* zsh settings loaded *******'

######### for RENOSY_FORM #########
export AWS_DEFAULT_PROFILE=default

######## for brew ##########
HOMEBREW_NO_AUTO_UPDATE=1 # 自動的に brew update しない
