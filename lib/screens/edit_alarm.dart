import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_cubit.dart';
import '../bloc/app_states.dart';

class EditAlarm extends StatelessWidget {
  TextEditingController? titleController;
  DateTime? date;
  int? index;
  EditAlarm(
      {Key? key,
      required this.titleController,
      required this.date,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      print(state);
    }, builder: (context, state) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          color: Colors.grey[900],
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.95,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  AppCubit.get(context)
                      .insertAlarmsList(index, titleController!.text, date!);

                  Navigator.pop(context);
                },
                child: const Text('Save',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              initialDateTime: date,
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (value) {
                date = AppCubit.get(context).changeTime(value);
              },
            ),
          ),
          TextField(
            controller: titleController,
            style: const TextStyle(color: Colors.orange, fontSize: 18),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              hintText: "Title",
              hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 18,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.orange,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(
                      Colors.orange.withOpacity(0.2)),
                  fixedSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width * 0.95, 35)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          side: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(13))),
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent)),
              onPressed: () {
                AppCubit.get(context).removeFromAlarmsList(index);

                Navigator.pop(context);
              },
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              )),
        ]),
      );
    });
  }
}
