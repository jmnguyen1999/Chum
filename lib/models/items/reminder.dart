import 'package:flutter/material.dart';

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

  List<List<Reminder>> getRemindersByDate(List<Reminder> listReminders){
    List<List<Reminder>> result = [];
    if(listReminders.isNotEmpty) {
      for (int i = 0; i < listReminders.length; i++) {
        //Assume new date --> need a new row/list:
        List<Reminder> newDate = <Reminder>[];
        newDate.add(listReminders[i]);
        DateTime dateOfItems = listReminders[i].getDate();

        //Check every other item's date + see if need to add:
        for (int j = i + 1; j < listReminders.length; j++) {
          Reminder otherItem = listReminders[j];
          DateTime otherDate = otherItem.getDate();

          print("date = " + dateOfItems.toString() + "  otherdate = " +
              otherDate.toString() + " i = " + i.toString() + "  j = " +
              j.toString());
          //If date is same, add this item to list, then check other items
          if (dateOfItems.compareTo(otherDate) == 0) {
            newDate.add(otherItem);
          }
          else { //otherwise, date is different, so make i jump to = j to make a new list from there
            i = j - 1;
            break;
          }
        }

        //Add this new list to the 2d list:
        result.add(newDate);
      }
    }

    return result;
  }
  List<Reminder> to1DList(List<List<Reminder>> listOfLists){
    List<Reminder> result = [];
    for(int row = 0 ; row < listOfLists.length; row++){
      List<Reminder> currRow = listOfLists[row];
      for(int col = 0; col <currRow.length; col++){
        result.add(currRow[col]);
      }
    }
    return result;
  }

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
    return dueDate.toString();
  }
  DateTime getDate(){
    return dueDate;
  }

}