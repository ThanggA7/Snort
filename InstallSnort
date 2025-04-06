sudo apt-get install -y build-essential
sudo apt-get install -y libpcap-dev libpcre3-dev libdumbnet-dev
sudo apt-get install -y bison flex
sudo apt-get install -y zlib1g-dev liblzma-dev openssl libssl-dev
sudo apt install libntirpc-dev

mkdir ~/snort_src
cd ~/snort_src
sudo wget https://www.snort.org/downloads/snort/daq-2.0.7.tar.gz
sudo tar -xvzf daq-2.0.7.tar.gz
cd daq-2.0.7
sudo ./configure
sudo make
sudo make install

cd ~/snort_src
wget https://www.snort.org/downloads/snort/snort-2.9.20.tar.gz
sudo tar -zxf snort-2.9.20.tar.gz
cd snort-2.9.20
sudo ./configure --enable-sourcefire --disable-open-appid
sudo apt install libntirpc-dev
sudo make CFLAGS=-I/usr/include/ntirpc
sudo make install
sudo ldconfig
sudo ln /usr/local/bin/snort /usr/sbin/snort

sudo mkdir /etc/snort
sudo mkdir /etc/snort/rules
sudo mkdir /etc/snort/rules/iplists
sudo mkdir /etc/snort/preproc_rules
sudo mkdir /usr/local/lib/snort_dynamicrules
sudo mkdir /etc/snort/so_rules

sudo touch /etc/snort/rules/iplists/black_list.rules
sudo touch /etc/snort/rules/iplists/white_list.rules
sudo touch /etc/snort/rules/local.rules
sudo touch /etc/snort/sid-msg.map

sudo mkdir /var/log/snort
sudo mkdir /var/log/snort/archived_logs

cd snort_src/snort-2.9.20/etc
sudo cp .conf /etc/snort
sudo cp *.map /etc/snort
sudo cp *.dtd /etc/snort
cd snort_src/snort-2.9.20/src/dynamic-preprocessors/build/usr/local/lib/snort_dynamicpreprocessor/
sudo cp * /usr/local/lib/snort_dynamicpreprocessor/
