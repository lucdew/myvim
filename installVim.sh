#!/bin/sh


SCRIPTS_DIR="$( cd "$( dirname "$0" )" && pwd )"

OS=`uname -s | cut -c1-6`
if [ "$OS" = "CYGWIN" ]; then
    OS="WIN"
    HOMEDIR=`cygpath $USERPROFILE`
    VIMDIR=$HOMEDIR/vimfiles
else 
    OS="LINUX"
    HOMEDIR=$HOME
    VIMDIR=$HOME/.vim
fi


if [ -d "${VIMDIR}" ] ; then
   read -p "Vim directory already exists, erase (Y/n)?" yn
   case $yn in
        [Yy]*) rm -rf "${VIMDIR}" ;;
        [Nn]* ) echo "exiting" && exit;;
        *) echo "Invalid choice" && exit;;
    esac

fi
mkdir -p $VIMDIR/autoload
mkdir  $VIMDIR/bundle
mkdir  $VIMDIR/colors

cp -R $SCRIPTS_DIR/vimfiles/colors/* $VIMDIR/colors 


BUNDLEDIR=$VIMDIR/bundle

#git submodule add https://github.com/gmarik/Vundle.vim.git $BUNDLEDIR/Vundle.vim
cd $BUNDLEDIR
git clone --depth 1 https://github.com/gmarik/Vundle.vim.git Vundle.vim

if [ "WIN" = "$OS" ] ; then
    cp "$SCRIPTS_DIR/_vimrc" $HOMEDIR/_vimrc
    cp "$SCRIPTS_DIR/_gvimrc" $HOMEDIR/_gvimrc
    echo "To finish installation, start vim and enter the following command\n"
    echo ":PluginInstall"
else
    cp "$SCRIPTS_DIR/_vimrc" $HOMEDIR/.vimrc
    cp "$SCRIPTS_DIR/_gvimrc" $HOMEDIR/.gvimrc
    vim +PluginInstall +qall
fi
