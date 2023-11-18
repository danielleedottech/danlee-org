# Installing Ruby 3.2.2 on Fedora 39

## install RBenv

### clone the repo
cd ~
git clone https://github.com/rbenv/rbenv.git ~/.rbenv

#### add load script to ~/.bashrc and re-source shell

```
echo '' >> ~/.bashrc
echo '# adding rbenv load script' >> ~/.bashrc
echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc
source ~/.bashrc
```

## download ruby build plugin

(make sure you run these instructions in the same terminal tab/window that you `source ~/.bashrc` with rbenv loaded.)

```
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
```

### install needed dependencies for compiling ruby

```
sudo dnf update -y
sudo dnf install make automake gcc gcc-c++ kernel-devel libyaml-devel -y
```

## finally install ruby 3.2.2

```
rbenv install 3.2.2
rbenv global 3.2.2
```

## Sources and Acknowledgements

- understanding how to fix `missing libffi. Please install libffi or use --with-libffi-source-dir with libffi source location` error
  - https://github.com/rbenv/ruby-build/discussions/2168
- instructions for rbenv installation
  - https://github.com/rbenv/rbenv#readme
- instructions for ruby-build installation
  - https://github.com/rbenv/ruby-build#readme
- understanding how to fix bundle install errors for common gems like `sassc` and `eventmachine`
  - https://github.com/eventmachine/eventmachine/issues/517#issuecomment-56255401
