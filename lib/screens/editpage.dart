import 'package:TDM/models/databaseModel.dart';
import 'package:TDM/utils/DatabaseHelper.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  final String appBarTitle;
  final String buttonText;
  final DatabaseModel noteModel;

  EditNote(this.noteModel, this.appBarTitle, this.buttonText);

  @override
  State<StatefulWidget> createState() {
    return _EditNoteState(this.noteModel, this.appBarTitle, this.buttonText);
  }
}

class _EditNoteState extends State<EditNote> {
  @override
  void initState() {
    super.initState();
    if (noteModel.priority == 1) {
      setState(() {
        this.dfltpriority = 'High';
      });
    } else {
      setState(() {
        this.dfltpriority = 'Low';
      });
    }
    setState(() {
      _helper = DatabaseHelper.instance;
    });
  }

  _EditNoteState(this.noteModel, this.appBarTitle, this.buttonText);

  String appBarTitle;
  String buttonText;
  DatabaseModel noteModel;

  // creating the instance of the helper so that we are able to use the functions after the initdatabase
  DatabaseHelper _helper;

  var formkey = GlobalKey<FormState>();

  var list = ['High', 'Low'];
  var dfltpriority = 'Low';
  String supportPriority;
  int priorityNum;
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (noteModel.id != null) {
      titleTextController.text = noteModel.title;
      descTextController.text = noteModel.description;
    }

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(appBarTitle),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                children: [
////////////////////////////////////////////////////////////////////////
                  ///
                  ///                   dropdown                           //
                  /// //
///////////////////////////////////////////////////////////////////////////

                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 30),
                        child: Text(
                          'Priority',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                      DropdownButton(
                        iconSize: 30.0,
                        hint: Tooltip(
                            message: 'set your task as per its priority'),
                        elevation: 10,
                        dropdownColor: Colors.amber,
                        icon: Icon(Icons.arrow_drop_down),
                        value: this.dfltpriority,
                        onChanged: (String selectedPriority) {
                          setState(() {
                            this.dfltpriority = selectedPriority;
                          });
                        },
                        items: list.map((String priority) {
                          return DropdownMenuItem(
                            child: Text(priority),
                            value: priority,
                          );
                        }).toList(),
                      )
                    ],
                  ),

////////////////////////////////////////////////////////////////////////
                  ///
                  ///                   title                       //
                  /// //
///////////////////////////////////////////////////////////////////////////
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 5),
                    child: TextFormField(
                      keyboardAppearance: Brightness.dark,
                      textDirection: TextDirection.ltr,
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a title , its required !!! ';
                        } else {
                          titleTextController.text = value;
                        }
                      },
                      cursorColor: Colors.amberAccent,
                      controller: titleTextController,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Title',
                        labelStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: 'Please enter the task here (required)',
                        hintStyle: TextStyle(
                          color: Colors.black26,
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),

////////////////////////////////////////////////////////////////////////
                  ///
                  ///                   descriptoin                       //
                  /// //
///////////////////////////////////////////////////////////////////////////
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 30),
                    child: Container(
                      child: TextField(
                        onSubmitted: (value) => descTextController.text = value,
                        keyboardAppearance: Brightness.dark,
                        controller: descTextController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText:
                              'Enter a description for this task (optional)',
                          hintStyle: TextStyle(
                            color: Colors.black26,
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),

////////////////////////////////////////////////////////////////////////
                  ///
                  ///                   buttons                       //
                  /// //
///////////////////////////////////////////////////////////////////////////
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          height: 50,
                          child: RaisedButton(
                            child: Text(
                              buttonText,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            color: Colors.amber,
                            disabledColor: Colors.grey,
                            onLongPress: () {
                              Tooltip(message: '$buttonText NOTE TO THE LIST');
                            },
                            onPressed: () {
                              if (buttonText == 'ADD') {
                                setState(
                                  () {
                                    _onSubmit();
                                  },
                                );
                              } else {
                                setState(() {
                                  noteModel.description =
                                      descTextController.text;
                                  noteModel.title = titleTextController.text;
                                  _onUpdateNote(DatabaseModel(
                                    id: noteModel.id,
                                    title: noteModel.title,
                                    description: noteModel.description,
                                    priority: _getPriorityToNum(dfltpriority),
                                  ));
                                  _backToMainPage();
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _backToMainPage() {
    Navigator.pop(context, true);
  }

  _onUpdateNote(DatabaseModel noteModel) {
    _helper.updateNote(noteModel);
  }

  _onSubmit() async {
    descTextController.text += ' ';
    if (formkey.currentState.validate() && descTextController.text != null) {
      _backToMainPage();
      if (this.dfltpriority == 'High') {
        this.priorityNum = 1;

        try {
          await _helper.insertNote(DatabaseModel(
              title: titleTextController.text,
              description: descTextController.text,
              priority: priorityNum));
        } catch (e) {}
      } else {
        this.priorityNum = 0;
        try {
          await _helper.insertNote(DatabaseModel(
              title: titleTextController.text,
              description: descTextController.text,
              priority: priorityNum));
        } catch (e) {}
      }
    }
  }

  int _getPriorityToNum(String priority) {
    if (priority == 'High') {
      return 1;
    } else {
      return 0;
    }
  }
}
