#!/usr/bin/env bash
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

set -eo

. /etc/os-release
if [[ ${ID} == "rhel" ]] || [[ ${ID} == "centos" ]]; then
  dnf -y install https://www.rdoproject.org/repos/rdo-release.el8.rpm
  PACKAGES="git python3 python3-tenacity python3-tabulate python3-zmq python3-pyyaml python3-jinja2 zeromq libsodium"
  dnf -y install ${PACKAGES}
elif [[ ${ID} == "fedora" ]]; then
  PACKAGES="git python3 python3-ssh2-python python3-tenacity python3-tabulate python3-zmq python3-pyyaml python3-jinja2 zeromq libsodium python3-diskcache"
  dnf -y install ${PACKAGES}
elif [[ ${ID} == "ubuntu" ]]; then
  PACKAGES="git python3-all python3-venv python3-tabulate python3-zmq python3-yaml python3-jinja2"
  apt update
  apt -y install ${PACKAGES}
else
  echo -e "Failed unknown OS"
  exit 99
fi

python3 -m venv --system-site-packages /opt/directord
/opt/directord/bin/pip install --upgrade pip setuptools wheel
/opt/directord/bin/pip install directord

echo -e "\nDirectord is setup and installed within [ /opt/directord ]"
echo "Activate the venv or run directord directly."
echo "Directord can be installed as a service using the following command(s):"
echo "/opt/directord/bin/directord-client-systemd"
echo -e "/opt/directord/bin/directord-server-systemd\n"
