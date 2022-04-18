import 'package:clockapp/bloc/app_cubit.dart';
import 'package:clockapp/bloc/app_states.dart';

import 'package:clockapp/screens/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlarmList extends StatelessWidget {
  AlarmList({Key? key, this.shown}) : super(key: key);

  List? shown;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var shownAlarms = AppCubit.get(context).shownAlarms;
        return shownAlarms.isEmpty
            ? const Center(
                child: Text(
                'There is no alarms yet !',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ))
            : ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey[850],
                ),
                itemCount: shownAlarms.length,
                itemBuilder: (context, index) {
                  return Alarm(
                    index: index,
                    title: shownAlarms[index]['title'],
                    time: shownAlarms[index]['time'],
                    on: shownAlarms[index]['value'],
                    onChange: (value) {
                      AppCubit.get(context).changeSwitchValue(index, value);
                    },
                  );
                },
              );
      },
    );
  }
}
