#!/bin/bash
# Neovim installation script
echo '================================================'
echo '========== Neovim Installation script =========='
echo '================================================'
echo '(For GNU/Linux user only) Make sure that you have updated your distribution!'

set -e
echo ' '
echo '****** Step 1: Install neovim from the package manager *****'

if [ ! -x "$(command -v neovim)" ]; then
    PS3="Please select your package manager: "
    options=("pacman" "homebrew" "Quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "pacman")
                sudo pacman -S neovim
                break
                ;;
            "homebrew")
                brew install neovim
                break
                ;;
            "Quit")
                break
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
else
    echo "neovim already installed"
fi

echo ' '
echo '***** Step 2: Install vim-plug *****'
if [ ! -f '"${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim' ]; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
else
    echo 'vim-plug already installed'
fi

echo ' '
echo '***** Step 3: Install CoC *****'
echo '----- Step 3.1: Install nodejs >= 12.12'
if [ ! -x "$(command -v node)" ]; then
    case $opt in
        "pacman")
            curl -sL install-node.vercel.app/lts | bash
            break
            ;;
        "homebrew")
            brew install node
            break
            ;;
    esac
    export PATH="/usr/local/bin/:$PATH"
else
    echo 'nodejs already installed'
fi

echo '----- Step 3.2: Install CoC via automation script'
DIR1=~/.local/share/nvim/site/pack/coc/start
DIR2=~/.config/coc/extensions
if [ ! -d "$DIR1" ]; then
    mkdir -p $DIR1
    cd $DIR1
    curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -
fi
# Install extensions
if [ ! -d "$DIR2" ]; then
    mkdir -p $DIR2
    cd $DIR2
    if [ ! -f package.json ]
    then
      echo '{"dependencies":{}}'> package.json
    fi
    # Change extension names to the extensions you need
    npm install coc-prettier coc-eslint coc-go coc-pyright coc-rust-analyzer coc-html coc-tsserver --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
fi

echo ' '
echo '***** Step 4: Install neovim configuration *****'
read -p "Have you run the dotfiles(https://github.com/thomasoca/dotfiles) installer (y/n)?" choice
case "$choice" in 
  y|Y ) 
      echo "Installation complete, please open the neovim and run :PlugInstall"
      break  
      ;;
  n|N )
      echo "Copying neovim config..."
      mkdir ~/.config/nvim
      cp $PWD/.config/nvim/init.vim ~/.config/nvim/
      cp $PWD/.config/nvim/coc-settings.json ~/.config/nvim/
      echo "Installation complete, please open the neovim and run :PlugInstall"
      break
      ;;
  * ) echo "invalid";;
esac
echo 'closing installation script'
