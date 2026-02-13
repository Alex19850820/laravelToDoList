#!/bin/bash

echo "Получение всех задач..."


# Запрос ко всем задачам
response=$(curl -s "http://localhost:8000/api/tasks")


# Проверяем, что ответ не пустой
if [ -z "$response" ]; then
  echo "Ошибка: пустой ответ от сервера. Проверьте:"
  echo "  - работает ли сервер (localhost:8000)"
  echo "  - доступен ли эндпоинт /api/tasks"
  exit 1
fi

# Декодируем Unicode-эскейпы и выводим результат
echo "$response" | perl -C -pe '
  s/\\u([0-9a-fA-F]{4})/chr(hex($1))/eg;
  s/\\\\/\\/g;
' 2>/dev/null || echo "$response"
