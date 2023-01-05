# LightBot
Telegram bot for monitoring the router at home or at work.

![image](https://user-images.githubusercontent.com/61703153/210851172-862837fe-9b10-485e-b9be-cb45f48c7d13.png)

To use this bot, you need to specify the data from the api telegrams in the variable (bot_id, bot_key, , chat_id) and the public ip address (or DNS) in the variable (host_ip) of your equipment.

![image](https://user-images.githubusercontent.com/61703153/210851014-b2883196-8124-401f-9bef-04365cf4f280.png)

You can get data for bot_id, bot_key in https://t.me/BotFather, chat_id https://t.me/getmyid_bot

![image](https://user-images.githubusercontent.com/61703153/210850896-aa7e907c-fef2-4c04-b2c0-aca9cd84381a.png)

It is also necessary to register the launch of the script in crontab.
To do this, it will be enough to change the cron table with the crontab -e command and enter there

*/1 * * * * sh /home/ubuntu/TG_BOT/tg_bot.sh

![image](https://user-images.githubusercontent.com/61703153/210851639-d97177b5-cd8e-4ec5-834a-7e3f969257a7.png)

