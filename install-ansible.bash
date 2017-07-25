#!/usr/bin/env bash
# @tanakapayam
#
# This macOS BASH script installs Ansible, after installing Homebrew and PyPy


# Die on error
set -o errexit
set -o pipefail


# Universal style and functions
. files/style.bash
. files/functions.bash


# Global variables
PROGRAM_NAME=$(basename "$0")


if [[ $1 != '-f' || $(uname -s) != 'Darwin' ]]; then
    cat << EOF
${BOLD}NAME${RESET}
        ${PROGRAM_NAME} - install Ansible, http://docs.ansible.com/ansible/list_of_all_modules.html

${BOLD}SYNOPSIS${RESET}
        ${BOLD}${PROGRAM_NAME} -f${RESET}

${BOLD}DESCRIPTION${RESET}
        This macOS BASH script does the following:

        * Creates directories and fixes ownership as needed
        * Using Ruby and Curl, installs:
           * Homebrew, https://brew.sh
        * Using Homebrew, installs:
           * BASH, http://tldp.org/LDP/abs/html/part4.html
           * PyPy, https://pypy.org
        * Using PyPy PIP, installs:
           * Ansible, http://docs.ansible.com/ansible/
        * Using Ansible, run playbook to initialize /etc/ansible/hosts and make
          Sudo passwordless for ansible:
           * initialize-ansible.yml
              * gmake, https://www.gnu.org/software/make/manual/make.html
              * jq, https://stedolan.github.io/jq/tutorial/
              * yamllint, https://github.com/adrienverge/yamllint
              * yq, https://github.com/abesto/yq

EOF

    exit 0
fi


echo "${BOLD}# Installing Ansible${RESET}"
echo


echo "${BOLD}## Creating directories and fixing ownership as needed${RESET}"
echo

sudo mkdir -p \
    /usr/local/var/homebrew \
    /usr/local/Homebrew \
    /usr/local/share/zsh

sudo chown -R \
    $(whoami):admin \
    /usr/local/{var,Homebrew} \
    /usr/local/share/zsh


echo "${BOLD}## Ruby installing ${YELLOW}Homebrew${RESET}"
echo

yes \
    | /usr/bin/ruby \
        -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
    || true

echo

git -C "$(brew --repo homebrew/core)" fetch --unshallow \
    || true

echo


echo "${BOLD}## Brew installing ${YELLOW}BASH${RESET}"
echo

brew install bash

echo


echo "${BOLD}## Brew installing ${YELLOW}PyPy${RESET}"
echo

brew install pypy

echo


echo "${BOLD}## Pip (PyPy) installing Cryptography, a prerequisite, and ${YELLOW}Ansible${RESET}"
echo

echo "${BOLD}* Cryptography${RESET}"
echo

sudo -H \
    pip_pypy install \
        cryptography \
        --global-option=build_ext \
        --global-option="-L/usr/local/opt/openssl/lib" \
        --global-option="-I/usr/local/opt/openssl/include"

echo

echo "${BOLD}* Ansible${RESET}"
echo

sudo -H \
    pip_pypy install ansible \
    || brew install ansible

echo


echo "${BOLD}## Initialize ${YELLOW}Ansible${RESET}"
echo

export PATH=/usr/local/share/pypy:$PATH
sudo -H \
    ansible-playbook -vv initialize-ansible-1.yml

echo

ansible-playbook -vv initialize-ansible-2.yml

echo


the_end
