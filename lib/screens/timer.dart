import 'package:clockapp/bloc/app_cubit.dart';
import 'package:clockapp/bloc/app_states.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              cubit.dateTime != null
                  ? SizedBox(
                      height: 200,
                      child: Center(
                        child: CustomTimer(
                          controller: cubit.controller,
                          begin: cubit.dateTime!,
                          end: const Duration(),
                          builder: (time) {
                            return Text(
                              time.hours.toString() +
                                  " : " +
                                  time.minutes.toString() +
                                  " : " +
                                  time.seconds.toString() +
                                  " , " +
                                  time.milliseconds.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 40),
                            );
                          },
                          animationBuilder: (child) {
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: child,
                            );
                          },
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 200,
                      child:
                          CupertinoTimerPicker(onTimerDurationChanged: (value) {
                        cubit.initialTime = cubit.changeTimer(value);
                      }),
                    ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cubit.dateTime == null
                        ? TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(70),
                                        side: const BorderSide(
                                            color: Colors.orange))),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 25))),
                            onPressed: () {
                              cubit.startTimer();
                            },
                            child: const Text("Start",
                                style: TextStyle(color: Colors.white)))
                        : cubit.isTimerRunnig
                            ? TextButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(70), side: const BorderSide(color: Colors.orange))),
                                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 5, vertical: 25))),
                                onPressed: () {
                                  cubit.pauseTimer();
                                },
                                child: const Text("Pause", style: TextStyle(color: Colors.white)))
                            : TextButton(
                                style: ButtonStyle(shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(70), side: const BorderSide(color: Colors.orange))), padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 5, vertical: 25))),
                                onPressed: () {
                                  cubit.startTimer();
                                },
                                child: const Text("Resume", style: TextStyle(color: Colors.white))),
                    TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(70),
                                    side: const BorderSide(
                                        color: Colors.orange))),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 25))),
                        onPressed: cubit.dateTime == null
                            ? null
                            : () {
                                cubit.cancelTimer();
                              },
                        child: Text("Cancel",
                            style: TextStyle(
                                color: cubit.dateTime == null
                                    ? Colors.grey[700]
                                    : Colors.white))),
                  ],
                ),
              )
            ],
          );
        },
        listener: (context, states) {});
  }
}
