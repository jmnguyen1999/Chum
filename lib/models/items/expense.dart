class Expense{

  double cost;
  String description;
  DateTime dueDate;
  int id;

  Expense({required this.id, required this.description, required this.cost, dueDate}) :
        dueDate = dueDate ?? DateTime(1999);

  //to be used when inserting a row in the table
  Map<String, dynamic> toMapWithoutId() {
    final map = new Map<String, dynamic>();
    map["expense_description"] = description;
    map["expense_due_date"] = dueDate.toString();
    map["expense_cost"] = cost;
    return map;
  }

  //to be used when updating a row in the table
  Map<String, dynamic> toMap() {
    final map = new Map<String, dynamic>();
    map["expense_id"] = id;
    map["expense_description"] = description;
    map["expense_due_date"] = dueDate.toString();
    map["expense_cost"] = cost;
    return map;
  }

  //to be used when converting the row into object
  factory Expense.fromMap(Map<String, dynamic> data) => new Expense(
    id: data['expense_id'],
    description: data['reminder_description'],
    cost: data['expense_cost'],
    dueDate: DateTime.parse(data['reminder_due_date']),
  );

  List<List<Expense>> getExpensesByDate(List<Expense> listExpenses){
    List<List<Expense>> result = [];
    if(listExpenses.isNotEmpty) {
      for (int i = 0; i < listExpenses.length; i++) {
        //Assume new date --> need a new row/list:
        List<Expense> newDate = <Expense>[];
        newDate.add(listExpenses[i]);
        DateTime dateOfItems = listExpenses[i].getDate();

        //Check every other item's date + see if need to add:
        for (int j = i + 1; j < listExpenses.length; j++) {
          Expense otherItem = listExpenses[j];
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
  List<Expense> to1DList(List<List<Expense>> listOfLists){
    List<Expense> result = [];
    for(int row = 0 ; row < listOfLists.length; row++){
      List<Expense> currRow = listOfLists[row];
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
  double getCost(){
    return cost;
  }

}