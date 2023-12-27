eval "$(/opt/homebrew/bin/brew shellenv)"

#  Emacs path
#export PATH="/Applications/MacPorts/Emacs.app/Contents/MacOS:$PATH"
#export PATH="/opt/homebrew/Cellar/emacs-plus@28/28.2/Emacs.app:$PATH"
#export PATH="/opt/homebrew/opt/emacs-plus@28/28.2/Emacs.app:$PATH"
#export PATH="/Applications/Emacs.app:$PATH"

# Pyright path
#export PATH="/opt/homebrew/bin/pyright:$PATH"
#export PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin/pyright:$PATH"

# doom path
#export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"

# Alias for emacs
#alias emacs='sh $(brew --prefix)/opt/emacs-plus@28/Emacs.app/Contents/MacOS/Emacs.sh "$@"'
#alias emacs='sh $(brew --prefix)/opt/homebrew/Cellar/emacs-plus@28/28.2/Emacs.app
#/opt/emacs-plus@28/Emacs.app/Contents/MacOS/Emacs.sh "$@"'
#alias emacs='sh /Applications/Emacs.app "@"'
alias emacs='open /Applications/Emacs.app'

#  python path
export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"

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

##
# Your previous /Users/ijaras/.zprofile file was backed up as /Users/ijaras/.zprofile.macports-saved_2023-10-30_at_16:29:20
##

# MacPorts Installer addition on 2023-10-30_at_16:29:20: adding an appropriate PATH variable for use with MacPorts.
#export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2023-10-30_at_16:29:20: adding an appropriate MANPATH variable for use with MacPorts.
#export MANPATH="/opt/local/share/man:$MANPATH"
# Finished adapting your MANPATH environment variable for use with MacPorts.


# Setting PATH for Python 3.8
# The original version is saved in .zprofile.pysave
export PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:$PATH"
#PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
#export PATH
