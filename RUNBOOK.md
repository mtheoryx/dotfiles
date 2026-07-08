# Runbook: Phase 5 & Phase 6

## Current Status (as of 2026-07-07)

### Phase 5: Mac Mini (Ubuntu) — VALIDATED ✅

Confirmed working on ubuntu-mini via Tailscale:
- `rl` (reload shell) ✅
- `ls` (eza with icons) ✅
- `cat` (batcat with syntax highlighting) ✅
- `nv` (nvim) ✅
- `tm` (tmux) ✅

### Remaining issues — NONE blocking

All three bugs from initial testing are resolved:
1. ~~`batcat` alias~~ — Fixed in core.zsh (fallback from `bat` to `batcat`)
2. ~~`eza` not installed~~ — Added to core packages in bootstrap, manually installed
3. ~~`rl` not found~~ — Loader ordering fixed (.zshrc.local sourced early)

---

## Phase 6: Cut Over on Primary MBP (CSTG)

### Pre-flight Checklist

- [ ] Confirm `~/.zshrc.secrets` exists with real keys (created earlier this session)
- [ ] Confirm you're on `feature/machine-profiles` branch
- [ ] Confirm Oh-My-Zsh + Alien theme are already installed in `~/.oh-my-zsh`
- [ ] Have a second terminal open in case the shell breaks

### Rollback Plan

If anything goes wrong after cutover:
```bash
exec bash                         # escape to a working shell
cd ~/dotfiles && git checkout master -- zsh/.zshrc zsh/.zprofile zsh/.zshenv
stow -R zsh
exec zsh                          # back to the old config
```

Or even simpler — stow originals are still on master.

### Cutover Steps

Run from within `~/dotfiles` on the CSTG MBP:

```bash
# 1. Make sure we're current
git checkout feature/machine-profiles
git pull

# 2. Copy .new files over the originals (in the repo, not in ~)
cp zsh/.zshrc.new zsh/.zshrc
cp zsh/.zprofile.new zsh/.zprofile
cp zsh/.zshenv.new zsh/.zshenv

# 3. Backup existing live files (only real files, not symlinks)
for f in ~/.zshrc ~/.zprofile ~/.zshenv; do
    if [[ -f "$f" && ! -L "$f" ]]; then
        mv "$f" "${f}.backup.$(date +%s)"
    fi
done

# 4. Re-stow to update symlinks
stow -R zsh

# 5. Set desktop profile (default, but explicit is better)
echo "export DOTFILES_PROFILE=desktop" > ~/.zshrc.local

# 6. Verify secrets file is in place
cat ~/.zshrc.secrets

# 7. Launch new shell
exec zsh
```

### Post-Cutover Validation

Test these one at a time:

| Command | Expected | Why |
|---------|----------|-----|
| `rl` | Reloads shell, no errors | Loader works |
| `ls` | Colored output with icons | eza alias |
| `cat ~/.zshrc` | Syntax-highlighted output | bat alias |
| `nv` | Opens nvim | core alias |
| `tm` | Attaches/creates tmux | core alias |
| `lg` | Opens lazygit | core alias (if lazygit installed) |
| `cd ~/Projects && cd -` | Lists dir on cd | chpwd hook |
| `echo $AZURE_DEVOPS_PAT` | Shows the value | secrets loaded |
| `git status` | Uses hub (shows GitHub info) | os-macos hub alias |
| `work` | Starts 35m timer | pomodoro alias (if timer installed) |
| `y` | Opens yazi file picker | core yazi wrapper |

### If Something Breaks

| Symptom | Likely Cause | Fix |
|---------|-------------|-----|
| "command not found" for everything | DOTFILES_DIR wrong | Check `echo $DOTFILES_DIR` — should be `~/dotfiles/zsh` |
| Prompt is plain/ugly | Alien theme not sourced | Check `~/.oh-my-zsh/themes/alien/` exists |
| No colors, no icons | eza/bat not installed | `brew install eza bat` |
| "permission denied" from stow | Conflicting real files | Remove the real file, re-stow |
| Secrets not loading | ~/.zshrc.secrets missing | Recreate it (keys are in your password manager) |
| Double PATH entries | Homebrew double-init | Fixed in loader — check `.zprofile` isn't also calling brew shellenv AND os-macos.zsh |

### After Validation Passes

```bash
# Commit the .zshrc replacement (repo copy is now the loader)
cd ~/dotfiles
git add zsh/.zshrc zsh/.zprofile zsh/.zshenv
git commit -m "Phase 6: Activate split config on primary MBP"
git push
```

Then merge to master when comfortable:
```bash
git checkout master
git merge feature/machine-profiles
git push
```

---

## Still TODO (not blocking Phase 6)

- **Rotate secrets**: Azure DevOps PAT and Lucid API key are in git history. Rotate them and update `~/.zshrc.secrets` on each machine.
- **Tailscale SSH**: Enable `sudo tailscale set --ssh` on ubuntu-mini so future management doesn't require VNC/remote desktop.
- **Other machines**: Personal i9 MBP (macOS desktop profile), Raspberry Pi (server profile), EC2 instances (server profile via bootstrap script).
- **Clean up**: Remove `bootstrap/fix.sh` (one-off), archive `pre-zsh/` directory if still present.
