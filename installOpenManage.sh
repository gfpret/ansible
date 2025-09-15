apt update
# This is up to you if you would like to apply all updates
apt upgrade
# These are the extra dependencies I needed
# You can see if you are successful without them
apt install gnupg libcurl4 libncurses5 libxslt1-dev libgpm2 libtinfo5

# Downloads the signature Key from Dell and adds the key to the source file
mkdir -p /etc/apt/keyrings
keyring=/etc/apt/keyrings/linux.dell.com.gpg
wget -qO - https://linux.dell.com/repo/pgp_pubkeys/0x1285491434D8786F.asc | gpg --dearmor -o $keyring
chmod +r $keyring
echo "deb [signed-by=$keyring] http://linux.dell.com/repo/community/openmanage/10300/focal focal main" > /etc/apt/sources.list.d/linux.dell.com.list

# Do a repo update to get OpenManage repos
apt update

# This will download all the needed packages
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/o/openwsman/libwsman-curl-client-transport1_2.6.5-0ubuntu8_amd64.deb
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/o/openwsman/libwsman-client4_2.6.5-0ubuntu8_amd64.deb
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/o/openwsman/libwsman1_2.6.5-0ubuntu8_amd64.deb
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/o/openwsman/libwsman-server1_2.6.5-0ubuntu8_amd64.deb
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/s/sblim-sfcc/libcimcclient0_2.2.8-0ubuntu2_amd64.deb
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/o/openwsman/openwsman_2.6.5-0ubuntu8_amd64.deb
wget -c http://archive.ubuntu.com/ubuntu/pool/multiverse/c/cim-schema/cim-schema_2.48.0-0ubuntu1_all.deb
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/s/sblim-sfc-common/libsfcutil0_1.0.1-0ubuntu4_amd64.deb
wget -c http://archive.ubuntu.com/ubuntu/pool/multiverse/s/sblim-sfcb/sfcb_1.4.9-0ubuntu7_amd64.deb
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/s/sblim-cmpi-devel/libcmpicppimpl0_2.0.3-0ubuntu2_amd64.deb
wget -c http://ftp.us.debian.org/debian/pool/main/o/openssl/libssl1.1_1.1.1w-0+deb11u1_amd64.deb

# and install them if not already installed
dpkg -i libwsman-curl-client-transport1_2.6.5-0ubuntu8_amd64.deb
dpkg -i libwsman-client4_2.6.5-0ubuntu8_amd64.deb
dpkg -i libwsman1_2.6.5-0ubuntu8_amd64.deb
dpkg -i libwsman-server1_2.6.5-0ubuntu8_amd64.deb
dpkg -i libcimcclient0_2.2.8-0ubuntu2_amd64.deb
dpkg -i openwsman_2.6.5-0ubuntu8_amd64.deb
dpkg -i cim-schema_2.48.0-0ubuntu1_all.deb
dpkg -i libsfcutil0_1.0.1-0ubuntu4_amd64.deb
dpkg -i sfcb_1.4.9-0ubuntu7_amd64.deb
dpkg -i libcmpicppimpl0_2.0.3-0ubuntu2_amd64.deb
dpkg -i libssl1.1_1.1.1w-0+deb11u1_amd64.deb

# Now we can install OpenManage
apt-get install srvadmin-all

# This will start the OpenManage Services
/opt/dell/srvadmin/sbin/srvadmin-services.sh start
