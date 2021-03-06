import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class MyApp1 extends StatefulWidget {
  final String itemID;
  MyApp1(this.itemID);
  State<StatefulWidget> createState() {
    return MyApp1State(itemID);
  }
}

class MyApp1State extends State<MyApp1> {
  final String itemID;
  MyApp1State(this.itemID);
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();
  DateTime _fdate = new DateTime.now();
  TimeOfDay _ftime = new TimeOfDay.now();

  StreamSubscription _subscriptionTodo;

  String _name = "Display the todo name here";
  String _location = "None";
  String _decription = "None";
  String _category = "None";
  double _rate = 0.0;
  double _price = 0.0;
  String _path = "";

  void initState() {
    FirebaseTodos.getTodo("deHPdJNYm582VcJSRx5w").then(_updateTodo);

    //FirebaseTodos.getTodoStream(itemID, _updateTodo)
    //  .then((StreamSubscription s) => _subscriptionTodo = s);
    super.initState();
  }

  @override
  void dispose() {
    if (_subscriptionTodo != null) {
      _subscriptionTodo.cancel();
    }
    super.dispose();
  }

  _updateTodo(Todo value) {
    var name = value.name;
    var location = value.location;
    var description = value.decription;
    var price = value.price;
    var category = value.category;
    var rate = value.rate;
    var path = value.path;
    setState(() {
      _name = name;
      _location = location;
      _decription = description;
      _price = price;
      _category = category;
      _rate = rate;
      _path = path;
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: _date,
        lastDate: new DateTime(2021));
    if (picked != null) {
      setState(() {
        _date = picked;
        _fdate = picked;
      });
    }
  }

  Future<Null> _selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _fdate,
        firstDate: _fdate,
        lastDate: new DateTime(2021));
    if (picked != null) {
      setState(() {
        _fdate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //build function returns a "Widget"
    var description = new Card(
        child: Row(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              new ListTile(
                title: new Text(
                  "Description",
                  style: new TextStyle(fontWeight: FontWeight.w400),
                ),
                subtitle: new Text("$_decription"),
              ),
              new ListTile(
                leading: new Icon(Icons.category),
                title: new Text("$_category"),
              ),
              new ListTile(
                title: new Text("$_price SR/day",
                    style: TextStyle(
                      letterSpacing: 0.5,
                      fontSize: 20.0,
                    )),
                leading: new Icon(Icons.monetization_on),
              ),
              new ListTile(
                title: new Text("$_location ",
                    style: TextStyle(
                      letterSpacing: 0.5,
                      fontSize: 20.0,
                    )),
                leading: new Icon(Icons.location_on),
              ),
              new ListTile(
                title: Text("Starting Date:"),
                subtitle: new IconButton(
                    icon: new Icon(Icons.date_range),
                    onPressed: () {
                      _selectDate(context);
                    }),
                trailing: Text('${_date.year}${-_date.month}${-_date.day}'),
              ),
              new ListTile(
                title: Text("Ending  Date:"),
                subtitle: new IconButton(
                    icon: new Icon(Icons.date_range),
                    onPressed: () {
                      _selectDate1(context);
                    }),
                trailing: Text('${_fdate.year}${-_fdate.month}${-_fdate.day}'),
              ),
              new ListTile(
                title: Text("Starting Date:"),
                subtitle: new IconButton(
                    icon: new Icon(Icons.timer),
                    onPressed: () {
                      _selectTime(context);
                    }),
                trailing: Text('${_time.hour} :${_time.minute}'),
              ),
              new ListTile(
                title: Text("Ending Date:"),
                subtitle: new IconButton(
                    icon: new Icon(Icons.timer),
                    onPressed: () {
                      _selectTime1(context);
                    }),
                trailing: Text('${_ftime.hour} :${_ftime.minute}'),
              ),
              new Divider(
                color: Colors.redAccent,
                indent: 16.0,
              ),
              new ListTile(
                title: new Text(
                  "$_rate/5",
                  style: new TextStyle(fontWeight: FontWeight.w400),
                ),
                leading: new Icon(Icons.star),
              ),
            ],
          ),
        )
      ],
    ));

    final sizedBox = new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0),
      child: new SizedBox(
        height: 410.0,
        child: description,
      ),
    );
    final center = new Center(
      child: sizedBox,
    );
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
        "$_name",
      )),
      body: Column(
        children: <Widget>[
          itemImage(_path),
          center,
          new Builder(
            builder: (BuildContext context) {
              bottomNavigationBar:
              return BottomNavigationBar(
                onTap: (int) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text("Confirma Request"),
                        content: new Text("Send a request for $_name"),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("Confirm"),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/RentalHistory');
                            },
                          ),
                          // usually buttons at the bottom of the dialog
                          new FlatButton(
                            child: new Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    title: Text('Rent Now'),
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list), title: Text('add to wish list')),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null) {
      setState(() {
        _time = picked;
        _ftime = picked;
      });
    }
  }

  Future<Null> _selectTime1(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _ftime,
    );
    if (picked != null) {
      setState(() {
        _ftime = picked;
      });
    }
  }
}

class itemImage extends StatelessWidget {
  String path;
  itemImage(this.path);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var assetsImage = new AssetImage('${path}');
    var image = new Image(
      image: assetsImage,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 5,
    );
    return Container(child: image);
  }
}

class Todo {
  final String key;
  String name;
  String location;
  String decription;
  double price;
  String category;
  double rate;
  String path;
  Todo.fromJson(this.key, Map data) {
    name = data['name'];
    location = data['location'];
    decription = data['description'];
    price = data['price'];
    category = data['category'];
    rate = data['rate'];
    path = data['photo'];
    if (name == null &&
        location == null &&
        decription == null &&
        price == null &&
        category == null &&
        rate == null) {
      name = '';
      location = '';
      decription = '';
      price = 0.0;
      category = '';
      rate = 0.0;
    }
  }
}

class FirebaseTodos {
  static Future<Todo> getTodo(String todoKey) async {
    Completer<Todo> completer = new Completer<Todo>();

    // String accountKey = await Preferences.getAccountKey();

    FirebaseDatabase.instance
        .reference()
        .child("Item")
        .child(todoKey)
        .once()
        .then((DataSnapshot snapshot) {
      var todo = new Todo.fromJson(snapshot.key, snapshot.value);
      completer.complete(todo);
    });

    return completer.future;
  }

  /// FirebaseTodos.getTodoStream("-KriJ8Sg4lWIoNswKWc4", _updateTodo)
  /// .then((StreamSubscription s) => _subscriptionTodo = s);
  static Future<StreamSubscription<Event>> getTodoStream(
      String todoKey, void onData(Todo todo)) async {
    //String accountKey = await Preferences.getAccountKey();

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("Item")
        .child(todoKey)
        .onValue
        .listen((Event event) {
      var todo = new Todo.fromJson(event.snapshot.key, event.snapshot.value);
      onData(todo);
    });

    return subscription;
  }

  /// FirebaseTodos.getTodo("-KriJ8Sg4lWIoNswKWc4").then(_updateTodo);

}
