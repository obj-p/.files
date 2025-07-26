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
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
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

### Install Homewbrew dependencies

```sh
cd ~ && brew bundle
```
