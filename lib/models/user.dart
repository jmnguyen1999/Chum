//Model to keep track of Users
class User{
  String username;
  String fname;
  String lname;
  String email;
  String password;
  List<String> circleIds;

  User(this.username, this.password, this.email, this.fname, this.lname, circleIds
      /*{
        List<String>? circleIds
      }*/) : circleIds = circleIds ?? [];

  //Purpose: This user joins a new circle
  joinGroup(String circleId){
    //TODO: Check if valid circleId/can find it:

    circleIds.add(circleId);
  }

  String getFName(){
    return fname;
  }

}