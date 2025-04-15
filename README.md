# Snort + Rules
#asdsad


# Proxy cho CheckMK
ProxyPass /check_mk http://localhost:5000/mysite/check_mk/
ProxyPassReverse /check_mk http://localhost:5000/mysite/check_mk/

# Cho phép truy cập giao diện qua / (tùy chọn)
ProxyPass / http://localhost:5000/mysite/
ProxyPassReverse / http://localhost:5000/mysite/
