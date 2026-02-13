<?php

namespace App\Http\Controllers;

use App\Models\Task;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class TaskController extends Controller
{
    // Получение всех задач
    public function index()
    {
        return response()->json(Task::all());
    }

    // Создание новой задачи
   public function store(Request $request)
    {
        // Логируем ВСЕ данные запроса
         // 1. Записываем факт входа в метод
        \Log::info('=== STORE METHOD CALLED ===');

        // 2. Пытаемся получить JSON напрямую
        $json = json_decode($request->getContent(), true);
        \Log::info('RAW JSON PAYLOAD:', ['data' => $json]);

        // 3. Логируем заголовки
        \Log::info('REQUEST HEADERS:', $request->headers->all());

        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'status' => 'nullable|in:pending,in_progress,completed'
        ]);

        $task = Task::create($request->all());
        return response()->json($task, 201);
    }

    // Получение одной задачи
    public function show($id)
    {
        $task = Task::findOrFail($id);
        return response()->json($task);
    }

    // Обновление задачи
    public function update(Request $request, $id)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'status' => 'nullable|in:pending,in_progress,completed'
        ]);

        $task = Task::findOrFail($id);
        $task->update($request->all());
        return response()->json($task);
    }

    // Удаление задачи
    public function destroy($id)
    {
        $task = Task::findOrFail($id);
        $task->delete();
        return response()->json(['message' => 'Task deleted'], 204);
    }
}

