#!/bin/bash

# Prepare the .git credentials beforehand so that token/password does not need to be passed again
# 1. ssh-keygen -t ed25519 -C "barunps3@gmail.com" -f ~/.ssh/id_ed25519_personal
# 2. Add the public key in ~/.ssh to Github
# 3. create/append to ~/.ssh/config
# Host github-personal
#    HostName github.com
#    User git
#    IdentityFile ~/.ssh/id_ed25519_personal
#    IdentitiesOnly yes
#    AddKeysToAgent yes
#    UseKeychain yes
# 4. Add the ssh key with password saved to keychaing:
# ssh-add --apple-use-keychain ~/.ssh/id_ed25519_personal
# For Ubuntu
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_ed25519_personal
# 5. ssh-add -l
# 6. ssh -T git@github-personal
# 7. cd initconfig
# 8. git remote -v
# 9. git remote set-url origin git@github-personal:barunps3/initconfig.git
# 10. git pull
#

CONFIG="$HOME/.config/initconfig"
if [ -d "$CONFIG/.git" ];then
    echo "[INFO] pulling nvim changes"
    git -C "$CONFIG" pull --ff-only
    cp -r $CONFIG/nvim/* "$HOME/.config/nvim/"
else
    echo "[WARNING] failed to find initconfig directory in $CONFIG"
fi

#  Remove our wrapper from PATH
WRAPPER_DIR="$HOME/.local/bin"
OLD_PATH="$PATH"
PATH="$(echo "$PATH" | tr ':' '\n' | grep -v "^$WRAPPER_DIR$" | paste -sd ':' -)"
export PATH

# Find the actual Neovim executable
NVIM="$(command -v nvim)"
echo "[INFO] Original path of nvim: $NVIM"

# Restore PATH
PATH="$OLD_PATH"
export PATH

if [ -z "$NVIM" ]; then
    echo "Error: could not find real nvim" >&2
    exit 1
fi

echo "[INFO] Starting $NVIM"
exec "$NVIM" "$@"
