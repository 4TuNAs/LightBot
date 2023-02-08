#!/bin/sh

#Telegram API credentials. For example 123234234234:Abc_SeDa3dafa_sadwFnxT_qio on https://t.me/BotFather chat_id https://t.me/getmyid_bot
bot_id="123234234234"
bot_key="Abc_SeDa3dafa_sadwFnxT_qio"
chat_id="-123456789123"

#Monitoring host_ip. Write you ip there
host_ip="example.com"

#Local img files
Lamp_on_img="/home/ubuntu/TG_BOT/OnLamp.png"
Lamp_off_img="/home/ubuntu/TG_BOT/OffLamp.png"


#Previously state of packet lost
packet_prev=`cat /home/ubuntu/TG_BOT/watch.txt`

#Ping check
packet=$(ping -c 10 "$host_ip" | grep "packet loss" | awk -F ',' '{print $3}' | awk '{print $1}' | awk -F '%' '{print $1}')


date=$(date '+%s')

#TG_Sender_Power_ON
power_on() {
                curl -s -X POST https://api.telegram.org/bot"$bot_id":"$bot_key"/sendPhoto -F chat_id="$chat_id" -F photo="@$Lamp_on_img" > /dev/null
                curl -s -X POST https://api.telegram.org/bot"$bot_id":"$bot_key"/sendMessage -d chat_id="$chat_id" -d text=" 🟢 Ввімкнули світло 🟢 %0A Час без світла складав $day_diff днів $time_count годин" > /dev/null
}

#TG_Sender_Power_OFF
power_off() {
                curl -s -X POST https://api.telegram.org/bot"$bot_id":"$bot_key"/sendPhoto -F chat_id="$chat_id" -F photo="@$Lamp_off_img" > /dev/null
                curl -s -X POST https://api.telegram.org/bot"$bot_id":"$bot_key"/sendMessage -d chat_id="$chat_id" -d  text=" ⚫  Вимкнули світло  ⚫ %0A Час зі світлом складав $day_diff днів $time_count годин" > /dev/null
}

#Time_differense function   (time differense = time now - time previously check)
date_state() {
        date_prev=`cat /home/ubuntu/TG_BOT/date.txt`
        echo $date > /home/ubuntu/TG_BOT/date.txt
        date_diff=`expr $date - $date_prev`
        time_count=`date -u -d @${date_diff} +"%T"`
        day_count=`date -u -d @${date_diff} +"%d"`
        day_diff=`expr $day_count - 1`
}

#Check if packet lost differense, for send only one message if state changed. if packetlost = 100 > poweroff / if packetlost = 0 > poweron 
if [ "$packet" != "$packet_prev" ] ; then
echo $packet > /home/ubuntu/TG_BOT/watch.txt
        if [ "$packet" = "0" ] ; then
                if [ "$packet" = "0" ] ; then
                if [ "$packet_prev" -gt "90" ] ; then
                        date_state
                        power_on
                else
                        echo "fail" > /dev/null
                fi

        elif [ "$packet" = "100" ] ; then
                date_state
                power_off
 	elif [ "$packet" = "+10" ] ; then
                date_state
                power_off
        fi
else
        echo $packet > /home/ubuntu/TG_BOT/watch.txt
fi