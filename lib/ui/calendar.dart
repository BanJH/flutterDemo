import 'package:flutter/material.dart';
import 'package:flutter_notes/utils/note_db_helper.dart';
import 'package:flutter_custom_calendar/controller.dart';
import 'package:flutter_custom_calendar/widget/calendar_view.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    Key? key,
    @required this.noteDbHelper
  }) : super(key: key);

  final NoteDbHelper? noteDbHelper;
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with AutomaticKeepAliveClientMixin {

  late CalendarController calendarController;
  @override
  void initState() {
    super.initState();
    calendarController = CalendarController();
    calendarController.addMonthChangeListener(
            (year, month) {
              setState(() {

              });

    });
    calendarController.addOnCalendarSelectListener((dateModel) {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CalendarViewWidget(
      calendarController: calendarController,

    );
  }

  @override
  bool get wantKeepAlive => true;
}


