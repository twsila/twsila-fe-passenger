import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/utils/resources/color_manager.dart';
import 'package:taxi_for_you/utils/resources/font_manager.dart';
import 'package:taxi_for_you/utils/resources/langauge_manager.dart';
import 'package:taxi_for_you/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/utils/resources/styles_manager.dart';

class CustomDatePickerWidget extends StatefulWidget {
  final Function(String date) onSelectDate;
  final bool isDateOnly;
  final String? title;
  final String? hintText;
  final Color? mainColor;
  const CustomDatePickerWidget({
    Key? key,
    required this.onSelectDate,
    this.title,
    this.hintText,
    this.isDateOnly = false,
    this.mainColor,
  }) : super(key: key);

  @override
  State<CustomDatePickerWidget> createState() => _CustomDatePickerWidgetState();
}

class _CustomDatePickerWidgetState extends State<CustomDatePickerWidget> {
  final _appPrefs = instance<AppPreferences>();
  final ValueNotifier<DateTime?> dateSub = ValueNotifier(null);

  Widget buildDateTimePicker(String data) {
    return Row(
      children: [
        if (widget.title != null)
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title!,
                    style: getMediumStyle(
                        color: ColorManager.lightGrey, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        Flexible(
          flex: 3,
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                color: widget.mainColor ?? ColorManager.lightPrimary,
                width: 1.5,
              ),
            ),
            title: Text(
              data != '' ? data : widget.hintText ?? AppStrings.selectDate.tr(),
              textAlign: TextAlign.start,
              style: getMediumStyle(
                color: widget.mainColor ?? ColorManager.primary,
                fontSize: FontSize.s14,
              ),
            ),
            leading: Icon(
              Icons.calendar_today,
              color: widget.mainColor ?? ColorManager.primary,
            ),
          ),
        ),
      ],
    );
  }

  String convertDate(DateTime dateTime) {
    String dateFormatterString =
        widget.isDateOnly ? 'dd MMM yyyy' : 'dd MMM yyyy/ hh:mm a';

    String dateFormatted =
        DateFormat(dateFormatterString, _appPrefs.getAppLanguage())
            .format(dateTime);
    widget.onSelectDate(dateFormatted);
    return DateFormat(dateFormatterString, _appPrefs.getAppLanguage())
        .format(dateTime);
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
                        locale: _appPrefs.getAppLanguage() ==
                                LanguageType.ENGLISH.getValue()
                            ? ENGLISH_LOCAL
                            : ARABIC_LOCAL,
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
                    if (widget.isDateOnly) {
                      dateSub.value = date;
                      return;
                    }
                    final timeValue = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
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
                    var dateTime = DateTime(
                      date!.year,
                      date.month,
                      date.day,
                      timeValue!.hour,
                      timeValue.minute,
                    );
                    dateSub.value = dateTime;
                  },
                  child: buildDateTimePicker(
                      dateVal != null ? convertDate(dateVal) : ''));
            }));
  }
}
