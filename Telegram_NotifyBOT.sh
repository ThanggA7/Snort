#!/bin/bash

logs="/home/USER CUA BAN /log-snort/alert"
initCount=0
msg_caption="/tmp/telegram_msg_caption.txt"

chat_id="id user"
token="TOKEN BOT TELEGRAM"

function sendAlert {
    curl -s -F chat_id=$chat_id \
        -F parse_mode=Markdown \
        -F text="$caption" \
        "https://api.telegram.org/bot$token/sendMessage"
}

while true; do
    lastCount=$(wc -c "$logs" | awk '{print $1}')

    if (( lastCount > initCount )); then
        msg=$(tail -n 10 "$logs")

        alert=$(echo "$msg" | grep "\[\*\*\]" | head -n 1 | cut -d']' -f2- | xargs)
        time=$(echo "$msg" | grep -oE '^[0-9/:\-]+')
        src=$(echo "$msg" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:[0-9]+.*->' | head -n1 | awk '{print $1}')
        dst=$(echo "$msg" | grep -oE '-> [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:[0-9]+' | head -n1 | cut -d' ' -f2)
        payload=$(echo "$msg" | grep -A5 "$dst" | sed 's/^/    /')

        echo -e "🚨 *SNORT ALERT DETECTED* 🚨\n" > "$msg_caption"
        echo -e "*📅 Time:* \`$time\`" >> "$msg_caption"
        echo -e "*⚠️ Alert:* \`$alert\`" >> "$msg_caption"
        echo -e "\n*📦 Payload Info:*\n\`\`\`\n$payload\n\`\`\`" >> "$msg_caption"

        caption=$(<"$msg_caption")
        sendAlert

        echo "✅ Alert sent at $(date)"
        initCount=$lastCount
        rm -f "$msg_caption"
        sleep 1
    fi

    sleep 2
done
