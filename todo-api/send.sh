#!/bin/bash

# Проверка: переданы ли 2 аргумента?
if [ $# -ne 2 ]; then
  echo "Ошибка: укажите заголовок и описание задачи."
  echo "Пример: ./send.sh 'Моя задача' 'Описание задачи'"
  exit 1
fi

TITLE="$1"
DESCRIPTION="$2"

# Безопасная замена через printf (не боится спецсимволов)
printf '{"title": "%s", "description": "%s", "status": "pending"}' \
  "$TITLE" "$DESCRIPTION" > task.json

# Отправка
curl -X POST http://localhost:8000/api/tasks \
  -H "Content-Type: application/json; charset=utf-8" \
  -H "Accept: application/json" \
  --data-binary @task.json
