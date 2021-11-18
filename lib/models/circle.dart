//Model to define a Circle of members, including all tasks, settings, etc
import 'dart:collection';

import 'package:chums/models/setup.dart';
import 'package:chums/models/user.dart';

import 'item.dart';
import '../../constants.dart' as Constants;

class Circle{
  List<User> members;
  User host;
  String name;

  List<Item> allTasks;
  List<Item> allAnnouncements;
  List<Item> allExpenses;
  List<Item> allReminders;

  Setup settings;

  Circle(
      this.members,
      this.host,
      this.name,
      allTasks, allAnnouncements, allExpenses, allReminders,
      /*{ //If value not specified --> follows implementation after the colon
        List<Item>? allTasks,
        List<Item>? allAnnouncements,
        List<Item>? allExpenses,
        List<Item>? allReminders,
        Setup? settings
      }*/):
        allTasks = allTasks ?? [],
        allAnnouncements = allAnnouncements ?? [],
        allExpenses = allExpenses ?? [],
        allReminders = allReminders ?? [],
        settings = Setup(members);       //TODO: Determine what we want to be the default settings


  //Setter methods:
  addItem(Item item){
    int type = item.getType();
    switch(type) {
      case 1:
        addTask(item);
        break;
      case 2:
        addAnnouncement(item);
        break;
      case 3:
        addReminder(item);
        break;
      case 4:
        addExpense(item);
        break;
      default:
        type = -1;
        break;
    }
  }
  addMember(User newMember) {
    members.add(newMember);
  }
  addTask(Item newTask){
    //Insert in order of due date:
    int correctIndex = findCorrectIndex(allTasks, newTask, 0, allTasks.length-1);
    //TODO: error check newTask is an actual Task
    allTasks.insert(correctIndex, newTask);
  }

  //purpose: binarySearch for index:
  int findCorrectIndex(List<Item> list, Item newTask, int start, int end){
    if(end >= start) {
      int mid = ((end + start) / 2).floor();
     /* print("start = " + start.toString() + "  end = " + end.toString() +
          "  mid = " + mid.toString());*/

      Item midItem = list[mid];
      DateTime midDate = midItem.getDate();
      if (newTask.getDate().isAfter(midDate)) {
        return findCorrectIndex(list, newTask, mid + 1, end);
      }
      else if (newTask.getDate().isBefore(midDate)) {
        return findCorrectIndex(list, newTask, start, mid - 1);
      }
      else {
        return mid;
      }
    }
    else{
      int mid = ((end + start) / 2).floor();
      return mid+1;
    }
  }

  addReminder(Item newReminder){
    //TODO: error check newTask is an actual Task
    allReminders.add(newReminder);
  }
  addAnnouncement(Item newAnnouncement){
    //TODO: error check newTask is an actual Task
    allAnnouncements.add(newAnnouncement);
  }
  addExpense(Item newExpense){
    //TODO: error check newTask is an actual Task
    allExpenses.add(newExpense);
  }
  setSettings(Setup newSetup){
    settings = newSetup;
  }
  setName(String newName){
    name = newName;
  }
  setHost(User newHost){
    //TODO: Ensure newHost is a member of this circle

    host = newHost;
  }

  List<List<Item>> getOrderedListByDate(String keyItemType){
    List<List<Item>> result = [];

    List<Item> listToOrder = [];

    switch(keyItemType){
      case Constants.TASK_LIST:
        listToOrder = allTasks;
        break;
      case Constants.REMINDERS_LIST:
        listToOrder = allReminders;
        break;
      case Constants.ANNOUNCEMENTS_LIST:
        listToOrder = allAnnouncements;
        break;
      case Constants.EXPENSES_LIST:
        listToOrder = allExpenses;
        break;
      case Constants.KEY_ADD:
        listToOrder = allTasks;
        break;
      default:
        print("circle.dart:  orderListByDate() given invalid keyItemType");
        break;
    }

    if(listToOrder.isNotEmpty) {
      for (int i = 0; i < listToOrder.length; i++) {
        //Assume new date --> need a new row/list:
        List<Item> newDate = <Item>[];
        newDate.add(listToOrder[i]);
        DateTime dateOfItems = listToOrder[i].getDate();

        //Check every other item's date + see if need to add:
        for (int j = i + 1; j < listToOrder.length; j++) {
          Item otherItem = listToOrder[j];
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

  //Getter methods:
  List<Item> getAllTasks(){
    return allTasks;
  }
  List<Item> getAllAnnouncements(){
    return allAnnouncements;
  }
  List<Item> getAllReminders(){
    return allReminders;
  }
  List<Item> getAllExpenses(){
    return allExpenses;
  }
  List<Item> getAllItems(){
    List<Item> all = <Item>[];
    all.addAll(allTasks);
    all.addAll(allAnnouncements);
    all.addAll(allReminders);
    all.addAll(allExpenses);
    return all;
  }


}