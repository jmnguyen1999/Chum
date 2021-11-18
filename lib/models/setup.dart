import 'package:chums/models/role.dart';
import 'package:chums/models/user.dart';

import 'chore_cycle.dart';

class Setup{
  List<User> allMembers;
  User host;
  String name;
  ChoreCycle cycleSettings;
  List<Role> allRoles;

  Setup(this.allMembers, this.host, this.name, cycleSettings, allRoles) :
        cycleSettings = ChoreCycle(null, null, null, null, null),
        allRoles = allRoles ?? [];

  bool hasRoles() {
    return allRoles.isEmpty;
  }
  List<Role> getRoles(){
    return allRoles;
  }
}