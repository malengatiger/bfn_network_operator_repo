import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MyDatePicker extends StatefulWidget {
  final DateListener dateListener;

  const MyDatePicker({Key key, @required this.dateListener}) : super(key: key);
  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _sliderValue = 7;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Date Selections'),
          bottom: PreferredSize(
              child: Column(), preferredSize: Size.fromHeight(100)),
        ),
        backgroundColor: Colors.brown[100],
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  Slider(
                      label: 'Number of Days',
                      min: 7,
                      max: 120,
                      value: _sliderValue,
                      onChanged: _onSliderChanged),
                  SizedBox(
                    height: 24,
                  ),
                  SfDateRangePicker(
                    view: DateRangePickerView.year,
                    monthViewSettings:
                        DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                    maxDate: DateTime.now(),
                    minDate: DateTime.now().subtract(Duration(days: 90)),
                    onSelectionChanged: _onSelectionChanged,
                    controller: _rangeController,
                    selectionMode: DateRangePickerSelectionMode.range,
                    // selectionColor: Colors.pink,
                    endRangeSelectionColor: Colors.pink[600],
                    startRangeSelectionColor: Colors.indigo,
                    rangeSelectionColor: Colors.teal[200],
                  ),
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
      if (range.startDate != null && range.endDate != null) {
        p('🌀 Telling dateListener that range has been selected ...');
        widget.dateListener.onRangeSelected(range.startDate, range.endDate);
      }
    }
  }
}

abstract class DateListener {
  onRangeSelected(DateTime startDate, DateTime endDate);
}
