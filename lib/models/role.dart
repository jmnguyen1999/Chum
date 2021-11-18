import 'package:chums/models/user.dart';

import 'item.dart';

class Role{
  List<Item> allTasks;
  User memberAssigned;
 // String name;

  Role(this.allTasks, this.memberAssigned);
}