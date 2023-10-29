echo "load bash_aliases"

if [[ TRUE == ${is_window} ]]; then
  case "$TERM" in
    xterm*)
      # The following programs are known to require a Win32 Console
      # for interactive usage, therefore let's launch them through winpty
      # when run inside `mintty`.
      for name in node ipython php php5 psql python2.7
      do
        case "$(type -p "$name".exe 2>/dev/null)" in
          ''|/usr/bin/*) continue;;
        esac
        alias $name="winpty $name.exe"
      done
      ;;
  esac
elif [[ TRUE == ${is_macos} ]]; then
  # homebrew
  alias bc='brew install --cask'
  alias bf='brew install'
  alias bui='brew uninstall'
  alias bl='brew list'

  # riscv toolchain
  alias rgcc='riscv64-unknown-elf-gcc'
  alias robjcopy='riscv64-unknown-elf-objcopy'
  alias robdump='riscv64-unknown-elf-robdump'
  alias rld='riscv64-unknown-elf-ld'
  alias rnm='riscv64-unknown-elf-gcc-nm'

  alias oakGate='cd ${workspace_PATH}/oakGate/EnduroSDK_v4.4.0_P3'

  # built-in
  alias readelf='greadelf'
  alias objcopy='gobjcopy'
  alias objdump='gobjdump'


  # http proxy
  alias proxy='
  export https_proxy=http://127.0.0.1:7890
  export http_proxy=http://127.0.0.1:7890
  export all_proxy=socks5://127.0.0.1:7890
  '
  alias unproxy='
  unset https_proxy
  unset http_proxy
  unset all_proxy
  '
  alias echoproxy='
  echo $https_proxy
  echo $http_proxy
  echo $all_proxy
  '
elif [[ TRUE == ${is_linux} ]] && [[ TRUE == ${is_linux_parallels} ]]; then
  #http proxy
  export hostip=$(ip route | grep default | awk '{print $3}')
  export socks_hostport=7890
  export http_hostport=7890
  alias proxy='
  export https_proxy="http://${hostip}:${http_hostport}"
  export http_proxy="http://${hostip}:${http_hostport}"
  export ALL_PROXY="socks5://${hostip}:${socks_hostport}"
  export all_proxy="socks5://${hostip}:${socks_hostport}"
  '
  alias unproxy='
  unset ALL_PROXY
  unset https_proxy
  unset http_proxy
  unset all_proxy
  '
  alias echoproxy='
  echo $ALL_PROXY
  echo $all_proxy
  echo $https_proxy
  echo $http_proxy
  '
fi

# Some good standards, which are not used if the user
# creates his/her own .bashrc/.bash_profile

# --show-control-chars: help showing Korean or accented characters
alias ls='ls -F --color=auto'
alias ll='ls -all'
alias his='history'
alias clr='clear'

# tools
alias startemacs='emacs --daemon'
alias emacsclient='emacsclient --reuse-frame --alternate-editor=""'
# alias st='subl'
alias sm='smerge'
# source
alias svar='source ${OneDrive_PATH}/terminal/.bash_variables'
alias spf='source ~/${bash_profile}'

# edit cmd
alias epf='emacsclient ~/${bash_profile}'
alias ealias='emacsclient ${OneDrive_PATH}/terminal/.bash_aliases'
alias evar='emacsclient ${OneDrive_PATH}/terminal/.bash_variables'

# dir cmd
alias ct='cd ${workspace_PATH}/test'
alias cw='cd ${workspace_PATH}/'
alias cr='cd ${workspace_PATH}/release/'
alias unicore='cd ${workspace_PATH}/unicore/'
alias 65='cd ${workspace_PATH}/rl6577/'
alias 35='cd ${workspace_PATH}/rl6643_pipeline_b/'
alias 32='cd ${workspace_PATH}/rl6468_pipeline_b/'
alias 33='cd ${workspace_PATH}/rl6531_pipeline_b/'
alias 71='cd ${workspace_PATH}/rl6817_pipeline_b/'
alias em='cd ${OneDrive_PATH}/'
alias linux='cd ${linux_kernal_PATH}/'

function mcd {
  mkdir $1 && cd $1;
}

# git cmd
alias agent='eval "$(ssh-agent -s)"'
alias agentgh='ssh-add ~/.ssh/github.id.ed25519'
alias gs='git status'
alias ga='git add'
alias gcm='git commit -s -m'
alias gca='git commit --amend'
alias gac='git am --continue'

# git diff
function ,gd {
mkdir -p watchDiff
git diff > watchDiff/diff.log
st watchDiff/diff.log
}

# git pull/push
alias gpo='git pull --ff-only'
function ,gps {
git push --progress "origin" "$1"
}

alias ghp=',gps WinMacSwapStuff:WinMacSwapStuff'

# git tag
alias gtagd='git tag -d'
alias gptag='git push --tags'
function ,gtag {
if [ "$3" ] ; then
  git tag "$1" -m "$2" "$3"
fi
git tag "$1" -m "$2"
}

#git log
function ,glog {
git log --stat --decorate=full -n"$1"
}

#git sch log
function ,gschlog {
git log -p --decorate=full --grep="$1"
}

#git format patch
function ,gfp {
git format-patch -1 "$1"
}
function ,gfpn {
git format-patch -"$1"
}
function ,gpf {
git format-patch --from "$1"
}
function ,gpft {
git format-patch "$1"~1.."$2"
}

# git checkout
alias	gb='git branch'
function ,gck {
git.exe checkout -f -B "$1" remotes/origin/"$1"
}

# git applay
alias gap='git.exe am --3way --ignore-space-change'

# git reset
alias grmix='git reset --mixed'
alias grhard='git reset --hard'






# espanso
alias eb='emacsclient   ${espanso_PATH}/match/base.yml'
alias ed='emacsclient   ${espanso_PATH}/config/default.yml'
alias en='emacsclient   ${OneDrive_PATH}/espansoCfg/peopleName.yml'
alias ecfg='emacsclient ${OneDrive_PATH}/espansoCfg/SSDCfg.yml'
alias ers='espansod restart'


# tags for emacs and neovim
function ,tag {
if [[ "emacs" == "$1" ]]; then
    is_emacs=-e
elif [[ "vim" == "$1" ]]; then
    is_emacs=
fi
ctags \
  --exclude=+'*org' \
  --exclude=+'*.patch' \
  --exclude=+'setting' \
  --exclude=+'TAGS' \
  --exclude=+'tags' \
  --exclude=+'obj' \
  --exclude=+'*.bin' \
  --if0=yes \
  --totals=yes \
  -f tags_$1 \
  $is_emacs \
  -R *

}
