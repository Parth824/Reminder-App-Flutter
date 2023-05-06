import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/controoler/theme_controller.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/golbes/theme.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectdate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: garyClr,
      body: Column(
        children: [
          _addHedingTask(),
          Expanded(
            child: Container(
              color: garyClr,
            ),
          ),
        ],
      ),
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
                Container(
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
}
