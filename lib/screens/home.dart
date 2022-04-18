import 'package:clockapp/bloc/app_cubit.dart';
import 'package:clockapp/bloc/app_states.dart';
import 'package:clockapp/screens/add_alarm.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatelessWidget {
  Home({
    Key? key,
  }) : super(key: key);

  @override
  TextEditingController titleController = TextEditingController();
  List shonAlarms = [];

  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: ((context, state) {
      print(state);
    }), builder: (context, state) {
      AppCubit cubit = AppCubit.get(context);
      cubit.screenIndex = cubit.screenIndex;

      shonAlarms = cubit.shownAlarms;

      return Scaffold(
        backgroundColor: Colors.grey[900],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey[900],
          items: [
            BottomNavigationBarItem(
                backgroundColor: const Color.fromARGB(255, 33, 33, 33),
                icon: (SvgPicture.asset(
                  'assets/icons/clock.svg',
                  color: cubit.screenIndex == 0 ? Colors.orange : Colors.grey,
                  height: cubit.screenIndex == 0 ? 30 : 20,
                )),
                label: 'clock'),
            BottomNavigationBarItem(
              backgroundColor: const Color.fromARGB(255, 33, 33, 33),
              icon: (SvgPicture.asset(
                'assets/icons/alarm.svg',
                color: cubit.screenIndex == 1 ? Colors.orange : Colors.grey,
                height: cubit.screenIndex == 1 ? 30 : 20,
              )),
              label: 'alarms',
            ),
            BottomNavigationBarItem(
                backgroundColor: const Color.fromARGB(255, 33, 33, 33),
                icon: (SvgPicture.asset(
                  'assets/icons/timer.svg',
                  color: cubit.screenIndex == 2 ? Colors.orange : Colors.grey,
                  height: cubit.screenIndex == 2 ? 30 : 20,
                )),
                label: 'timer'),
            BottomNavigationBarItem(
                backgroundColor: const Color.fromARGB(255, 33, 33, 33),
                icon: (SvgPicture.asset(
                  'assets/icons/stopwatch.svg',
                  color: cubit.screenIndex == 3 ? Colors.orange : Colors.grey,
                  height: cubit.screenIndex == 3 ? 30 : 20,
                )),
                label: 'stop watch'),
          ],
          elevation: 0,
          selectedIconTheme: const IconThemeData(size: 30),
          unselectedIconTheme: const IconThemeData(size: 20),
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.orange,
          unselectedFontSize: 12,
          selectedFontSize: 14,
          currentIndex: cubit.screenIndex,
          onTap: (index) {
            AppCubit.get(context).changeScreen(index);
          },
        ),
        appBar: AppBar(
          actions: cubit.screenIndex == 1
              ? [
                  IconButton(
                      onPressed: () async {
                        titleController.text = 'Alarm';
                        date = DateTime.now();
                        await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return BlocProvider(
                                  create: (context) =>
                                      AppCubit(InitialAppState()),
                                  child: AddAlarm(
                                      titleController: titleController,
                                      date: date));
                            }).then((value) {
                          cubit.updateList();
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.orange,
                        size: 35,
                      ))
                ]
              : null,
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(cubit.title[cubit.screenIndex]),
        ),
        body: cubit.screens[cubit.screenIndex],
      );
    });
  }

  Future buidBottmSheet(context) async {
    titleController.text = 'Alarm';
    date = DateTime.now();
    await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return AddAlarm(titleController: titleController, date: date);
        });
  }
}
