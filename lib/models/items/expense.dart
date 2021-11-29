import 'package:intl/intl.dart';

class Expense{

  double cost;
  String description;
  DateTime dueDate;
  int id;
  bool isDone;

  Expense({required this.id, required this.description, required this.cost, dueDate, isDone}) :
        isDone = false,
        dueDate = dueDate ?? DateTime(1999);

  //to be used when inserting a row in the table
  Map<String, dynamic> toMapWithoutId() {
    final map = new Map<String, dynamic>();
    map["expense_description"] = description;
    map["expense_due_date"] = dueDate.toString();
    map["expense_cost"] = cost;
    return map;
  }

  //to be used when updating a row in the table
  Map<String, dynamic> toMap() {
    final map = new Map<String, dynamic>();
    map["expense_id"] = id;
    map["expense_description"] = description;
    map["expense_due_date"] = dueDate.toString();
    map["expense_cost"] = cost;
    return map;
  }

  //to be used when converting the row into object
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