import 'package:TDM/models/databaseModel.dart';
import 'package:TDM/screens/settings.dart';
import 'package:TDM/utils/DatabaseHelper.dart';
import 'package:flutter/material.dart';
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
              DatabaseModel(title: '', description: '', priority: 0, id: null),
              'ADD TASK',
              'ADD');
        },
      ),
      appBar: AppBar(
        shadowColor: Colors.white12,
        title: Text(
          'NOTES',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            color: Colors.black45,
            onPressed: () async {
// the code to go to the settins page
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Settings();
                },
              ));
            },
          )
        ],
      ),
      body: getListView(),
    );
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 1,
          color: Colors.white,
          child: ListTile(
              onTap: () {
                getToEdit(
                    DatabaseModel(
                        id: notes[index].id,
                        title: notes[index].title,
                        description: notes[index].description,
                        priority: notes[index].priority),
                    'EDIT TASK',
                    'SAVE');
              },
              leading: CircleAvatar(
                backgroundColor: Colors.amber,
                child: _priorityIconLeading(notes[index].priority),
              ),
              title: Text(
                '${notes[index].title}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
              subtitle: Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom:8),
                  child: Text(
                    '${notes[index].description}',
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
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditNote(noteModel, appBarTitle, buttonText);
    }));
    if (result == true) {
      // we have to update the listview of the main app and the code for  that goes here
      setState(() {
        _refreshListView();
      });
    } else {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('the operation was not unsuccessful')));
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
}
