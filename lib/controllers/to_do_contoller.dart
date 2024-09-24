import 'package:hive/hive.dart';
import 'package:todo_list_app_db/models/task_model.dart';
import 'package:todo_list_app_db/models/tasks_time.dart';

class ToDoController {
  static final Box<TasksTime> tasksTimeBox = Hive.box<TasksTime>('tasksTime');
  static final Box<TaskModel> taskBox = Hive.box<TaskModel>('tasks');

  static List<TasksTime> get tasksTimes => tasksTimeBox.values.toList();

  static void addTaskTime(TasksTime taskTime) {
    tasksTimeBox.add(taskTime);
  }

  static void assignTaskToTime(int tasksTimeId, TaskModel task) {
    final tasksTime = tasksTimeBox.get(tasksTimeId);
    if (tasksTime != null) {
      tasksTime.addTask(task);
      tasksTime.save();
    }
  }

  static void updateTask(int tasksTimeId, TaskModel task) {
    final tasksTime = tasksTimeBox.get(tasksTimeId);
    if (tasksTime != null) {
      tasksTime.removeTask(task);
      tasksTime.save();
    }
  }

  static void updateTasksTime(TasksTime tasksTime, int index) {
    if (index > -1) {
      tasksTimeBox.putAt(index, tasksTime);
    }
  }

  static void removeTasksTime(TasksTime tasksTime) {
    tasksTime.removeAllTasks();
    tasksTime.delete();
  }

  static void onCompleted(TaskModel task) {
    task.isCompleted = !task.isCompleted;
    task.save();
  }
}
