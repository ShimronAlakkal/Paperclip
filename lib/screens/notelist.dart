import 'package:TDM/models/databaseModel.dart';
import 'package:TDM/screens/settings.dart';
import 'package:TDM/utils/DatabaseHelper.dart';
import 'package:TDM/utils/themeData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './editpage.dart';

class Notelist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotelistState();
  }
}

class _NotelistState extends State<Notelist> {
  List<DatabaseModel> notes = [];
  DatabaseHelper _helper;
  bool panelActive = false;
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
                date: null,
                deadlineTime: null,
              ),
              'ADD TASK',
              'ADD');
        },
      ),
      appBar: AppBar(
        primary: true,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: _customAppBar(context),
      ),
      body: getListView(),
    );
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          borderOnForeground: true,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          elevation: 5,
          // color: Colors.white,
          child: ListTile(
//
            isThreeLine: true,
            dense: true,
            onTap: () {
              getToEdit(
                  DatabaseModel(
                    id: notes[index].id,
                    title: notes[index].title,
                    description: notes[index].description,
                    priority: notes[index].priority,
                    date: notes[index].date,
                    deadline: notes[index].deadline,
                    deadlineTime: notes[index].deadlineTime,
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
                    _descNullAlign(notes[index]),
                    Row(
                      children: [
                        _deadlineIsNull(notes[index]),
                        _deadlineTimeIsNull(notes[index]),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 5),
                        child: Text(
                          'last modified on ${notes[index].date}',
                          style: TextStyle(
                            fontSize: 9,
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
              },
            ),
          ),
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

  _customAppBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.menu_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return Settings();
                  },
                ),
              );
            },
          ),
          Text(
            'PAPERCLIP',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 3.5,
              fontWeight: FontWeight.w400,
            ),
          ),
          Consumer<ThemeNotifier>(
            builder: (context, ThemeNotifier notifier, child) {
              return IconButton(
                icon: Icon(Icons.wb_sunny_outlined),
                onPressed: () {
                  // changes the theme to dark and light from the root widget

                  notifier.changeTheme();
                },
              );
            },
          ),
        ],
      ),
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
            padding: EdgeInsets.only(
              left: 5,
              right: 5,
              top: 1,
              bottom: 1,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.pink[500], Colors.red[500]],
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

  Widget _deadlineTimeIsNull(DatabaseModel note) {
    if (note.deadlineTime == null || note.deadlineTime == ' ') {
      return Align(
        alignment: Alignment.centerLeft,
      );
    } else {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          child: Container(
            margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.only(
              left: 5,
              right: 5,
              top: 1,
              bottom: 1,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.cyan[500], Colors.blue[500]],
              ),
            ),
            child: Text(
              '${note.deadlineTime}',
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

  _descNullAlign(DatabaseModel note) {
    if (note.description == null || note.description == ' ') {
      return Align(
        alignment: Alignment.centerLeft,
      );
    } else {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            '${note.description}',
          ),
        ),
      );
    }
  }
}
