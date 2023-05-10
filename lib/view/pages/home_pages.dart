import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/controoler/db_controoler.dart';
import 'package:reminder_app/controoler/theme_controller.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/golbes/theme.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:reminder_app/model/db_model.dart';

import '../../golbes/notification_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<DbModel>?>? remind;
  DateTime selectdate = DateTime.now();
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String endTime = DateFormat("hh:mm a")
      .format(
        DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          DateTime.now().hour,
          DateTime.now().minute + 5,
        ),
      )
      .toString();
  List data = ["Meditale", "Cooking", "Walking", "Read", "Relaxation", "Dance"];
  String category = "Meditale";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    getnoti();
    
  }
  getnoti()async{
    await Notification_Helper.notification_helper.intiNoti();
  }

  getdata() async {
    await DBHelper.dbHelper.initDb();
    remind =
        DBHelper.dbHelper.selectAll(d: DateFormat.yMd().format(selectdate));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _addHedingTask(),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: FutureBuilder(
              future: remind,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<DbModel>? data1 = snapshot.data;
                  print("Path");
                  print(DateFormat.yMd().format(selectdate));
                  return ListView.builder(
                    itemCount: data1!.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Dismissible(
                          key: UniqueKey(),
                          background: Container(
                            color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Move to trash",
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onDismissed: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              int a = await DBHelper.dbHelper
                                  .DeleteData(id: data1[index].id!);
                              print(a);
                              remind = DBHelper.dbHelper.selectAll(
                                  d: DateFormat.yMd().format(selectdate));
                              setState(() {});
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 5, top: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data1[index].category,
                                          style: GoogleFonts.lato(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          data1[index].dec,
                                          style: GoogleFonts.lato(
                                            fontSize: 11,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          "${data1[index].endTime} minutes",
                                          style: GoogleFonts.lato(
                                            fontSize: 13,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      child: (data1[index].category ==
                                              'Meditale')
                                          ? Image.asset(
                                              "assets/images/Meditation.png")
                                          : (data1[index].category == 'Cooking')
                                              ? Image.asset(
                                                  "assets/images/barbecue.png")
                                              : (data1[index].category ==
                                                      'Walking')
                                                  ? Image.asset(
                                                      "assets/images/Walking.png")
                                                  : (data1[index].category ==
                                                          'Read')
                                                      ? Image.asset(
                                                          "assets/images/Reading.png")
                                                      : (data1[index]
                                                                  .category ==
                                                              'Relaxation')
                                                          ? Image.asset(
                                                              "assets/images/Relaxing.png")
                                                          : Image.asset(
                                                              "assets/images/music.png"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  _addHedingTask() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            offset: Offset(2, 2),
            blurRadius: 15,
          ),
        ],
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, right: 15, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${DateFormat.MMMM().format(
                    DateTime.now(),
                  )}, ${DateFormat.y().format(DateTime.now())}",
                  style: Hedering(context),
                ),
                GestureDetector(
                  onTap: () async {
                    startTime =
                        DateFormat("hh:mm a").format(DateTime.now()).toString();
                    endTime = DateFormat("hh:mm a")
                        .format(
                          DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            DateTime.now().hour,
                            DateTime.now().minute + 5,
                          ),
                        )
                        .toString();

                    await _addTask();
                    setState(() {});
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: primerClr,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "+ Add Task",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: DatePicker(
              DateTime.now(),
              width: 50,
              height: 90,
              initialSelectedDate: DateTime.now(),
              selectionColor: primerClr,
              selectedTextColor: Colors.white,
              monthTextStyle: GoogleFonts.lato(
                color: Colors.grey[600],
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              dateTextStyle: GoogleFonts.lato(
                color: Colors.grey[600],
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              dayTextStyle: GoogleFonts.lato(
                color: Colors.grey[600],
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              onDateChange: (selectedDate) {
                setState(() {
                  selectdate = selectedDate;
                  remind = DBHelper.dbHelper
                      .selectAll(d: DateFormat.yMd().format(selectdate));
                  print(selectdate);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Provider.of<ThemeController>(context, listen: false).setTheme();
        },
        child: Consumer<ThemeController>(
          builder: (context, value, child) {
            return Icon(
              (value.themeModel.isdark)
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round_outlined,
              color: Theme.of(context).iconTheme.color,
            );
          },
        ),
      ),
      actions: [
        Icon(
          Icons.search_rounded,
          color: Theme.of(context).iconTheme.color,
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  _addTask() {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            margin: EdgeInsets.all(25),
            height: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _showHeding(),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  color: Colors.grey[600],
                  endIndent: 0,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Description",
                  style: GoogleFonts.lato(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  color: Colors.grey[600],
                  endIndent: 0,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Category",
                  style: GoogleFonts.lato(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    child: GridView.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              category = data[index];
                              print(category);
                            });
                          },
                          child: Container(
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: (category == data[index])
                                  ? Theme.of(context).buttonColor
                                  : Colors.grey[400],
                            ),
                            child: Center(
                              child: Text(
                                data[index],
                                style: GoogleFonts.lato(
                                  color: (category == data[index])
                                      ? Theme.of(context).backgroundColor
                                      : Theme.of(context).iconTheme.color,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 2,
                      ),
                      itemCount: data.length,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: () async {
                      int a = await DBHelper.dbHelper.insert(
                        c: category,
                        dec: "Lorem Ipsum is simply dummy text.",
                        e: endTime,
                        d: DateFormat.yMd().format(selectdate),
                      );
                      Navigator.pop(context);
                      remind = DBHelper.dbHelper
                          .selectAll(d: DateFormat.yMd().format(selectdate));
                      Notification_Helper.notification_helper.scheduleNoti(
                          title: category,
                          body: "Lorem Iosum",
                          select: selectdate,
                          tim: endTime);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: primerClr,
                      ),
                      child: Center(
                        child: Text(
                          "Create Task",
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  _getTimeFromUser() async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime != null) {
      endTime = _formatedTime;
      setState(() {});

      print(endTime);
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(startTime.split(":")[0]),
        minute: int.parse(startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  _showHeding() {
    return Row(
      children: [
        Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  color: Colors.grey[400],
                ),
                Text(
                  "Start Time",
                  style: GoogleFonts.lato(
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${startTime}",
              style: GoogleFonts.lato(
                color: Theme.of(context).iconTheme.color,
                fontSize: 18,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 25,
        ),
        Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    _getTimeFromUser();
                  },
                  child: Icon(
                    Icons.watch_later_outlined,
                    color: Colors.grey[400],
                  ),
                ),
                Text(
                  "End Time",
                  style: GoogleFonts.lato(
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${endTime}",
              style: GoogleFonts.lato(
                color: Theme.of(context).iconTheme.color,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
