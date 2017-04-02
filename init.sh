#!/bin/bash
# This script installs the dotfiles and other config contained in this
# repository. It should be run every time the repo is updated.

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

DOTFILE_REPO="$(get_script_directory)"

# Symlink the bash dotfile
ln -is ${DOTFILE_REPO}/bashrc ~/.bashrc
