
#!/bin/bash

# Проверка: переданы ли 3 аргумента? (ID, title, status)
if [ $# -ne 3 ]; then
  echo "Ошибка: укажите ID задачи, новый заголовок и статус."
  echo "Пример: ./update_task.sh 1 'Обновлённое название' 'completed'"
  exit 1
fi

TASK_ID="$1"
NEW_TITLE="$2"
NEW_STATUS="$3"

# Безопасная сборка JSON через printf (защищает от спецсимволов)
printf '{"title": "%s", "status": "%s"}' \
  "$NEW_TITLE" "$NEW_STATUS" > update.json

# Отправка PUT-запроса
curl -X PUT http://localhost:8000/api/tasks/"$TASK_ID" \
  -H "Content-Type: application/json; charset=utf-8" \
  -H "Accept: application/json" \
  --data-binary @update.json