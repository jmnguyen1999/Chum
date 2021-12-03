import 'package:intl/intl.dart';
/*
  expense.dart
  Purpose:                Model class to encapsulate all data regarding an Expense item. An Expense item is an item to display with a description, cost, and possible due date.
  Correlated File:        Used with add_page.dart, expenses_page.dart, database.dart
 */

class Expense{

  double cost;
  String description;
  DateTime dueDate;
  int id;
  bool isDone;        //Only used to toggle checkboxes in expenses_page.dart


  //Purpose:  Constructor, dueDate and isDone optional w/default values
  Expense({required this.id, required this.description, required this.cost, dueDate, isDone}) :
        isDone = false,
        dueDate = dueDate ?? DateTime(1999);


  //------------For Database interaction--------------------------------
  //Purpose:  to be used when inserting a row in the database table, creates a database row from an Expense object without an actual valid id. (b/c has yet to be in database)
  Map<String, dynamic> toMapWithoutId() {
    final map = new Map<String, dynamic>();
    map["expense_description"] = description;
    map["expense_due_date"] = dueDate.toString();
    map["expense_cost"] = cost;
    return map;
  }

  //Purpose:  to be used to convert an Expense object into a row in the database
  Map<String, dynamic> toMap() {
    final map = new Map<String, dynamic>();
    map["expense_id"] = id;
    map["expense_description"] = description;
    map["expense_due_date"] = dueDate.toString();
    map["expense_cost"] = cost;
    return map;
  }

  ////Purpose: to be used when converting a given database row into an Expense object
  factory Expense.fromMap(Map<String, dynamic> data) => new Expense(
    id: data['expense_id'],
    description: data['expense_description'],
    cost: data['expense_cost'],
    dueDate: DateTime.parse(data['expense_due_date']),
  );



  //Getter methods:
  bool getIsDone(){
    return isDone;
  }

  int getId(){
    return id;
  }
  String getDescription(){
    return description;
  }
  bool hasDueDate(){
    return !(dueDate.compareTo(DateTime(1999)) == 0);
  }
  String getDateString(){
    if(!hasDueDate()){
      return "N/A";
    }
    return DateFormat('EEEE, MMMM d').format(dueDate);
  }
  DateTime getDate(){
    return dueDate;
  }
  double getCost(){
    return cost;
  }

}