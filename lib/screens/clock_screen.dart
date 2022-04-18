import 'package:analog_clock/analog_clock.dart';
import 'package:clockapp/bloc/app_cubit.dart';
import 'package:clockapp/bloc/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClockScreen extends StatelessWidget {
  const ClockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Center(
            child: AnalogClock(
          decoration: const BoxDecoration(
              color: Colors.transparent, shape: BoxShape.circle),
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width,
          isLive: true,
          secondHandColor: Colors.orange,
          hourHandColor: Colors.white,
          minuteHandColor: Colors.white,
          showAllNumbers: true,
          showSecondHand: true,
          numberColor: Colors.white,
          showNumbers: true,
          textScaleFactor: 1.15,
          showTicks: true,
          digitalClockColor: Colors.white,
          showDigitalClock: true,
          datetime: DateTime.now(),
        ));
      },
    );
  }
}
