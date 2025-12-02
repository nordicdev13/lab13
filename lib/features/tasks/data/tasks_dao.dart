import 'package:sqflite/sqflite.dart';
import '../../../core/database/app_database.dart';
import 'tasks_model.dart';

class TasksDao {
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<int> insertTask(TaskModel task) async {
    final db = await _db;
    return await db.insert('tasks', task.toMap());
  }

  Future<List<TaskModel>> getAllTasks() async {
    final db = await _db;
    final result = await db.query('tasks', orderBy: 'date DESC');
    return result.map((json) => TaskModel.fromMap(json)).toList();
  }
}