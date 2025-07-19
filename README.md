# .files

## First time setup

### GitHub SSH key

> [Generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
```

> Enter a file in which to save the key (/Users/YOU/.ssh/id\_ed25519):

```sh
github_ed25519
```

```sh
eval "$(ssh-agent -s)"
```

```sh
~/.ssh/config
```

```txt
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/github_ed25519
```

```sh
ssh-add --apple-use-keychain ~/.ssh/github_ed25519
```

> [Adding a new SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)


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

```sh
make links
```


