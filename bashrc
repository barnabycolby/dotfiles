source ~/dotfiles/shellrc

# Drop into a fish shell. Because fish can't run normal posix shell scripts, this is a much easier way to change the interactive shell.
# To keep gnome happy, we need to make sure we only run fish in interactive shells.
case $- in
*i*) exec fish
    ;;
esac
