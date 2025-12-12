import 'package:flutter/material.dart';

class Maindrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, // 보통 기본값을 없애버리는 것.
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.blue),
                ),
                SizedBox(height: 10),
                Text(
                  'shin.jinwoo@ourhome.co.kr',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('my Info'),
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Myinfoscreen()));
              Navigator.pushNamed(context, '/myinfo');
            },
          ),
          ListTile(
            leading: Icon(Icons.one_k),
            title: Text('dio'),
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Myinfoscreen()));
              Navigator.pushNamed(context, '/dio');
            },
          ),
          ListTile(
            leading: Icon(Icons.gamepad),
            title: Text('provider'),
            onTap: () {
              Navigator.pushNamed(context, '/provider');
            },
          ),
          ListTile(
            leading: Icon(Icons.blind),
            title: Text('bloc'),
            onTap: () {
              Navigator.pushNamed(context, '/bloc');
            },
          ),
        ],
      ),
    );
  }
}
