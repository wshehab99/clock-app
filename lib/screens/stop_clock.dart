import 'package:clockapp/bloc/app_cubit.dart';
import 'package:clockapp/bloc/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StopWatchScreen extends StatelessWidget {
  const StopWatchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  cubit.format,
                  style: const TextStyle(color: Colors.white, fontSize: 56),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        cubit.isRunning
                            ? TextButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(70),
                                        side: const BorderSide(
                                            color: Colors.orange))),
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                        const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 25))),
                                onPressed: () {
                                  cubit.stop();
                                },
                                child: const Text(
                                  'stop',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ))
                            : TextButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(70),
                                            side: const BorderSide(color: Colors.orange))),
                                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 5, vertical: 25))),
                                onPressed: () {
                                  cubit.start();
                                },
                                child: const Text(
                                  'start',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                        TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty
                                    .all<OutlinedBorder>(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(70),
                                        side:
                                            BorderSide(color: Colors.orange))),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 25))),
                            onPressed: () {
                              cubit.reset();
                            },
                            child: const Text(
                              'reset',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                      ]),
                ),
              ]);
        },
        listener: (context, states) {});
  }
}
