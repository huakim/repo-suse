# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples
if [[ `readlink /proc/$$/exe` == "/usr/bin/bash" ]]
then
. /etc/bash/profile
fi
. /etc/bash/bashrc
