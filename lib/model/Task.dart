class Task {
  int? id ;
  late String title;
  //late DateTime date;
  late String Details;
 int status=0; //0-task Uncomplete // 1-task Complete
  Task({required this.title,
   // required this.date,
    required this.Details
  });


  /*Task.withId(
      {required this.id,
      required this.title,
      required this.date,
      required this.status, Details});*/

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
  //  map['date'] = date.toIso8601String();
   // map['date'] = date;
    map['status'] = status;
    map['Details'] = Details;
    return map;
  }
  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    //date = json['date'];
    status = json['status'];
    Details = json['Details'];
  }
 /* factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
      id: map['id'],
      title: map['title'],
      date:map['date'],
     // date: DateTime.parse(map['date']),
      Details:map['Details'],
      status: map['status'],

    );*/
  }

