# .files

## First time setup

### GitHub SSH key

This is likely the first repository that will be cloned to a new machine. To setup GitHub
credentials follow along.

> [Generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
```

> Enter a file in which to save the key (/Users/YOU/.ssh/id\_ed25519):

```sh
github_ed25519
```

Start the `ssh-agent`.


```sh
eval "$(ssh-agent -s)"
```

Create an SSH config that references the generated key.


```sh
vim ~/.ssh/config
```

Paste the following.


```txt
Host *
  AddKeysToAgent yes
  UseKeychain yes

Host github.com
  IdentityFile ~/.ssh/github_ed25519
```

Add the private key to the keychain.


```sh
ssh-add --apple-use-keychain ~/.ssh/github_ed25519
```

> [Adding a new SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

Copy and paste the following into the GitHub settings.


```sh
pbcopy < ~/.ssh/github_ed25519.pub
```

### Homebrew

> https://brew.sh

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### .files

```sh
git clone git@github.com:obj-p/.files.git
```

To create symlinks for the dotfiles.

```sh
make links
```

On the Mac mini, pass the profile once. It is saved to `~/.config/.files/profile`
and later runs pick it up without the flag.

```sh
PROFILE=mini make links
```

### Codex

Install Codex CLI and disable anonymous usage metrics and terminal animations
with `make codex`. To apply only the config changes, run `make codex-config`.
This requires Python 3.11 or newer and uses `CODEX_HOME/config.toml` when
`CODEX_HOME` is set, otherwise `~/.codex/config.toml`.
Existing settings are preserved. Restart Codex after changing the config.
If the script cannot safely edit the TOML layout, it leaves the file unchanged.

### Install Homewbrew dependencies

```sh
cd ~ && brew bundle
```
