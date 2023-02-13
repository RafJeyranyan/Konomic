import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konomic/core/style.dart';

class KonanicScreen extends StatelessWidget {
  const KonanicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:  AppColors. backGround,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Choose tokens'),
        centerTitle: true,
        backgroundColor: AppColors.appBar,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            /// Token A
            TokenWidget(text: 'Token A', avatar: Colors.deepOrange),
            // SizedBox(height: 20),
            /// Arrow down
            Icon(Icons.arrow_downward_rounded, size: 30),
            // SizedBox(height: 20),
            /// Token A
            TokenWidget(text: 'Token B', avatar: Colors.pinkAccent),
          ],
        ),
      ),
    );
  }
}

// =============================================================================/// Widgets
class TokenWidget extends StatelessWidget {
  final String text;

  // Later Must be an Image
  final Color avatar;

  const TokenWidget({
    Key? key,
    required this.text,
    required this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CupertinoButton(
      onPressed: () {
        dialogBox(context: context, items: tokens);
      },
      child: Container(
        width: size.width * 0.9,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),

            /// Image
            CircleAvatar(
              backgroundColor: avatar,
              child: Text(
                text[text.length - 1].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 20),

            /// Text
            Text(
              text,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> tokens = [
  'Bitcoin',
  'USD',
  'RUB',
  'AMD',
];
// =============================================================================
dynamic dialogBox({required BuildContext context, required List items}) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24.0))),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildList(context: context, items: items),
            ],
          ),
        ),
      );
    },
  );
}

Widget buildList({required BuildContext context, required List items}) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: items.length,
    itemBuilder: (context, index) => ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.blueGrey,
        ),
      ),
      child: Text(
        items[index],
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}
