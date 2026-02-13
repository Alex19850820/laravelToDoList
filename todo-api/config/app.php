<?php

return [

    'name' => env('APP_NAME', 'Laravel'),

    'env' => env('APP_ENV', 'production'),

    'debug' => (bool) env('APP_DEBUG', false),

    'url' => env('APP_URL', 'http://localhost'), // Исправлено: http://localhost

    'timezone' => 'UTC',

    'locale' => env('APP_LOCALE', 'ru'), // Берём из .env, по умолчанию — ru

    'fallback_locale' => env('APP_FALLBACK_LOCALE', 'en'), // Исправлено: APP_FALLBACK_LOCALE

    'faker_locale' => env('APP_FAKER_LOCALE', 'en_US'),

    // 'charset' => 'UTF-8', // Удалено: не используется в Laravel

    'cipher' => 'AES-256-CBC',

    'key' => env('APP_KEY'),

    'previous_keys' => [
        ...array_filter(
            explode(',', (string) env('APP_PREVIOUS_KEYS', ''))
        ),
    ],

    'maintenance' => [
        'driver' => env('APP_MAINTENANCE_DRIVER', 'file'),
        'store' => env('APP_MAINTENANCE_STORE', 'database'),
    ],

];
