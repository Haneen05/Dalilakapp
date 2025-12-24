import 'package:daleelakappx/models/storefront.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:daleelakappx/extensions/time_of_day.dart';

class OperatingHoursCard extends StatefulWidget {
  const OperatingHoursCard({
    super.key,
  });

  @override
  State<OperatingHoursCard> createState() => OperatingHoursCardState();
}

class OperatingHoursCardState extends State<OperatingHoursCard> {
  var input = OperatingHoursInput();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: DColumn(
          mainAxisSpacing: 25.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DRow(
              mainAxisSpacing: 12.0,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(Icons.timer),
                Expanded(
                  child: Text(
                    'Operation Hours',
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                CupertinoSwitch(
                  value: input.showOperatingHours,
                  onChanged: (checked) {
                    setState(() => input.showOperatingHours = checked);
                  },
                ),
              ],
            ),
            if (input.showOperatingHours)
              DColumn(
                children: input.values().map((item) {
                  var (day, values) = item;
                  return DColumn(
                    children: [
                      DRow(
                        children: [
                          CupertinoCheckbox(
                            value: values.isNotEmpty,
                            onChanged: (checked) {
                              setState(() {
                                if (checked == null || !checked) {
                                  values.removeWhere((_) => true);
                                } else {
                                  values.add(OperationWindowInput());
                                }
                              });
                            },
                          ),
                          Text(day),
                        ],
                      ),
                      DRow(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const DBox.horizontalSpace3Xl(),
                          Expanded(
                            child: DColumn(
                              mainAxisSpacing: 7.0,
                              children: values.map((elem) {
                                return DRow(
                                  mainAxisSpacing: 12.0,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        readOnly: true,
                                        onTap: () async {
                                          var selectedTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: elem.opens,
                                          );
                                          if (selectedTime != null) {
                                            setState(() {
                                              elem.opens = selectedTime;
                                              if (elem.opens > elem.closes) {
                                                elem.closes = TimeOfDay(
                                                  hour: elem.opens.hour + 1,
                                                  minute: 0,
                                                );
                                              }
                                            });
                                          }
                                        },
                                        textAlign: TextAlign.center,
                                        controller: TextEditingController(
                                          text: elem.opens.format(context),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        readOnly: true,
                                        onTap: () async {
                                          var scaffoldMessenger =
                                              ScaffoldMessenger.of(context);
                                          var selectedTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: elem.closes,
                                          );
                                          if (selectedTime != null) {
                                            if (selectedTime > elem.opens) {
                                              setState(() =>
                                                  elem.closes = selectedTime);
                                            } else {
                                              scaffoldMessenger
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Cannot set opening time before closing time'),
                                                backgroundColor:
                                                    Color(0xffe16060),
                                              ));
                                            }
                                          }
                                        },
                                        textAlign: TextAlign.center,
                                        controller: TextEditingController(
                                          text: elem.closes.format(context),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                          if (values.isNotEmpty)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() =>
                                        values.add(OperationWindowInput()));
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() => values.removeLast());
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  void mapFrom(Storefront value) {
    setState(() => input.mapFrom(value.operatingHours));
  }
}

class OperatingHoursInput {
  bool showOperatingHours = true;

  List<OperationWindowInput> monday = [];
  List<OperationWindowInput> tuesday = [];
  List<OperationWindowInput> wednesday = [];
  List<OperationWindowInput> thursday = [];
  List<OperationWindowInput> friday = [];
  List<OperationWindowInput> saturday = [];
  List<OperationWindowInput> sunday = [];

  List<(String day, List<OperationWindowInput>)> values() {
    return [
      ("Monday", monday),
      ("Tuesday", tuesday),
      ("Wednesday", wednesday),
      ("Thursday", thursday),
      ("Friday", friday),
      ("Saturday", saturday),
      ("Sunday", sunday),
    ];
  }

  void mapFrom(OperatingHours operatingHours) {
    OperationWindowInput mapper(window) {
      var operationWindowInput = OperationWindowInput();
      operationWindowInput.opens = window.opens;
      operationWindowInput.closes = window.closes;
      return operationWindowInput;
    }

    monday = operatingHours.monday.map(mapper).toList();
    tuesday = operatingHours.tuesday.map(mapper).toList();
    wednesday = operatingHours.wednesday.map(mapper).toList();
    thursday = operatingHours.thursday.map(mapper).toList();
    friday = operatingHours.friday.map(mapper).toList();
    saturday = operatingHours.saturday.map(mapper).toList();
    sunday = operatingHours.sunday.map(mapper).toList();
  }
}

class OperationWindowInput {
  TimeOfDay opens = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay closes = const TimeOfDay(hour: 18, minute: 0);
}
