import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Reminder{
  int id;
  String description;
  DateTime dueDate;

  Reminder({required this.id, required this.description, dueDate}) :
        this.dueDate = dueDate ?? DateTime(1999);

  //to be used when inserting a row in the table
  Map<String, dynamic> toMapWithoutId() {
    final map = new Map<String, dynamic>();
    map["reminder_description"] = description;
    map["reminder_due_date"] = dueDate.toString();
    return map;
  }

  //to be used when updating a row in the table
  Map<String, dynamic> toMap() {
    final map = new Map<String, dynamic>();
    map["reminder_id"] = id;
    map["reminder_description"] = description;
    map["reminder_due_date"] = dueDate.toString();
    return map;
  }

  //to be used when converting the row into object
  factory Reminder.fromMap(Map<String, dynamic> data) => new Reminder(
    id: data['reminder_id'],
    description: data['reminder_description'],
    dueDate: DateTime.parse(data['reminder_due_date']),
  );


  /*List<Reminder> to1DList(List<List<Reminder>> listOfLists){
    List<Reminder> result = [];
    for(int row = 0 ; row < listOfLists.length; row++){
      List<Reminder> currRow = listOfLists[row];
      for(int col = 0; col <currRow.length; col++){
        result.add(currRow[col]);
      }
    }
    return result;
  }*/

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