#!/bin/bash

# Проверка: передан ли ID
if [ -z "$1" ]; then
  echo "Ошибка: не указан ID задачи."
  echo "Использование: $0 <ID_задачи>"
  exit 1
fi

TASK_ID="$1"

# Запрос к API (получаем одну задачу по ID)
response=$(curl -s "http://localhost:8000/api/tasks/$TASK_ID")

# Проверяем статус ответа
status=$(echo "$response" | jq -r '.status // empty')

if [ "$status" = "404" ]; then
  echo "Задача с ID=$TASK_ID не найдена."
  exit 1
elif [ -z "$response" ]; then
  echo "Ошибка: пустой ответ от сервера."
  exit 1
fi

# Декодируем Unicode и выводим результат
echo "$response" | perl -C -pe '
  s/\\u([0-9a-fA-F]{4})/chr(hex($1))/eg;
  s/\\\\/\\/g;
' 2>/dev/null || echo "$response"
