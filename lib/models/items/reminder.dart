import 'package:intl/intl.dart';

/*
  reminder.dart
  Purpose:                Model class to encapsulate all data regarding a Reminder item. A Reminder item is an item to display with a description and possible due date.
  Correlated File:        Used with add_page.dart, home_page.dart, database.dart
 */

class Reminder{
  int id;
  String description;
  DateTime dueDate;

  //Purpose:  Constructor, dueDate optional w/default values
  Reminder({required this.id, required this.description, dueDate}) :
        this.dueDate = dueDate ?? DateTime(1999);

  //Purpose:  to be used when inserting a row in the database table, creates a database row from an Reminder object without an actual valid id. (b/c has yet to be in database)
  Map<String, dynamic> toMapWithoutId() {
    final map = new Map<String, dynamic>();
    map["reminder_description"] = description;
    map["reminder_due_date"] = dueDate.toString();
    return map;
  }

  //Purpose:  to be used to convert a Reminder object into a row in the database
  Map<String, dynamic> toMap() {
    final map = new Map<String, dynamic>();
    map["reminder_id"] = id;
    map["reminder_description"] = description;
    map["reminder_due_date"] = dueDate.toString();
    return map;
  }

  ////Purpose: to be used when converting a given database row into a Reminder object
  factory Reminder.fromMap(Map<String, dynamic> data) => new Reminder(
    id: data['reminder_id'],
    description: data['reminder_description'],
    dueDate: DateTime.parse(data['reminder_due_date']),
  );


  //Getter methods:
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

}