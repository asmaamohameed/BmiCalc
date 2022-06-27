import 'package:bmicalc/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:bmicalc/modules/done_tasks/done_tasks_screen.dart';
import 'package:bmicalc/modules/new_tasks/new_tasks_screen.dart';
import 'package:bmicalc/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  int currentIndex = 0 ;

  List<Widget> screens =
      [
        NewTasksScreen(),
        DoneTasksScreen(),
        ArchivedTasksScreen(),
      ];

  List<String> titles =
      [
        'New Tasks',
        'Done Tasks',
        'Archived Tasks',
      ];

  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();

  @override
  void initState()
  {
    super.initState();

    //insertToDatabase();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
        ),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          insertToDatabase();
          /*if(isBottomSheetShown)
            {
              Navigator.pop(context);
              isBottomSheetShown = false;
              setState(()
              {
                fabIcon = Icons.edit;
              });
            }
          else
            {
              scaffoldKey.currentState?.showBottomSheet(
                    (context) => Container(
                      color: Colors.grey[300],
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:
                          [
                            defaultFormField(
                                controller: titleController,
                                type: TextInputType.text,
                                validate: (String value)
                              {
                                if(value.isEmpty)
                                  {
                                    return 'title Must not be empty';
                                  }
                                return null;
                              },
                                label: 'Task Title',
                                prefix: Icons.title,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onFieldSubmitted: (String value)
                              {
                                print(value);
                              },
                              onChanged: (String value)
                              {
                                print(value);
                              },
                              decoration: InputDecoration(
                                labelText: 'EmailAdd',
                                prefixIcon: Icon(
                                  Icons.email,
                                ),
                                border: OutlineInputBorder()
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
              );
              isBottomSheetShown = true;
              setState(()
              {
               fabIcon = Icons.add;
              });
            }*/

        },
        child: Icon(
          fabIcon,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index)
        {
          setState(() {
            currentIndex = index;
          });

        },
        items:
        [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu
              ),
              label: 'Tasks'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.check_circle_outline
              ),
              label: 'Done'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.archive_outlined
              ),
              label: 'Archived'
          ),
        ],
      ) ,
    );
  }

  Future<String> getName() async
  {
    return 'Ahmed Ali';
  }

  void createDatabase() async
  {
     database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version)
      {
        print('database created');

        database.execute('CREATE TABLE Tasks(ID INTEGER PRIMARY KEY,Title TEXT,Date TEXT,Time TEXT,Status TEXT)').then((value)
        {
          print('table created');
        }).catchError((error){
          print('Error when creating table ${error.toString}');
        });
      },
      onOpen: (database)
      {
        print('database opened');
      },
    );
  }

  Future insertToDatabase() async{
    return await database?.transaction((txn) async {
      txn
          .rawInsert(
          'INSERT INTO todo (id ,title ,date , time , status ) VALUES ("first task" , "002222" , "891" , "new")')
          .then((value) {
        print('$value inserted successfuly');
      }).catchError((error) {
        print('Error when inserted table ${error.toString()}');
      });
    });
  }
   /*void insertToDatabase()
  {
    database?.transaction((txn)
    {
     return txn.rawInsert(
          'INSERT INTO tasks(Title,Date,Time,Status) VALUES("Task-1","4-9-2022","9:00 AM","1")'
      ).then((value)
      {
        print('$value inserted Successfully');
      }).catchError((error){
        print('Error when Inserting New Record ${error.toString}');
      });
    });
  }*/

}
