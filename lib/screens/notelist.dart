import 'package:TDM/models/databaseModel.dart';
import 'package:TDM/utils/DatabaseHelper.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import './editpage.dart';
import 'package:TDM/screens/settings.dart';

class Notelist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotelistState();
  }
}

class _NotelistState extends State<Notelist> {
  List<DatabaseModel> notes = [];
  DatabaseHelper _helper;

  @override
  void initState() {
    super.initState();
    setState(() {
      _helper = DatabaseHelper.instance;
    });
    _refreshListView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'ADD A NOTE',
        elevation: 10,
        onPressed: () {
          getToEdit(
              DatabaseModel(
                  title: '',
                  description: '',
                  priority: 0,
                  id: null,
                  date: null),
              'ADD TASK',
              'ADD');
        },
      ),
      appBar: AppBar(
        // backgroundColor: Colors.amber.withOpacity(0.2),
        // shadowColor: Colors.white12,
        title: Positioned(
          top: 20,
          left: 10,
          right: 10,
          child: _customAppBar(),
        ),
      ),
      body: getListView(),
    );
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          borderOnForeground: false,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
          elevation: 5,
          // color: Colors.white,
          child: ListTile(
              isThreeLine: true,
              // dense: true,
              onTap: () {
                getToEdit(
                    DatabaseModel(
                      id: notes[index].id,
                      title: notes[index].title,
                      description: notes[index].description,
                      priority: notes[index].priority,
                      date: notes[index].date,
                      deadline: notes[index].deadline,
                    ),
                    'EDIT TASK',
                    'SAVE');
              },
              leading: CircleAvatar(
                backgroundColor: Colors.amber,
                child: _priorityIconLeading(notes[index].priority),
              ),
              title: Center(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${notes[index].title}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                ),
              ),
              subtitle: Center(
                child: Container(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            '${notes[index].description}',
                          ),
                        ),
                      ),
                      _deadlineIsNull(notes[index]),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 5),
                          child: Text(
                            'last modified on ${notes[index].date}',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    _showAlertDialogue(context, 'Alert',
                        ' Are you sure you want to delete this item ? ', index);
                    _refreshListView();
// the code to delete items form the list view goes here in the space available
                  })),
        );
      },
    );
  }

  void getToEdit(
      DatabaseModel noteModel, String appBarTitle, String buttonText) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return EditNote(noteModel, appBarTitle, buttonText);
        },
      ),
    );
    if (result == true) {
      // we have to update the listview of the main app and the code for  that goes here
      setState(() {
        _refreshListView();
      });
    } else {
      _refreshListView();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('the operation was not unsuccessful'),
        ),
      );
      // we have to have an alert dialog stating that the operations were not succcessful
    }
  }

  void _refreshListView() async {
    List<DatabaseModel> x = await _helper.fetchData();
    setState(() {
      this.notes = x;
    });
  }

  _priorityIconLeading(int priority) {
    if (priority == 1) {
      return Icon(Icons.label_important, color: Colors.redAccent);
    } else {
      return Icon(
        Icons.low_priority_sharp,
        color: Colors.blueAccent,
      );
    }
  }

  _showAlertDialogue(
      BuildContext context, String title, String body, int index) async {
    AlertDialog dialog = AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        FlatButton(
          onPressed: () {
            // function to dismiss the alert dialogue
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        RaisedButton(
          color: Colors.blueAccent,
          child: Text(
            'Yes',  
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            _helper.deleteNote(notes[index].id);
            _refreshListView();
            Navigator.of(context).pop();
          },
        )
      ],
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => dialog,
    );
  }

  _customAppBar() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.wb_sunny_outlined),
          onPressed: () {
            // changes the theme to dark and light from the root widget
          },
        ),
        Text('PAPERCLIP'),
        IconButton(
            icon: Icon(Icons.menu_rounded),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Settings();
                },
              ));
            })
      ],
    );
  }

  Widget _deadlineIsNull(DatabaseModel note) {
    if (note.deadline == null ||
        note.deadline == 'Set a deadline for your task (optional)') {
      return Align(
        alignment: Alignment.centerLeft,
      );
    } else {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          child: Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.pink, Colors.red],
              ),
            ),
            child: Text(
              '${note.deadline}',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          ),
          padding: EdgeInsets.only(top: 8),
        ),
      );
    }
  }
}

// {
//     var now = new DateTime.now();
//     var formatter = new DateFormat('yyyy-MM-dd');
//     String formattedDate = formatter.format(now);
//     print(formattedDate); // 2016-01-25
// }
