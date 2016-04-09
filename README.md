# Telegram бот для сайта klops.ru

### Запуск бота:
`TELEGRAM_BOT_TOKEN=xxx SECRET=yyy ruby web.rb`

### Запуск сервиса, отвечающего за рассылку сообщений:
`TELEGRAM_BOT_TOKEN=xxx ruby bot.rb`

## Запустить все вместе:
`docker-compose start`

### Список комманд:
*  /start - начать общение с ботом
*  /help - список комманд
*  /news - список последних новостей
*  /popular - популярные новости за сутки
*  /subscribe - подписаться на важные новости (не более 3х за день)
*  /unsubscribe - отписать от новостей
*  /stop - закончить общение с ботом
