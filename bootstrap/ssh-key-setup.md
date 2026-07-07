# SSH Key Setup for New Machines

Run these steps on any new machine to get GitHub access.

## 1. Generate the key

```bash
ssh-keygen -t ed25519 -C "drpoindexter@gmail.com"
```

- Press Enter to accept the default path (`~/.ssh/id_ed25519`)
- Enter a passphrase (recommended) or press Enter for none

## 2. Start the SSH agent and add the key

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

## 3. Copy the public key

```bash
cat ~/.ssh/id_ed25519.pub
```

Copy the entire output (starts with `ssh-ed25519`, ends with your email).

## 4. Add to GitHub

1. Go to: https://github.com/settings/keys
2. Click **New SSH Key**
3. Title: name of the machine (e.g., "Mac Mini Ubuntu", "Pi4", "EC2 dev")
4. Paste the public key
5. Click **Add SSH Key**

## 5. Verify

```bash
ssh -T git@github.com
```

Expected output:
```
Hi mtheoryx! You've successfully authenticated, but GitHub does not provide shell access.
```

## 6. Done — clone the dotfiles

```bash
git clone -b feature/machine-profiles git@github.com:mtheoryx/dotfiles.git ~/dotfiles
```
