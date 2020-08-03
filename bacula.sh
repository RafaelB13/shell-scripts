dnf update -y
dnf install epel-release -y
SELINUX=disabled
systemctl disable firewalld
dnf install vim make gcc gcc-c++ openssl-devel perl \
mc mtx readline-devel lzop lzo lzo-devel zlib-devel \
sudo gawk gdb libacl-devel lsscsi drpm wget -y
dnf install mariadb-server mariadb-devel mariadb-server-utils mariadb-embedded -y
systemctl enable mariadb.service
systemctl start mariadb.service
wget --no-check-certificate https://sourceforge.net/projects/bacula/files/bacula/9.4.4/bacula-9.4.4.tar.gz
yum install tar -y
tar xvzf bacula-9.4.4.tar.gz
cd bacula-9.4.4
./configure --enable-smartalloc --with-mysql --with-db-user=root --with-db-password= --with-db-port=3306 --with-openssl --with-readline=/usr/include/readline --sysconfdir=/etc/bacula --bindir=/usr/bin --sbindir=/usr/sbin --with-scriptdir=/etc/bacula/scripts --with-plugindir=/etc/bacula/plugins --with-pid-dir=/var/run --with-subsys-dir=/etc/bacula/working --with-working-dir=/etc/bacula/working --with-bsrdir=/etc/bacula/bootstrap --with-systemd --disable-conio --disable-nls --with-logdir=/var/log/bacula
make -j 8
make -j install
make install-autostart
cd /etc/bacula/scripts
./create_mysql_database -u root -p
./make_mysql_tables -u root -p
./grant_mysql_privileges -u root -p
bacula start

