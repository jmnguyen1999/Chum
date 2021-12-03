import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

/*
database.dart
Purpose:      Handle SQLite, creates the database file system in the phone thorough specified tables and queries for Reminder, Task, and Expense objects.
              Also in charge of implementation of methods to easily update/create new rows in database.
 */
class DatabaseHelper {
  static final _databaseName = "ChumDatabase.db";
  static final _databaseVersion = 1;

  //Task table:
  static final taskTable = 'task_table';
  static final taskId = 'task_id';
  static final taskColDescription = 'task_description';
  static final taskColDueDate = 'task_due_date';

  //Reminder table:
  static final reminderTable = "reminder_table";
  static final reminderId = 'reminder_id';
  static final reminderColDescription = 'reminder_description';
  static final reminderColDueDate = 'reminder_due_date';

  //Expense Table:
  static final expenseTable = "expense_table";
  static final expenseId = 'expense_id';
  static final expenseColDescription = 'expense_description';
  static final expenseColDueDate = 'expense_due_date';
  static final expenseColCost = 'expense_cost';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = new DatabaseHelper._privateConstructor();

  Database? _database;

  //Purpose:    Initialize the database asynchronously
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  //Purpose:    Initialize the database asynchronously
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  //Purpose:    Create the Task, Reminder, Expense table upon database creation.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $taskTable (
            $taskId integer primary key,
            $taskColDescription text not null,
            $taskColDueDate text NOT NULL
          )
          ''');
    await db.execute('''
      create table $reminderTable (
        $reminderId integer primary key,
        $reminderColDescription text not null,
        $reminderColDueDate text null
       )''');
    await db.execute('''
       create table $expenseTable (
        $expenseId integer primary key,
        $expenseColDescription text not null,
        $expenseColDueDate text null,
        $expenseColCost double not null
       )''');
  }


  //-----------Insert item into database methods-----------------------
  Future<int> insertTask(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(taskTable, row);
    print("Task was inserted: ");
  }
  Future<int> insertReminder(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(reminderTable, row);
    print("Reminder was inserted: ");
  }
  Future<int> insertExpense(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(expenseTable, row);
  }


  //--------------Query for all rows of item methods---------------------
  Future<List<Map<String, dynamic>>> queryAllTasks() async {
    Database? db = await instance.database;
    var result = await db!.rawQuery("SELECT * FROM task_table ORDER BY task_due_date");
    //var result = await db!.query(taskTable);
    print("Task list from database: " + result.toString());
    return result.toList();
  }
  Future<List<Map<String, dynamic>>> queryAllReminders() async {
    Database? db = await instance.database;
    //var result = await db!.query(reminderTable);
    var result = await db!.rawQuery("SELECT * FROM reminder_table ORDER BY reminder_due_date");
    print("Result list from database: " + result.toString());
    return result.toList();
  }
  Future<List<Map<String, dynamic>>> queryAllExpenses() async {
    Database? db = await instance.database;
    //var result = await db!.query(expenseTable);
    var result = await db!.rawQuery("SELECT * FROM expense_table ORDER BY expense_due_date");
    return result.toList();
  }

  //----------------Query for count of rows for item methods --------------------------
  Future<int> queryTaskCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $taskTable'));
  }
  Future<int> queryReminderCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $reminderTable'));
  }
  Future<int> queryExpenseCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $expenseTable'));
  }

  //---------------------Update given row of item methods --------------------------------
  Future<int> updateTask(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[taskId];
    return await db!.update(taskTable, row, where: '$taskId = ?', whereArgs: [id]);
  }
  Future<int> updateReminder(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[reminderId];
    return await db!.update(reminderTable, row, where: '$reminderId = ?', whereArgs: [id]);
  }
  Future<int> updateExpense(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[expenseId];
    return await db!.update(reminderTable, row, where: '$reminderId = ?', whereArgs: [id]);
  }


  //---------------------Delete given row of item methods-----------------
  Future<int> deleteTask(int id) async {
    Database? db = await instance.database;
    return await db!.delete(taskTable, where: '$taskId = ?', whereArgs: [id]);
  }
  Future<int> deleteReminder(int id) async {
    Database? db = await instance.database;
    return await db!.delete(reminderTable, where: '$reminderId = ?', whereArgs: [id]);
  }
  Future<int> deleteExpense(int id) async {
    Database? db = await instance.database;
    return await db!.delete(expenseTable, where: '$expenseId = ?', whereArgs: [id]);
  }


}