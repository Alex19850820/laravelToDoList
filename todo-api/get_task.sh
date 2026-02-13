#!/bin/bash


# Получаем JSON с сервера
response=$(curl -s http://localhost:8000/api/tasks)

# Декодируем Unicode-эскейпы через Perl (встроен в Git Bash)
echo "$response" | perl -C -pe '
  s/\\u([0-9a-fA-F]{4})/chr(hex($1))/eg;
  s/\\\\/\\/g;
' 2>/dev/null || echo "$response"