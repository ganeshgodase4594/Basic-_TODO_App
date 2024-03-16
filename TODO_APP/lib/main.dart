import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() => runApp(const myApp());

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: homescreen(),
    );
  }
}

class ToDOListAppModel {
  String titleController;
  String descriptionController;
  String dateController;

  ToDOListAppModel(
      {required this.titleController,
      required this.descriptionController,
      required this.dateController});
}

// ignore: camel_case_types
class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenstate();
}

// ignore: camel_case_types
class _homescreenstate extends State<homescreen> {
  List<Color> colors = [
    const Color.fromRGBO(232, 237, 250, 1),
    const Color.fromRGBO(250, 232, 250, 1),
    const Color.fromRGBO(250, 232, 232, 1),
    const Color.fromRGBO(250, 249, 232, 1),
    const Color.fromRGBO(250, 232, 234, 1),
  ];

  bool flag = false;
  bool flag1=false;
  bool flag2=false;
  int? editingIndex;
  int? deleteIndex;
  bool isTaskAvailable = false;
  List<ToDOListAppModel> todolist = [];

  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController date = TextEditingController();

  // ignore: non_constant_identifier_names
  void BottomSheetPage() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: MediaQuery.of(context).viewInsets,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Create Task",
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Title",
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextField(
                        controller: title,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: flag
                                  ? Colors.red
                                  : const Color.fromRGBO(0, 139, 148, 1),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: flag && title.text.trim().isEmpty
                                  ? Colors.red
                                  : const Color.fromRGBO(0, 139, 148, 1),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (ValueKey) {
                          if (flag) {
                            setState(() {
                              flag = false;
                              Navigator.pop(context);
                              BottomSheetPage();
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Description",
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(0, 139, 148, 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: TextField(
                        controller: desc,
                        maxLines: 4,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: flag1
                                  ? Colors.red
                                  : const Color.fromRGBO(0, 139, 148, 1),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: flag1
                                  ? Colors.red
                                  : const Color.fromRGBO(0, 139, 148, 1),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (ValueKey) {
                          if (flag1) {
                            setState(() {
                              flag1 = false;
                              Navigator.pop(context);
                              BottomSheetPage();
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Date",
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(0, 139, 148, 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextField(
                          controller: date,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: flag2
                                    ? Colors.red
                                    : const Color.fromRGBO(0, 139, 148, 1),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: flag2
                                    ? Colors.red
                                    : const Color.fromRGBO(0, 139, 148, 1),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: const Icon(
                              Icons.date_range_outlined,
                              color: Color.fromRGBO(0, 0, 0, 0.7),
                            ),
                          ),
                          onChanged: (ValueKey) {
                            if (flag2) {
                              setState(() {
                                flag2 = false;
                                Navigator.pop(context);
                                BottomSheetPage();
                              });
                            }
                          },
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);

                              setState(() {
                                date.text = formattedDate;
                              });
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(60, 40, 173, 180),
                          fixedSize: const Size(300, 50),
                        ),
                        onPressed: () {
                          if (title.text.isEmpty) {
                            setState(() {
                              flag = true;
                              Navigator.pop(context);
                              BottomSheetPage();
                            });
                          }else if(desc.text.isEmpty){

                            setState(() {
                              flag1 = true;
                              Navigator.pop(context);
                              BottomSheetPage();
                            });
                          } else if(date.text.isEmpty){
                            setState(() {
                              flag2 = true;
                              Navigator.pop(context);
                              BottomSheetPage();
                            });
                          }else {
                            setState(() {
                              if (title.text.trim().isNotEmpty &&
                                  desc.text.trim().isNotEmpty &&
                                  date.text.trim().isNotEmpty) {
                                if (editingIndex != null) {
                                  todolist[editingIndex!] = ToDOListAppModel(
                                      titleController: title.text.trim(),
                                      descriptionController: desc.text.trim(),
                                      dateController: date.text.trim());
                                  title.clear();
                                  desc.clear();
                                  date.clear();

                                  editingIndex = null;
                                } else {
                                  ToDOListAppModel addobj = ToDOListAppModel(
                                      titleController: title.text.trim(),
                                      descriptionController: desc.text.trim(),
                                      dateController: date.text);

                                  if (title.text.trim().isNotEmpty &&
                                      desc.text.trim().isNotEmpty &&
                                      date.text.trim().isNotEmpty) {
                                    todolist.add(addobj);
                                    isTaskAvailable = true;
                                  }
                                }
                              }
                            });

                            title.clear();
                            desc.clear();
                            date.clear();

                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          "Add Task",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TO-DO List',
          style: GoogleFonts.quicksand(
            textStyle: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1), fontSize: 26),
          ),
        ),
        backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: todolist.isNotEmpty
            ? ListView.builder(
                itemCount: todolist.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 15, bottom: 15),
                    child: Container(
                      color: colors[index],
                      padding: const EdgeInsets.all(15),
                      child: Column(children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 52,
                              width: 52,
                              margin: const EdgeInsets.only(top: 20, right: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white),
                              child: Center(
                                child: Image.asset('assets/images/Group 42.png',
                                    height: 19.07, width: 23.79),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    todolist[index].titleController,
                                    style: GoogleFonts.quicksand(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            const Color.fromRGBO(0, 0, 0, 1)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(todolist[index].descriptionController,
                                      style: GoogleFonts.quicksand(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: const Color.fromRGBO(
                                              84, 84, 84, 1))),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(todolist[index].dateController,
                                style: GoogleFonts.quicksand(
                                  fontSize: 10,
                                  textStyle: const TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                  color: const Color.fromRGBO(132, 132, 132, 1),
                                  fontWeight: FontWeight.w500,
                                )),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  editingIndex = index;
                                  title.text = todolist[index].titleController;
                                  desc.text =
                                      todolist[index].descriptionController;
                                  date.text = todolist[index].dateController;
                                  BottomSheetPage();
                                },
                                icon: const Icon(Icons.edit),
                                color: const Color.fromRGBO(0, 139, 148, 1)),
                            const SizedBox(
                              width: 20,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    todolist.removeAt(index);
                                  });
                                  title.clear();
                                  desc.clear();
                                  date.clear();
                                },
                                icon: const Icon(Icons.delete),
                                color: const Color.fromRGBO(0, 139, 148, 1))
                          ],
                        ),
                      ]),
                    ),
                  );
                },
              )
            : Column(
                //mainAxisAlignment: MainAxisAlignment.,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Center(child: Image.asset('assets/images/todo2.png')),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'Add Your First Task',
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: const Color.fromARGB(186, 35, 29, 29)),
                    ),
                  ),
                  Center(
                      child: Text('Click On + To Add Task',
                          style: GoogleFonts.quicksand(
                              fontSize: 15, fontWeight: FontWeight.w400)))
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            flag = false;
          });
          isTaskAvailable = true;
          editingIndex = null;
          title.clear();
          desc.clear();
          date.clear();
          BottomSheetPage();
        },
        child: const Text(
          '+',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
