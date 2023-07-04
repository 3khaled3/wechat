import 'package:flutter/material.dart';
import 'package:wechat/views/groupchat.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    Key? key,
  }) : super(key: key);
  final String groupimage =
      "https://firebasestorage.googleapis.com/v0/b/wechat-d43c1.appspot.com/o/group.jpg?alt=media&token=cbe5f4af-a23c-4a35-b7aa-3c471fb8cde0";
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupchatScreen(
                imageurl: groupimage, displayname: "Public Chat"),
          ),
        );
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xff161c16),
        ),
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 40)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      // ignore: unnecessary_cast
                      NetworkImage(groupimage) as ImageProvider<Object>,
                  radius: 35,
                ),
                const SizedBox(
                  width: 18,
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Public Chat",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
