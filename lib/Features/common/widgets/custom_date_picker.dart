import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/langauge_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

class CustomDatePickerWidget extends StatefulWidget {
  final Function(String date, DateTime dateTime) onSelectDate;
  final bool isDateOnly;
  final String? title;
  final String? hintText;
  final String? initialDate;
  final Color? mainColor;
  final DateTime? firstDate;
  const CustomDatePickerWidget({
    Key? key,
    required this.onSelectDate,
    this.title,
    this.hintText,
    this.isDateOnly = false,
    this.mainColor,
    this.firstDate,
    this.initialDate,
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
                color: widget.mainColor ?? ColorManager.titlesTextColor,
                width: 1.5,
              ),
            ),
            title: Text(
              widget.initialDate != null
                  ? widget.initialDate!
                  : data != ''
                      ? data
                      : widget.hintText ?? AppStrings.selectDate.tr(),
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: ColorManager.grey, fontSize: 13),
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
    widget.onSelectDate(dateFormatted, dateTime);
    return DateFormat(dateFormatterString).format(dateTime);
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
                        initialDate: widget.initialDate != null
                            ? DateFormat(
                                    widget.isDateOnly
                                        ? 'dd MMM yyyy'
                                        : 'dd MMM yyyy/ hh:mm a',
                                    _appPrefs.getAppLanguage())
                                .parse(widget.initialDate!)
                            : DateTime.now(),
                        firstDate: widget.firstDate ?? DateTime(1940),
                        lastDate: DateTime(2050),
                        currentDate: DateTime.now(),
                        initialEntryMode: DatePickerEntryMode.calendar,
                        initialDatePickerMode: DatePickerMode.day,
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: ColorManager
                                    .primary, // header background color
                                onPrimary: Colors.white, // header text color
                                onSurface: MaterialStateColor.resolveWith(
                                  (states) =>
                                      states.contains(MaterialState.selected)
                                          ? Colors.grey
                                          : Colors.black,
                                ),
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateColor.resolveWith((states) =>
                                          ColorManager.primaryTextColor),
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        });
                    if (widget.isDateOnly || date == null) {
                      dateSub.value = date;
                      return;
                    }
                    final timeValue = await showTimePicker(
                        context: context,
                        initialTime: widget.initialDate != null
                            ? TimeOfDay.fromDateTime(DateFormat(
                                    widget.isDateOnly
                                        ? 'dd MMM yyyy'
                                        : 'dd MMM yyyy/ hh:mm a',
                                    _appPrefs.getAppLanguage())
                                .parse(widget.initialDate!))
                            : TimeOfDay.now(),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              timePickerTheme: TimePickerThemeData(
                                helpTextStyle: const TextStyle(fontSize: 24),
                                dayPeriodTextStyle:
                                    const TextStyle(fontSize: 14),
                                hourMinuteTextStyle:
                                    const TextStyle(fontSize: 14),
                                hourMinuteTextColor: ColorManager.white,
                                hourMinuteColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      states.contains(MaterialState.selected)
                                          ? ColorManager.primary
                                          : Colors.grey.withOpacity(0.5),
                                ),
                                dayPeriodTextColor: Colors.white,
                                dayPeriodColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      states.contains(MaterialState.selected)
                                          ? ColorManager.primary
                                          : Colors.grey.withOpacity(0.5),
                                ),
                                dialHandColor: ColorManager.primary,
                                dialBackgroundColor:
                                    Colors.grey.withOpacity(0.5),
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateColor.resolveWith((states) =>
                                          ColorManager.primaryTextColor),
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        });
                    var dateTime = DateTime(
                      date.year,
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
