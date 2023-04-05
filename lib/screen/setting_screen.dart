import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Setting',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'Setting for setup your app',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Reminder',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.black87,
                        ),
                  ),
                ),
                Switch(value: true, onChanged: (value) {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}
