// ignore: avoid_web_libraries_in_flutter
// import 'dart:html';

import 'package:bfnlibrary/util/functions.dart';
import 'package:bfnlibrary/util/prefs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerMobile extends StatefulWidget {
  final DateListener dateListener;

  const DatePickerMobile({Key key, @required this.dateListener})
      : super(key: key);
  @override
  _DatePickerMobileState createState() => _DatePickerMobileState();
}

class _DatePickerMobileState extends State<DatePickerMobile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    // getDates();
  }

  DateTime mStartDate;
  DateTime mEndDate;
  // ignore: non_constant_identifier_names
  var DAYS_IN_CALENDAR = 180;
  void getDates() async {
    var start = await Prefs.getStartDate();
    var end = await Prefs.getEndDate();

    if (start != null) {
      mStartDate = DateTime.parse(start);
      start = DateFormat('MMMM dd, yyyy').format(mStartDate);
    }
    if (end != null) {
      mEndDate = DateTime.parse(end);
      end = DateFormat('MMMM dd, yyyy').format(mEndDate);
    }
    if (mStartDate != null && mEndDate != null) {
      numberOfDays = mEndDate.difference(mStartDate).inDays.toString();
    }
    setState(() {
      startDate = start == null ? '' : start;
      endDate = end == null ? '' : end;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Date Range Selection',
            style: Styles.whiteSmall,
          ),
          bottom: PreferredSize(
              child: Column(
                children: [
                  Text(
                    'Select both the starting date and the ending date',
                    style: Styles.whiteSmall,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                ],
              ),
              preferredSize: Size.fromHeight(60)),
        ),
        backgroundColor: Colors.brown[100],
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text('Start Date'),
                      ),
                      Text(
                        '$startDate',
                        style: Styles.blackBoldSmall,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text('End Date'),
                      ),
                      Text(
                        '$endDate',
                        style: Styles.blackBoldSmall,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text('Number of Days'),
                      ),
                      Text(
                        '$numberOfDays',
                        style: Styles.pinkBoldSmall,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SfDateRangePicker(
                    view: DateRangePickerView.year,
                    monthViewSettings:
                        DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                    maxDate: DateTime.now(),
                    minDate: DateTime.now()
                        .subtract(Duration(days: DAYS_IN_CALENDAR)),
                    onSelectionChanged: _onSelectionChanged,
                    controller: _rangeController,
                    selectionMode: DateRangePickerSelectionMode.range,
                    headerStyle: DateRangePickerHeaderStyle(
                        backgroundColor: Colors.indigo[100],
                        textStyle: Styles.blackBoldSmall),
                    endRangeSelectionColor: Colors.pink[600],
                    startRangeSelectionColor: Colors.indigo,
                    rangeSelectionColor: Colors.teal[200],
                    headerHeight: 48,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FlatButton(
                      onPressed: () {
                        p('....... About to pop out of the date picker ...');
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Done',
                        style: Styles.blackBoldSmall,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DateRangePickerController _rangeController = DateRangePickerController();
  void _onSliderChanged(double value) {
    p('🔵 _onSliderChanged; value: 🔵 $value 🔵');
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    p('🔆 _onSelectionChanged: 🔆 DateRangePickerSelectionChangedArgs: 🔆 value is: ${args.value}');
    DateTime sDate = _rangeController.selectedDate;
    List<DateTime> dates = _rangeController.selectedDates;
    var range = _rangeController.selectedRange;

    p('🌀 Selected Date: 🌀 ${sDate == null ? 'No Date Selected' : sDate}');
    p('🌀 Selected Dates: 🌀 ${dates == null ? 'No Dates' : dates.length}');
    p('🌀 Selected Range: 🌀 ${range == null ? 'No Range' : '${range.startDate} ${range.endDate}'}}');
    if (range != null) {
      setTheState(range);
      if (range.startDate != null && range.endDate != null) {
        p('🌀 Telling dateListener that range has been selected ...');
        widget.dateListener.onRangeSelected(range.startDate, range.endDate);
        numberOfDays =
            range.endDate.difference(range.startDate).inDays.toString();
        Prefs.setStartDate(range.startDate.toIso8601String());
        Prefs.setEndDate(range.endDate.toIso8601String());

        setTheState(range);
      }
    }
  }

  void setTheState(PickerDateRange range) {
    var sDate, eDate;
    if (range.startDate != null) {
      sDate = DateFormat('MMMM dd, yyyy').format(range.startDate);
    }
    if (range.endDate != null) {
      eDate = DateFormat('MMMM dd, yyyy').format(range.endDate);
    }

    setState(() {
      startDate = sDate == null ? '' : sDate;
      endDate = eDate == null ? '' : eDate;
    });
  }

  String startDate = '', endDate = '', numberOfDays = '0';
}

abstract class DateListener {
  onRangeSelected(DateTime startDate, DateTime endDate);
}
