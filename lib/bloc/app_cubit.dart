import 'package:clockapp/bloc/app_states.dart';
import 'package:clockapp/screens/clock_screen.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../screens/alarm_list.dart';
import '../screens/stop_clock.dart';
import '../screens/timer.dart';
import 'dart:async';

class AppCubit extends Cubit<AppStates> {
  AppCubit(AppStates initialState) : super(InitialAppState());
  static AppCubit? cubit;
  static AppCubit get(context) {
    cubit ??= BlocProvider.of(context);
    return cubit!;
  }

  CustomTimerController? controller;
  bool isTimerRunnig = false;
  Duration? initialTime;
  Duration? dateTime;
  int millSec = 1000;
  int sec = 0;
  int hour = 0;
  List screens = [
    const ClockScreen(),
    AlarmList(),
    TimerScreen(),
    const StopWatchScreen(),
  ];
  List title = [
    "Clock",
    ' Alarms',
    "Timer",
    "Stop Watch",
  ];
  List alarms = [];
  List shownAlarms = [];
  var date;
  int screenIndex = 0;
  Stopwatch stopwatch = Stopwatch();
  bool isRunning = false;
  String format = "00 : 00 , 00";
  String? timerFormat;
  void start() {
    isRunning = true;
    stopwatch.start();
    Timer(const Duration(milliseconds: 1), runnig);
    emit(StartStopWatch());
  }

  void stop() {
    isRunning = false;
    stopwatch.stop();
    emit(StopStopWatch());
  }

  void reset() {
    stop();
    stopwatch.reset();

    format = "00 : 00 , 00";
    emit(ResetStopWatch());
  }

  void runnig() {
    if (stopwatch.isRunning) {
      start();
    }

    format = (stopwatch.elapsed.inMinutes).toString().padLeft(2, "0") +
        " : " +
        (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0") +
        " , " +
        (stopwatch.elapsed.inMilliseconds % 100).toString().padLeft(2, "0");
    emit(KeepRunning());
  }

  void updateList() {
    shownAlarms = alarms;
    emit(UpdateAlarmList());
  }

  void addAlarm(String title, DateTime date) {
    alarms.add({
      'title': title,
      'time': DateFormat.Hm().format(date),
      'value': true,
    });
    print(alarms);
    emit(AddAlarmToAlarmList());
    updateList();
  }

  void changeScreen(index) {
    screenIndex = index;
    emit(ChangeNavigationBarScreen());
  }

  DateTime changeTime(value) {
    date = value;

    emit(ChangeDate());
    return date;
  }

  void removeFromAlarmsList(index) {
    alarms.removeAt(index);
    emit(RemoveFromAlarmsList());
  }

  void insertAlarmsList(index, String title, DateTime date) {
    alarms.insert(index, {
      'title': title,
      'time': DateFormat.Hm().format(date),
      'value': true,
    });
    emit(InsertAlarmsList());
    removeFromAlarmsList(index + 1);
    updateList();
  }

  void changeSwitchValue(index, value) {
    alarms[index]['value'] = value;
    emit(ChangeSwitchValue());
    updateList();
  }

  Duration changeTimer(value) {
    initialTime = value;

    emit(ChangeTimer());
    return initialTime!;
  }

  void startTimer() {
    controller ??= CustomTimerController();

    isTimerRunnig = true;
    controller!.start();
    dateTime = initialTime;
    emit(StartTimer());
  }

  void pauseTimer() {
    isTimerRunnig = false;
    controller!.pause();
    emit(PauseTimer());
  }

  void resetTimer() {
    dateTime = initialTime;
    emit(ResetTimer());
  }

  void cancelTimer() {
    isTimerRunnig = false;

    controller = null;
    initialTime = null;
    dateTime = null;
    emit(CancelTimer());
  }
}
