#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Ошибка: укажите ID задачи."
  echo "Пример: ./delete_task.sh 1"
  exit 1
fi

TASK_ID="$1"

echo "Проверка существования задачи с ID=$TASK_ID..."
# Проверка существования (GET)
exists=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8000/api/tasks/"$TASK_ID")


if [ "$exists" -ne 200 ]; then
  echo "Задача с ID=$TASK_ID не найдена (статус $exists)"
  exit 1
fi

echo "Задача существует. Попытка удаления..."


# Один запрос: DELETE с заголовками + захват статуса и ответа
response=$(curl -s -X DELETE http://localhost:8000/api/tasks/"$TASK_ID" \
  -H "Content-Type: application/json; charset=utf-8" \
  -H "Accept: application/json" \
  -w "\nSTATUS:%{http_code}" \
  -o /tmp/curl_output.txt)

# Извлекаем статус из последней строки ответа
status=$(echo "$response" | tail -1 | cut -d':' -f2)
# Оставляем только тело ответа (всё, кроме последней строки)
body=$(echo "$response" | head -n -1)

if [ "$status" -eq 200 ] || [ "$status" -eq 204 ]; then
  message=$(echo "$body" | jq -r '.message' 2>/dev/null || echo "Задача удалена")
  echo "Успешно: $message (статус $status)"
else
  echo "Ошибка при удалении (статус $status)"
  echo "Ответ сервера: $body"
fi

# Очищаем временный файл
rm -f /tmp/curl_output.txt
