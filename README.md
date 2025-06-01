# 🚨 Snort + Telegram Bot Alert System

Hệ thống cảnh báo real-time khi phát hiện tấn công mạng thông qua Snort và gửi thông báo về Telegram Bot.

---

## Cài đặt & Sử dụng

```bash
# 1. Tạo thư mục lưu log cho Snort
mkdir -p /home/nhuthang/log-snort

# 2. Cấp quyền thực thi cho bot Telegram
cd /home/nhuthang/Snort-Bot-Telegram-Shell
chmod +x Telegram_NotifyBOT.sh

# 3. Mở 1 terminal để chạy Snort (để bắt gói)
sudo snort -A full -q -i ens33 -c /etc/snort/snort.conf -l /home/nhuthang/log-snort

# 4. Mở 1 terminal khác để chạy bot gửi cảnh báo
./Telegram_NotifyBOT.sh
# LƯU Ý: nhuthang phải thay bằng user mà bạn đang dùng ở máy của bạn.


w32tm /resync


export http_proxy=http://91.103.120.39:80
export https_proxy=http://91.103.120.39:80
curl -x http://91.103.120.39:80 https://api.telegram.org
Get-Service checkmk_agent
