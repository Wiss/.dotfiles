# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="fino"
#ZSH_THEME="geoffgarside"
#ZSH_THEME="agnoster"
#ZSH_THEME="powerlevel10k/powerlevel10k"

# taken from Julito's configs
# https://github.com/JulianGoeltz/myConfigFiles/blob/master/zshrc
#ZSH_THEME="robbyrussell"
## use variables to make designing prompt easier
#autoload colors zsh/terminfo
#if [[ "$terminfo[colors]" -ge 8 ]]; then
#    colors
#fi
#for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE ORANGE; do
#    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
#    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
#    (( count = $count + 1 ))
#done
#define_prompt () {
#	ZSH_THEME_GIT_PROMPT_PREFIX="|$PR_RED"
#	ZSH_THEME_GIT_PROMPT_SUFFIX="$PR_NO_COLOR"
#	ZSH_THEME_GIT_PROMPT_DIRTY="$PR_LIGHT_YELLOW ⚡"
#
#	ZSH_THEME_GIT_PROMPT_CLEAN=""
#	# we have to use double quotes for this one to evaluate the colors
#	PR_NO_COLOR="%{$terminfo[sgr0]%}"
#	PROMPT="\
#┌─["
#	PROMPT=$PROMPT"${PR_CYAN}%D{%m-%d/%H:%M:%S}$PR_NO_COLOR|$PR_LIGHT_GREEN%n$PR_NO_COLOR@$PR_LIGHT_YELLOW%m$PR_NO_COLOR"
#	PROMPT=$PROMPT'`[ -n "$VIRTUAL_ENV" ] && echo -n "$PR_NO_COLOR|$PR_MAGENTA" && echo -n $(basename $VIRTUAL_ENV)`'$PR_NO_COLOR
#	PROMPT=$PROMPT'$([ -n "$SINGULARITY_APPNAME" ] && echo "$PR_NO_COLOR|${PR_MAGENTA}$SINGULARITY_APPNAME")'$PR_NO_COLOR
#	PROMPT=$PROMPT'$([ -n "$SLURM_HARDWARE_LICENSES" ] && echo "$PR_NO_COLOR|${PR_MAGENTA}$SLURM_HARDWARE_LICENSES")'$PR_NO_COLOR
#	PROMPT=$PROMPT'$(git_prompt_info)'$PR_NO_COLOR
#	PROMPT=$PROMPT"|%(1j.$PR_YELLOW%j$PR_NO_COLOR|.)$PR_BLUE%~$PR_NO_COLOR"
#	# for vi normal mode, make first bit red
#	PROMPT=$PROMPT"]
#└─☉ "
#	# └─⬧ "
#	# └─⧫ "
#	# ━
#	# └─☉ "
#}
#define_rprompt () {
#	RPROMPT="$PR_YELLOW(%?)$PR_NO_COLOR "
#}
#define_prompt
#define_rprompt

# ### Themes 
themeDir="$HOME/.zsh/themes/"
# load power10k theme
[ -d "$themeDir/powerlevel10k" ] && source $themeDir/powerlevel10k/powerlevel10k.zsh-theme

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git zsh-autosuggestions zsh-syntax-highlighting 
#        fast-syntax-highlighting zsh-autocomplete)

# taken from Julito's configs
# https://github.com/JulianGoeltz/myConfigFiles/blob/master/zshrc
# ### Plugins
pluginDir="$HOME/.zsh/plugins/"
# load autosuggestions
[ -d "$pluginDir/zsh-autosuggestions" ] && source $pluginDir/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_USE_ASYNC=""
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="underline"
bindkey '^N' autosuggest-execute

[ -d "$pluginDir/zsh-syntax-highlighting" ] && source $pluginDir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -d "$pluginDir/zsh-history-substring-search" ] && source $pluginDir/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# actual delete character
bindkey "^[[3~" delete-char
# history line up or down with ctrl-j/k
bindkey '^K' up-line-or-history
bindkey '^J' down-line-or-history

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# <<< autoactivate venvs <<<
function cd() {
  builtin cd "$@"

  if [[ -z "$VIRTUAL_ENV" ]] ; then
    for dir in ./ ../; do
      for venv_name in venv env00; do
        if [[ -d "${dir}${venv_name}" ]] ; then
          echo "Activating ${venv_name} from ${dir}..."
          source "${dir}${venv_name}/bin/activate"
          return
        fi
      done
    done
  else
    parentdir="$(dirname "$VIRTUAL_ENV")"
    if [[ "$PWD"/ != "$parentdir"/* ]] ; then
      deactivate
    fi
  fi
}
# >>> autoactivate venvs >>>


# Alias
## enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
##
alias p="python3"
alias zotero="/opt/zotero/zotero"
alias sourcezsh="source ~/.zshrc"
alias e="emacs -nw"

# if nvim is available use it instead
if type nvim 2>&1 >/dev/null ; then
	alias vim=nvim
	alias vimdiff="nvim -d "
fi
# <<< Alias <<<

# export paths
# >>> Wakatime >>>
# install using the following instructions
# https://wakatime.com/emacs 
export PATH="$HOME/.wakatime:$PATH"
# <<< Wakatime <<<

# >>> Heroku >>>
export PATH="$HOME/usr/local/bin/heroku:$PATH"
# <<< Heroku <<<

# >>> Poetry >>>
export PATH="/home/ijaras/.local/bin:$PATH"
# <<< Poetry <<<
