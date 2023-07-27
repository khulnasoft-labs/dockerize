pkgrelease=$1

if [ -z "$pkgrelease" ]; then
  echo "usage: ./verify-rpm-init <pkgrelease>" >&2
  exit 1
fi

set -e

case "$pkgrelease" in
  centos7)
    yum install -y findutils epel-release
    ;;
  centos8)
    [ -f /etc/yum.repos.d/CentOS-Stream-PowerTools.repo ] && sed -i 's/enabled=0/enabled=1/g' /etc/yum.repos.d/CentOS-Stream-PowerTools.repo
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
    dnf install -y findutils dnf-plugins-core epel-release epel-next-release
    ;;
  centos9)
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
    dnf install -y findutils dnf-plugins-core epel-release epel-next-release
    dnf config-manager --set-enabled crb
    ;;
  oraclelinux7)
    yum install -y findutils oraclelinux-release-el7 oracle-epel-release-el7
    yum-config-manager --enable ol7_addons ol7_latest ol7_optional_latest
    ;;
  oraclelinux8)
    dnf install -y findutils dnf-plugins-core oraclelinux-release-el8 oracle-epel-release-el8
    dnf config-manager --enable ol8_addons ol8_codeready_builder
    ;;
  oraclelinux9)
    dnf install -y findutils dnf-plugins-core oraclelinux-release-el9 oracle-epel-release-el9
    dnf config-manager --enable ol9_addons ol9_codeready_builder
    ;;
  fedora*)
    dnf install -y findutils dnf-plugins-core
    ;;
esac
