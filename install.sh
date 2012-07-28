realpath() {
    echo "$1" || echo "$PWD/${1#./}"
}

# Get current script path
SCRIPT_PATH=`realpath $0`
DOTFILES=`dirname $SCRIPT_PATH`

# Backup files to later restore
mkdir -p "$DOTFILES/original"
test -e ~/.bashrc && cp -f ~/.bashrc "$DOTFILES/original" 
test -e ~/.vimrc && cp -f ~/.vimrc "$DOTFILES/original"
test -e ~/.git-completion.bash && cp -f ~/.git-completion.bash "$DOTFILES/original"
test -e ~/.gitconfig && cp -f ~/.gitconfig "$DOTFILES/original"
test -e ~/.gitignore && cp -f ~/.gitignore "$DOTFILES/original"

echo "Backup of the original files from ~ to $DOTFILES/original:"
ls -a $DOTFILES/original

# Move files
cp -f "$DOTFILES/.bashrc" "$DOTFILES/.vimrc" "$DOTFILES/.screenrc" "$DOTFILES/.git-completion.bash" "$DOTFILES/.gitconfig" "$DOTFILES/.gitignore" ~/

echo "\nCopied dotfiles to ~"
echo "$DOTFILES/.bashrc" "$DOTFILES/.vimrc" "$DOTFILES/.screenrc" "$DOTFILES/.git-completion.bash" "$DOTFILES/.gitconfig" "$DOTFILES/.gitignore"
