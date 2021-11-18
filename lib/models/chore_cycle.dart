import 'package:chums/models/role.dart';

class ChoreCycle{
  //Possible interval periods: (1) once/month, (2) twice/month, (3) thrice/month
    int intervalPeriod;
    bool isEnabled;
    bool onRandomShuffle;
    List<Role> roleSequence;
    List<Role> allRoles;

    //By default: no roles, not enabled, no random shuffle, interval of twice/month
    ChoreCycle(allRoles, intervalPeriod, isEnabled, onRandomShuffle, roleSequence) :
        allRoles = allRoles ?? [],
        intervalPeriod = intervalPeriod ?? 2,
        isEnabled = isEnabled ?? false,
        onRandomShuffle = onRandomShuffle ?? false,
        roleSequence = roleSequence ?? [];


    bool isNull(){
      return intervalPeriod == -1;
    }
}