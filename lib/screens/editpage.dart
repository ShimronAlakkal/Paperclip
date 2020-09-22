import 'package:flutter/material.dart';


class EditNote extends StatefulWidget {
  final String appBarTitle;
  final String buttonText;
  EditNote( this.appBarTitle, this.buttonText);

  @override
  State<StatefulWidget> createState() {
    return _EditNoteState( this.appBarTitle, this.buttonText);
  }
}

class _EditNoteState extends State<EditNote> {
  final String appBarTitle;
  final String buttonText;

  var formkey = GlobalKey<FormState>();
  _EditNoteState( this.appBarTitle, this.buttonText);

  var list = ['High', 'Low'];
  var dfltpriority = 'Low';
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        value: dfltpriority,
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
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: TextFormField(
                      onChanged: (value) {
                        // code for the title editing goes here !!!
                      },
                      keyboardAppearance: Brightness.dark,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter a title , its required !!! ';
                        }
                      },
                      cursorColor: Colors.amberAccent,
                      controller: titleTextController,
                      textDirection: TextDirection.ltr,
                      autocorrect: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Task',
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
                          )),
                    ),
                  ),

////////////////////////////////////////////////////////////////////////
                  ///
                  ///                   descriptoin                       //
                  /// //
///////////////////////////////////////////////////////////////////////////
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 30),
                    child: TextField(
                      onChanged: (value) {
                        //  the code for the text field of description goes here 
                      },
                      keyboardAppearance: Brightness.dark,
                      autocorrect: true,
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
                          )),
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
                              setState(() {
                                if (formkey.currentState.validate()) {
                                  //  code for the add button goes here also apply for the save button as well 
                                  
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
////////////////////////////////////////////////////////////////////////
                  ///
                  ///                   del button                       //
                  /// //
//////////////////////////////////////////////////////////////////////////

                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 70,
                        padding: EdgeInsets.only(top: 20),
                        child: RaisedButton(
                          onPressed: () {
                            //  here is the code to delete the thing
                           
                          },
                          color: Colors.white,
                          child: Text(
                            'DELETE',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

