import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});


  Stream<String> getLoadingMessages () {
    final messages = <String>[
      'Welcome to APP_NAME :)',
      'Please wait...',
      'Loading data...',
    ];
    return Stream.periodic(const Duration(seconds: 1), (step) {
      return messages[step];
    }).take(messages.length);

  }
  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme;
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(stream: getLoadingMessages(), 
          builder: (context, snapshot) {
            if(!snapshot.hasData) return Text('Loading...', style: titleStyle.titleMedium,);
            return Text(snapshot.data!, style: titleStyle.titleMedium);
          }),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 3)
        ],
      ),
    );
  }
}