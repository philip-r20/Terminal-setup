# Terminal-setup

Mine dotfiles for et komplett terminaloppsett på macOS: kitty som terminal, zsh med Powerlevel10k-prompt, en rekke git-snarveier og Neovim satt opp som en lett IDE for Python, C/C++, Java og Kotlin.

> **Krav:** macOS på Apple Silicon (M1/M2/M3/…). Konfigurasjonen bruker Homebrew-stier under `/opt/homebrew`, som bare finnes på Apple Silicon.

## Innhold

| Fil | Installeres til | Hva den gjør |
| --- | --- | --- |
| `zsh/.zshrc` | `~/.zshrc` | Shell: prompt, plugins, historikk, aliaser |
| `zsh/.p10k.zsh` | `~/.p10k.zsh` | Utseendet på Powerlevel10k-prompten |
| `git/.gitconfig` | `~/.gitconfig` | Git-navn og e-post |
| `kitty/kitty.conf` | `~/.config/kitty/kitty.conf` | Terminalen kitty |
| `kitty/colors/cherry_blossom.conf` | `~/.config/kitty/colors/` | Fargetemaet «Cherry Blossom» |
| `nvim/init.lua` | `~/.config/nvim/init.lua` | Neovim-konfigurasjon med plugins |
| `install.sh` | – | Kopierer filene over på riktig plass |

---

## Hva oppsettet gjør

### Kitty (terminal)

- Mørkt lilla/rosa fargetema (`cherry_blossom`) med uskarp, gjennomsiktig bakgrunn
- Skjult vindusramme og tittellinje, 10 px luft rundt teksten
- Fonten Cascadia Code i størrelse 13, uten ligaturer
- Blokkmarkør uten blinking, 5000 linjer scrollback
- Fjernstyring er slått på (`listen_on unix:/tmp/kitty`)

| Snarvei | Handling |
| --- | --- |
| `Cmd+T` / `Cmd+W` | Ny fane / lukk fane |
| `Cmd+←` / `Cmd+→` | Forrige / neste fane |
| `Cmd+Enter` | Fullskjerm av/på |
| `Cmd+C` / `Cmd+V` | Kopier / lim inn |
| `Cmd++` / `Cmd+-` / `Cmd+0` | Større / mindre / standard tekststørrelse |

### Zsh (shell)

- **Powerlevel10k** på én linje i ASCII-stil, med instant prompt så terminalen åpner raskt
- **zsh-syntax-highlighting** farger kommandoer mens du skriver (rødt = ugyldig)
- **zsh-autosuggestions** foreslår kommandoer fra historikken i grått. Trykk `→` for å godta forslaget.
- **Historikk:** delt mellom alle åpne terminaler og lagret i `~/.zhistory`. `↑` / `↓` søker i historikken etter det du allerede har skrevet.
- **fzf:** `Ctrl+R` søker i historikken, `Ctrl+T` finner filer og `**<Tab>` fuzzy-fullfører stier.
- **zoxide:** `cd` er byttet ut med `z`, som husker mappene du bruker. `cd proj` hopper rett til mappen du oftest bruker som matcher «proj».
- **eza** i stedet for `ls`, med ikoner:
  - `ls`: vanlig liste
  - `ll`: detaljert liste
  - `la`: også skjulte filer
  - `lt`: trevisning
- **Java 21** settes som `JAVA_HOME`. `jc` kompilerer alle `.java`-filer i mappen.
- `vim` og `vi` åpner Neovim.
- `Ctrl+G` åpner **lazygit**, et git-grensesnitt i terminalen. Du kan også skrive `lg`.

### Git-aliaser

| Alias | Kommando | | Alias | Kommando |
| --- | --- | --- | --- | --- |
| `gs` | `git status` | | `gsw` | `git switch` |
| `ga` | `git add .` | | `gsc` | `git switch -c` (ny branch) |
| `gap` | `git add -p` | | `gcb` | `git checkout -b` |
| `gc` | `git commit -m` | | `gb` | `git branch` |
| `gca` | `git commit -am` | | `gbd` / `gbD` | slett branch / slett med tvang |
| `gp` | `git push` | | `gm` | `git merge` |
| `gpl` | `git pull` | | `gr` / `gri` | `git rebase` / interaktiv rebase |
| `gf` | `git fetch` | | `grc` / `gra` | fortsett / avbryt rebase |
| `gfa` | `git fetch --all --prune` | | `gst` / `gstp` | stash / stash pop |
| `gd` | `git diff` | | `gsts` / `gstl` | vis stash / list stasher |
| `gds` | `git diff --staged` | | `grs` / `grst` | restore fil / fjern fra staging |
| `gl` | fargerik loggraf | | `gundo` | forkast **alle** endringer ⚠️ |
| `grv` | `git remote -v` | | `gcl` | slett usporede filer ⚠️ |
| `grao` | `git remote add origin` | | `gwho` | vis hvilket navn og e-post du committer som |
| `groot` | gå til roten av repoet | | `lg` | lazygit |

### Neovim

Plugins lastes automatisk med [lazy.nvim](https://github.com/folke/lazy.nvim) første gang du starter `nvim`.

- **Utseende:** tokyonight-tema, lualine-statuslinje, ikoner, relative linjenumre og markering av linjen markøren står på
- **Treesitter:** syntaksfarger og innrykk for Lua, Python, Java, Kotlin, C, C++ og SQL
- **LSP** (feilmeldinger, gå til definisjon og så videre) for:
  - Python (`pyright`)
  - C/C++ (`clangd`)
  - Java (`jdtls`)
  - Kotlin (`kotlin_language_server`)
- **Autofullføring** med nvim-cmp og snippets (LuaSnip). Det er slått av inne i strenger.
- **Telescope:** fuzzy-søk etter filer og tekst
- **Neo-tree:** filutforsker i et sidepanel
- **Autopairs** lukker parenteser og anførselstegn, og **neotab** lar deg hoppe ut av dem med `Tab`.
- **Markdown:** `:MarkdownPreview` åpner forhåndsvisning i nettleseren, og `:Glow` viser den i terminalen.
- Systemutklippstavlen er delt med Neovim, og tekst du kopierer (yank) blinker kort.

| Tast (leader = `Space`) | Handling |
| --- | --- |
| `Space e` | Vis / skjul filutforskeren (Neo-tree) |
| `Space d` | Vis feilmelding for linjen |
| `Space a` | Code action (automatisk fiks) |
| `Space v` / `Space c` | Utvid / krymp markering (Treesitter) |
| `Tab` / `Shift+Tab` | Neste / forrige forslag i autofullføring |
| `Ctrl+Space` | Åpne autofullføring manuelt |
| `Esc` | Fjern søkemarkering |

---

## Installasjon

### 1. Grunnleggende verktøy

```sh
# Xcode command line tools (git, kompilator for Treesitter)
xcode-select --install

# Homebrew (hopp over hvis du har det)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Installer programmene

```sh
# Terminal og font
brew install --cask kitty font-cascadia-code

# Shell
brew install powerlevel10k zsh-syntax-highlighting zsh-autosuggestions \
             zoxide fzf eza lazygit

# Neovim og det plugins trenger
brew install neovim ripgrep node glow

# Språkservere (LSP). clangd for C/C++ følger med Xcode command line tools.
brew install pyright jdtls kotlin-language-server

# Java 21
brew install --cask temurin@21
```

### 3. Hent repoet

```sh
git clone https://github.com/philip-r20/Terminal-setup.git ~/dotfiles
```

Repoet kan ligge hvor du vil, men `~/dotfiles` er standard.

### 4. Installer

```sh
bash ~/dotfiles/install.sh
```

Dette gjør skriptet:

- Kopierer konfigurasjonsfilene til riktig plass.
- **Tar backup** av eksisterende filer som blir overskrevet. De legges i `~/dotfiles-backup/<dato-tid>/`.
- **Beholder git-navnet og e-posten din** hvis du har satt dem fra før. Har du ikke det, spør skriptet om dem.

Åpne deretter **kitty** (eller kjør `exec zsh` i en åpen terminal).

> **Neovim:** Har du Neovim installert manuelt i `~/bin/nvim-macos-arm64`, brukes den. Ellers brukes `nvim` fra PATH, for eksempel fra Homebrew. Du trenger ikke endre noe.

### 5. Første oppstart av Neovim

Kjør `nvim`. lazy.nvim laster ned alle plugins automatisk, og Treesitter installerer språkparserne. Vent til det er ferdig, og start Neovim på nytt.

---

## Oppdatere

Konfigurasjonen **kopieres** til hjemmemappen, den lenkes ikke. Endringer du gjør i `~/dotfiles` får derfor ikke virkning før du kjører `install.sh` på nytt. Det motsatte gjelder også: endrer du `~/.zshrc` direkte, må du kopiere filen tilbake til repoet før du committer.

```sh
cd ~/dotfiles && git pull && bash install.sh && exec zsh
```

## Tilpasning

- **Prompten:** kjør `p10k configure` for å lage en ny stil, og kopier deretter `~/.p10k.zsh` inn i `zsh/`.
- **Farger i kitty:** rediger `kitty/colors/cherry_blossom.conf`, eller bytt ut `include`-linjen i `kitty.conf`.
- **Ikoner:** `eza --icons` og ikonene i Neovim trenger en [Nerd Font](https://www.nerdfonts.com/) for å vises riktig. Ser du firkanter, installerer du `brew install --cask font-caskaydia-cove-nerd-font` og setter `font_family CaskaydiaCove Nerd Font` i `kitty.conf`.

## Feilsøking

| Problem | Løsning |
| --- | --- |
| Vil ha tilbake de gamle konfigurasjonsfilene | Kopier dem fra `~/dotfiles-backup/<dato-tid>/` |
| `Unable to find any JVMs matching version "21"` | Installer Java 21 (`brew install --cask temurin@21`) eller endre versjonen i `.zshrc` |
| `no such file or directory: /opt/homebrew/...` | En av brew-pakkene i steg 2 mangler, eller maskinen har Intel-prosessor |
| `zsh: command not found: nvim` | Installer Neovim: `brew install neovim` |
| LSP virker ikke for et språk | Sjekk at språkserveren er installert, og kjør `:checkhealth vim.lsp` i Neovim |
| zoxide klager på konfigurasjonen | `zoxide init` må ligge helt nederst i `~/.zshrc` |
