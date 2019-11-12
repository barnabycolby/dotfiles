#!/bin/bash
# This script installs the dotfiles and other config contained in this
# repository. It should be run every time the repo is updated.

# Exit on error
set -e

# Gets the directory that this file is contained in
function get_script_directory {
	bash_source="${BASH_SOURCE[0]}"
	# resolve ${bash_source} until the file is no longer a symlink
	while [ -h "${bash_source}" ]; do
		dir="$( cd -P "$( dirname "${bash_source}" )" && pwd )"
		bash_source="$(readlink "${bash_source}")"

		# if ${bash_source} was a relative symlink, we need to resolve it relative
		# to the path where the symlink file was located
		[[ ${bash_source} != /* ]] && bash_source="$dir/${bash_source}"
	done
	dir="$( cd -P "$( dirname "${bash_source}" )" && pwd )"
	echo "${dir}"
}

# Creates a symlink. If the symlink already exists and points to the target
# location already, then nothing will be done. If the symlink already exists but
# points to a different location, the user will be prompted as to whether to
# replace the symlink.
#
# Arguments:
# - The target
# - The link name
function careful_symlink {
	target=${1}
	link_name=${2}

	if [ -L ${link_name} ]; then
		if [ "$(readlink ${link_name})" == "${target}" ]; then
          echo "${link_name} link already created"
		  return
		else
            echo "${link_name} link exists but has a different target ${target}"
			ln -is ${target} ${link_name}
		fi
	else
		if [ -e ${link_name} ]; then
            echo "${link_name} exists but is a file"
			ln -is ${target} ${link_name}
		else
            echo "Creating ${link_name} link"
			eval "ln --symbolic ${target} ${link_name}"
		fi
	fi
}

# Creates the symlinks required to install the config files
function create_symlinks {
	gitconf_dir=~/.gitconf
	vim_dir=~/.vim
	careful_symlink ${DOTFILE_REPO}/bashrc ~/.bashrc
	careful_symlink ${DOTFILE_REPO}/gitconf ${gitconf_dir}
	careful_symlink ${gitconf_dir}/gitconfig ~/.gitconfig
	careful_symlink ${gitconf_dir}/gitignore ~/.gitignore
	careful_symlink ${DOTFILE_REPO}/vim ${vim_dir}
	careful_symlink ${vim_dir}/vimrc ~/.vimrc
	careful_symlink ${DOTFILE_REPO}/tmux.conf ~/.tmux.conf
}

# Performs other non symlink vim configuration
function vim_specific_config {
	vim_dir=${DOTFILE_REPO}/vim
	mkdir -p ${vim_dir}/_backup
	mkdir -p ${vim_dir}/_swap
	mkdir -p ${vim_dir}/_undo

    # Install vim-plug if not already installed
		plug_file="${DOTFILE_REPO}/vim/autoload/plug.vim"
		if [ ! -f ${plug_file} ]; then
            echo "Downloading vim-plug"
            mkdir -p $(dirname ${plug_file})
			wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O ${plug_file}
		fi

    # Update the plugins
    echo "Updating vim plugins"
    vim -c 'PlugClean! | PlugUpgrade | PlugUpdate | qa'
}

function shell_theme_config {
    theme_dir=~/.config/base16-shell
    if [ ! -d "${theme_dir}" ]; then
        echo "Installing shell theme"
        git clone https://github.com/chriskempson/base16-shell.git ${theme_dir}
    else
        echo "Skipping shell theme install, it's already done."
    fi
}

DOTFILE_REPO="$(get_script_directory)"
create_symlinks
vim_specific_config
shell_theme_config
source ~/.bashrc
echo "Successfully configured dotfiles"
