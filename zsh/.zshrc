# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(zoxide init zsh)"
alias cd="z"

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh


# ────────────────────────────────────────────────
# Git: Rask arbeidsflyt (standard)
# ────────────────────────────────────────────────

alias gs="git status"                        # Se status på repoet
alias ga="git add ."                         # Legg alle endringer i staging
alias gap='git add -p'                        # Interaktiv staging (veldig nyttig)
alias gc='git commit -m'                      # Commit med melding
alias gca='git commit -am'                    # Commit + auto-stage modifiserte filer
alias gpl='git pull'                          # Hent + flett endringer fra remote
alias gp='git push'                           # Push endringene dine
alias gl='git log --oneline --graph --decorate'  # Fin, kompakt loggvisning

# ────────────────────────────────────────────────
# Branching
# Moderne branching (git switch) – bedre enn checkout
# ────────────────────────────────────────────────

alias gsw='git switch'                        # Bytt branch
alias gsc='git switch -c'                     # Lag ny branch + bytt dit
alias gcb='git checkout -b'                   # Alternativ til gsc
alias gb='git branch'                         # List branches
alias gbd='git branch -d'                     # Slett ferdig branch
alias gbD='git branch -D'                     # Slett branch med tvang

# ────────────────────────────────────────────────
# Syncing / fetching uten å endre filene dine
# ────────────────────────────────────────────────

alias gf='git fetch'                          # Hent endringer (uten merge)
alias gfa='git fetch --all --prune'           # Hent alt + rydd i døde branches

# ────────────────────────────────────────────────
# Rebase, merge og conflict fixing
# ────────────────────────────────────────────────

alias gm='git merge'                          # Merge branch inn i nåværende
alias gr='git rebase'                         # Rebase
alias gri='git rebase -i'                     # Interaktiv rebase (rydd commits)
alias grc='git rebase --continue'             # Fortsett etter konfliktløsning
alias gra='git rebase --abort'                # Avbryt rebase

# ────────────────────────────────────────────────
# Stash (midlertidig lagring av arbeid)
# ────────────────────────────────────────────────

alias gst='git stash'                         # Stash alt
alias gstp='git stash pop'                    # Ta stash tilbake
alias gsts='git stash show --patch'           # Vis hva stash inneholder
alias gstl='git stash list'                   # List stash-elementer

# ────────────────────────────────────────────────
# Rydding / debugging
# ────────────────────────────────────────────────

alias gd='git diff'                           # Vis forskjeller i filer
alias gds='git diff --staged'                 # Diff mellom staged og siste commit
alias gcl='git clean -fd'                     # Fjern untracked filer (fare!)
alias gundo='git restore .'                   # Tilbakestill alle endringer
alias grs='git restore'                       # Tilbakestill en spesifikk fil
alias grst='git restore --staged'             # Ta filer ut av staging

# ────────────────────────────────────────────────
# Remote / origin
# ────────────────────────────────────────────────

alias grao='git remote add origin'            # Legg til origin
alias grv='git remote -v'                     # List remotes

# ────────────────────────────────────────────────
# Navigasjonshjelp
# ────────────────────────────────────────────────

alias gwho='git config user.name && git config user.email'
                                              # Hvem du committer som (nyttig!)
alias groot='cd $(git rev-parse --show-toplevel)'
                                              # Gå til rotmappen av repoet

# ────────────────────────────────────────────────
# Bonus: LazyGit om du bruker det
# ────────────────────────────────────────────────

alias lg='lazygit'                            # Hurtig TUI UI for git
#
# Ctrl-g åpner lazygit
bindkey -s '^G' 'lazygit\n'

# ---- nvim ----
alias nvim="$HOME/bin/nvim-macos-arm64/bin/nvim"
alias vim="nvim"
alias vi="nvim"

source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
source /opt/homebrew/opt/fzf/shell/completion.zsh

alias ls="eza --icons"
alias ll="eza -l --icons"
alias la="eza -la --icons"
alias lt="eza -T --icons"  # tree-view

export JAVA_HOME=$(/usr/libexec/java_home -v 21)
export PATH="$JAVA_HOME/bin:$PATH"

alias gl='git log --graph --abbrev-commit --decorate \
--pretty=format:"%C(#cba6f7)%h%Creset %C(#f5a9e1)%d%Creset %C(#c0caf5)%s%Creset %C(#7dcfff)- %an %C(#565f89)(%cr)"'

# ------------------------------------
# Java alias
# ------------------------------------
alias jc="javac *.java"
export PATH="$HOME/.local/bin:$PATH"
