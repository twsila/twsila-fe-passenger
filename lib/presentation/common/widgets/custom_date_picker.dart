import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taxi_for_you/utils/resources/color_manager.dart';

class CustomDatePickerWidget extends StatefulWidget {
  final Function(String date) onSelectDate;
  const CustomDatePickerWidget({Key? key, required this.onSelectDate})
      : super(key: key);

  @override
  State<CustomDatePickerWidget> createState() => _CustomDatePickerWidgetState();
}

class _CustomDatePickerWidgetState extends State<CustomDatePickerWidget> {
  final ValueNotifier<DateTime?> dateSub = ValueNotifier(null);

  Widget buildDateTimePicker(String data) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: ColorManager.lightPrimary, width: 1.5),
            ),
            title: Text(
              data != '' ? data : 'اختر معاد',
              textAlign: TextAlign.end,
            ),
            trailing: Icon(
              Icons.calendar_today,
              color: ColorManager.primary,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          'جدولة المواعيد',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ],
    );
  }

  String convertDate(DateTime dateTime) {
    String dateFormatted = DateFormat.yMMMd().format(dateTime);
    widget.onSelectDate(dateFormatted);
    return DateFormat.yMMMd().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: ValueListenableBuilder<DateTime?>(
            valueListenable: dateSub,
            builder: (context, dateVal, child) {
              return InkWell(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2050),
                        currentDate: DateTime.now(),
                        initialEntryMode: DatePickerEntryMode.calendar,
                        initialDatePickerMode: DatePickerMode.day,
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.fromSwatch(
                              primarySwatch: Colors.indigo,
                              accentColor: ColorManager.lightGrey,
                              backgroundColor: Colors.lightBlue,
                              cardColor: Colors.white,
                            )),
                            child: child!,
                          );
                        });
                    dateSub.value = date;
                  },
                  child: buildDateTimePicker(
                      dateVal != null ? convertDate(dateVal) : ''));
            }));
  }
}
