import 'package:clockapp/bloc/app_cubit.dart';
import 'package:clockapp/bloc/app_states.dart';
import 'package:clockapp/screens/edit_alarm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Alarm extends StatelessWidget {
  Alarm(
      {Key? key,
      this.title,
      this.time,
      this.on = false,
      this.onChange,
      required this.index})
      : super(key: key);
  String? title;
  int? index;
  bool? on;
  String? time;
  Function(bool?)? onChange;
  TextEditingController tt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    tt.text = title!;
    return ListTile(
      onTap: () {
        DateTime d = DateTime.parse('2022-03-19 $time:00.00');
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return BlocProvider(
                create: (context) => AppCubit(InitialAppState()),
                child: EditAlarm(
                  index: index,
                  titleController: tt,
                  date: d,
                ),
              );
            });
      },
      title: Text(
        time!,
        style: const TextStyle(fontSize: 24, color: Colors.white),
      ),
      subtitle: Text(
        tt.text,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
      trailing: CupertinoSwitch(
        value: on!,
        onChanged: onChange,
      ),
    );
  }
}
