import 'package:intl/intl.dart';
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
    noteModel.deadline == null
        ? deadline = 'Set a deadline for your task (optional)'
        : deadline = noteModel.deadline.toString();
    if (noteModel.id != null) {
      titleTextController.text = noteModel.title;
      descTextController.text = noteModel.description;
    }
    if (noteModel.deadlineTime != null) {
      _timeOfDay = noteModel.deadlineTime.toString();
    } else {
      _timeOfDay = ' ';
    }
  }

  _EditNoteState(this.noteModel, this.appBarTitle, this.buttonText);

  String _timeOfDay;
  String appBarTitle;
  String buttonText;
  DatabaseModel noteModel;

  var deadline;

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
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 16.5,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          appBarTitle,
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 2.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              margin: EdgeInsets.only(top: 5, left: 10, right: 10),
              child: Column(
                children: [
////////////////////////////////////////////////////////////////////////
                  ///
                  ///                   dropdown                           //
                  /// //
///////////////////////////////////////////////////////////////////////////

                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 30),
                          child: Text(
                            'Priority',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              // color: Colors.black,
                            ),
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
                        ),
                      ],
                    ),
                  ),

////////////////////////////////////////////////////////////////////////
                  ///
                  ///                   title                       //
                  /// //
///////////////////////////////////////////////////////////////////////////
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        showCursor: true,
                        cursorHeight: 33,
                        maxLines: 2,
                        keyboardAppearance: Brightness.dark,
                        keyboardType: TextInputType.text,
                        // textDirection: TextDirection.ltr,
                        // ignore: missing_return
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a title , its required !!! ';
                          } else {
                            titleTextController.text = value;
                          }
                        },
                        cursorColor: Colors.red,
                        controller: titleTextController,

                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            // color: Colors.black54,
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ),
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
                    padding: EdgeInsets.only(top: 5),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.28,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.withOpacity(0.3)),
                      child: TextField(
                        cursorColor: Colors.red,
                        maxLines: 6,
                        onSubmitted: (value) => descTextController.text = value,
                        keyboardAppearance: Brightness.dark,
                        controller: descTextController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            // color: Colors.black54,
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText:
                              'Description or sub-points for this task(optional)',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),

                  ////////////////////////////
                  ///
                  ///
                  /// the flat button for the addition of the deadline in the app
                  ///

                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        OutlineButton(
                          borderSide: BorderSide(
                            color: Colors.black54,
                            style: BorderStyle.solid,
                          ),
                          onPressed: () {
                            _pickDeadline();
                          },
                          child: Text('Deadline ?'),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.redAccent, Colors.pink],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              // color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            margin: EdgeInsets.only(left: 10, right: 5),
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '$deadline ,',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '$_timeOfDay',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
////////////////////////////////////////////////////////////////////////
                  ///
                  ///                   buttons                       //
                  /// //
///////////////////////////////////////////////////////////////////////////
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 7),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 3),
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10)),
                            child: RaisedButton(
                              elevation: 0,
                              color: Colors.amber,
                              splashColor: Colors.blue,
                              child: Text(
                                buttonText,
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () {
                                if (titleTextController.text != null) {
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
                                      noteModel.title =
                                          titleTextController.text;
                                      _onUpdateNote(
                                        DatabaseModel(
                                          id: noteModel.id,
                                          title: noteModel.title,
                                          description: noteModel.description,
                                          priority:
                                              _getPriorityToNum(dfltpriority),
                                          date: DateFormat('yyyy-MM-dd')
                                              .format(DateTime.now())
                                              .toString(),
                                          deadline: deadline,
                                          deadlineTime: _timeOfDay,
                                        ),
                                      );
                                      _backToMainPage();
                                    });
                                  }
                                } else {
                                  return null;
                                }
                              },
                            ),
                            // ),
                          ),
                        ),
                      ],
                    ),
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
          var now = DateTime.now();
          var formatter = DateFormat('yyyy-MM-dd');
          String date = formatter.format(now).toString();
          await _helper.insertNote(
            DatabaseModel(
              title: titleTextController.text,
              description: descTextController.text,
              priority: priorityNum,
              date: date,
              deadline: deadline,
              deadlineTime: _timeOfDay,
            ),
          );
        } catch (e) {}
      } else {
        this.priorityNum = 0;
        try {
          var now = DateTime.now();
          var formatter = DateFormat('yyyy-MM-dd');
          String date = formatter.format(now).toString();
          await _helper.insertNote(
            DatabaseModel(
              title: titleTextController.text,
              description: descTextController.text,
              priority: priorityNum,
              date: date,
              deadline: deadline,
              deadlineTime: _timeOfDay,
            ),
          );
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

  _pickDeadline() async {
    var date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (date != null) {
      setState(
        () {
          deadline =
              ('${date.year}-' + '${date.month}-' + '${date.day}').toString();
        },
      );
    }
    if (time != null) {
      MaterialLocalizations localizations = MaterialLocalizations.of(context);
      String formattedTime =
          localizations.formatTimeOfDay(time, alwaysUse24HourFormat: false);
      _timeOfDay = formattedTime.toString();
    }
  }
}
