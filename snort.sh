#!/bin/bash

echo "=== CẬP NHẬT HỆ THỐNG ==="
sudo apt update && sudo apt upgrade -y

echo "=== CÀI GÓI PHỤ THUỘC ==="
sudo apt install -y build-essential libpcap-dev libpcre3-dev libdumbnet-dev bison flex zlib1g-dev liblzma-dev openssl libssl-dev libnghttp2-dev libdnet autoconf libtool git

echo "=== CÀI DAQ (Data Acquisition library) ==="
cd /tmp
git clone https://github.com/snort3/libdaq.git
cd libdaq
./bootstrap
./configure
make
sudo make install

echo "=== TẢI SNORT SOURCE CODE ==="
cd /tmp
wget https://www.snort.org/downloads/snort/snort-2.9.20.tar.gz -O snort.tar.gz
tar -xvzf snort.tar.gz
cd snort-2.9.20

echo "=== CÀI SNORT ==="
./configure --enable-sourcefire
make
sudo make install

echo "=== TẠO THƯ MỤC CẤU HÌNH SNORT ==="
sudo mkdir -p /etc/snort/rules
sudo mkdir /etc/snort/preproc_rules
sudo mkdir /var/log/snort
sudo mkdir /usr/local/lib/snort_dynamicrules
sudo touch /etc/snort/rules/local.rules
sudo touch /etc/snort/snort.conf

echo "=== THÊM NGƯỜI DÙNG SNORT ==="
sudo groupadd snort
sudo useradd snort -r -s /sbin/nologin -c SNORT_IDS -g snort

sudo chown -R snort:snort /var/log/snort

echo "=== TẠO FILE snort.conf CƠ BẢN ==="
cat <<EOF | sudo tee /etc/snort/snort.conf > /dev/null
ipvar HOME_NET any
ipvar EXTERNAL_NET any

var RULE_PATH /etc/snort/rules

include \$RULE_PATH/local.rules

output alert_fast: stdout
EOF

echo "=== VIẾT RULE TEST ==="
cat <<EOF | sudo tee /etc/snort/rules/local.rules > /dev/null
alert icmp any any -> any any (msg:"ICMP test detected"; sid:1000001; rev:1;)
EOF

echo "=== TẠO LINK SNORT ==="
sudo ln -s /usr/local/bin/snort /usr/sbin/snort

echo "=== KIỂM TRA CẤU HÌNH SNORT ==="
/usr/local/bin/snort -T -c /etc/snort/snort.conf

echo "=== CÀI SNORT HOÀN TẤT ==="
echo "Bạn có thể chạy Snort với lệnh:"
echo "sudo snort -A console -q -c /etc/snort/snort.conf -i eth0"
