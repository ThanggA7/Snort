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


https://discord.com/api/webhooks/1377867021110349875/NAeWYT8zoPj9h3Ax5qo2_fFuQAoL3l9WRmkP_Tca3IwrJxyjFXM_ACjnEdG9JWrILris
