import 'package:chums/models/role.dart';
import 'package:chums/models/user.dart';

import 'ChoreCycle.dart';

class Setup{
  List<User> allMembers;
  ChoreCycle cycleSettings;
  List<Role> allRoleTypes;

  Setup(
      this.allMembers,
      {
        ChoreCycle? cycleSettings,
        List<Role>? allRoleTypes,
      }) :
        cycleSettings = ChoreCycle(),          //TODO: Determine what we want to be the default settings
        allRoleTypes = allRoleTypes ?? [];

  bool hasRoles() {
    return allRoleTypes.isEmpty;
  }
}