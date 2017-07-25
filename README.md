# install-ansible
macOS: Install Homebrew, BASH, PyPy, Ansible

## NAME
install-ansible.bash - install Ansible, [list_of_all_modules.html](http://docs.ansible.com/ansible/list_of_all_modules.html)

## SYNOPSIS
    install-ansible.bash -f

## DESCRIPTION
This macOS BASH script does the following:

* Creates directories and fixes ownership as needed
* Using Ruby and Curl, installs:
   * [Homebrew](https://brew.sh)
* Using Homebrew, installs:
   * [BASH](http://tldp.org/LDP/abs/html/part4.html)
   * [PyPy](https://pypy.org)
* Using PyPy PIP, installs:
   * [Ansible](http://docs.ansible.com/ansible/)
* Using Ansible, run playbook to initialize `/etc/ansible/hosts` and make
  **Sudo** *passwordless* for ansible:
   * `initialize-ansible.yml`
      * [gmake](https://www.gnu.org/software/make/manual/make.html)
      * [jq](https://stedolan.github.io/jq/tutorial/)
      * [yamllint](https://github.com/adrienverge/yamllint)
      * [yq](https://github.com/abesto/yq)
