//Model to define a Circle of members, including all tasks, settings, etc
import 'dart:collection';

import 'package:chums/models/setup.dart';
import 'package:chums/models/user.dart';

import 'item.dart';

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
      { //If value not specified --> follows implementation after the colon
        List<Item>? allTasks,
        List<Item>? allAnnouncements,
        List<Item>? allExpenses,
        List<Item>? allReminders,
        Setup? settings
      }):
        allTasks = allTasks ?? [],
        allAnnouncements = allAnnouncements ?? [],
        allExpenses = allExpenses ?? [],
        allReminders = allReminders ?? [],
        settings = Setup(members);       //TODO: Determine what we want to be the default settings


  //Setter methods:
  addMember(User newMember) {
    members.add(newMember);
  }
  addTask(Item newTask){
    //TODO: error check newTask is an actual Task
    allTasks.add(newTask);
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