import 'package:TDM/screens/settings.dart';
import 'package:flutter/material.dart';
import './editpage.dart';

class Notelist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotelistState();
  }
}

class _NotelistState extends State<Notelist> {
  int itemCount = 10;

  // int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'ADD A NOTE',
        elevation: 10,
        onPressed: () {
          getToEdit( 'ADD TASK', 'ADD NOTE');
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
            onPressed: () {
//   here goes the setting screen
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return Settings();
              }));
            },
          )
        ],
      ),
      body: getListView(),
    );
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          elevation: 1,
          color: Colors.white,
          child: ListTile(
              onTap: () {
                getToEdit( 'EDIT TASK', 'SAVE NOTE');
              },
              leading: CircleAvatar(
                backgroundColor:Colors.amber,
                child:Icon(Icons.low_priority),
              ),
              title: Text('sample ttile $position',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),),
              subtitle: Expanded(
                  child: Text(
                'sample description $position ',
              )),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
// the code to delete items form the list view goes here in the space available 
                  })),
        );
      },
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void getToEdit( String appBarTitle, String buttonText) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditNote(appBarTitle, buttonText);
    }));
    
  }

  // void updateListView() {
  //   final Future<Database> dbFuture = databaseHelper.initDB();
  //   dbFuture.then((database) {
  //     Future<List<Note>> notelistFuture = databaseHelper.getNoteList();
  //     notelistFuture.then((notelist) {
  //       setState(() {
  //         this.notelist = notelist;
  //         this.itemCount = notelist.length;
  //       });
  //     });
  //   });
  // }
}
