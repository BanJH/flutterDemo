import 'package:flutter/material.dart';
import 'package:flutter_notes/utils/note_db_helper.dart';

import 'about.dart';
import '/widget/text.dart';

class CenterPage extends StatefulWidget {
  const CenterPage({
    Key? key,
    @required this.noteDbHelper,
  }) : super(key: key);

  final NoteDbHelper? noteDbHelper;
  @override
  State<CenterPage> createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage>
  with AutomaticKeepAliveClientMixin {


  void _click(int index) {
    switch (index) {
      case 0:
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return TextPage();
    }));
    ;

        break;
      case 1:
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return AboutPage();
        }));
        break;
    }
  }














  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(244, 244, 244, 1),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          Row(
            children: <Widget>[
              SizedBox(width: 5,),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(3),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  backgroundImage:NetworkImage('https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic%2Feb%2F24%2Fd5%2Feb24d54a0c4e1f174a7a4922aaa28454.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1656905354&t=e1f86d071fc1d2997910afd37b40848b') ,
                  radius: 30.0,
                ),
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '最美的日记',
                    style: TextStyle(color: Colors.black,fontSize: 26),
                  ),
                  Text(
                    '编辑资料',
                    style: TextStyle(color: Color.fromRGBO(162, 162, 162, 1),fontSize: 18),

                  )
                ],
              ),

            ],
          ),
          SizedBox(height: 20,),
          Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Flexible(
                        child: Row(
                          children: <Widget>[
                            _buildItem(0),
                            _buildItem(1),

                          ],
                        ),
                      flex: 1,
                    ),
                    Flexible(
                        child: Row(
                          children: <Widget>[
                            _buildItem(2),
                            _buildItem(3),

                          ],
                        ),
                      flex: 1,
                    ),
                    Flexible(
                        child: Row(
                          children: <Widget>[
                            _buildItem(4),
                            _buildItem(5),
                          ],

                        ),
                      flex: 1,
                    ),
                  ],
                ),
              ),
          ),
          SizedBox(height: 10,),

        ],
      ),
    );
  }

  _buildItem(int index) {
    return Expanded(
        child: Container(
          padding: EdgeInsets.all(5),
          child: GestureDetector(
            child: Card(
              child: Container(
                padding: EdgeInsets.all(26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _icons.elementAt(index),
                    Expanded(child: Text("")),
                    _title.elementAt(index),
                    _des.elementAt(index),

                  ],
                ),
              ),
            ),
            onTap: () {

            _click(index);
            },
          ),
        ),
      flex: 1,
    );
  }




  List<Icon> _icons = [
    Icon(
      Icons.favorite,
      size: 38,
      color: Colors.yellow,
    ),
    Icon(
      Icons.lock,
      size: 38,
      color: Colors.blue,
    ),
    Icon(
      Icons.feedback,
      size: 38,
      color: Colors.blueAccent,
    ),
    Icon(
      Icons.share,
      size: 38,
      color: Colors.deepPurpleAccent,
    ),
    Icon(
      Icons.error_outline,
      size: 38,
      color: Colors.orange,
    ),
    Icon(
      Icons.settings,
      size: 38,
      color: Colors.red,
    ),
  ];

  List<Text> _title = [
    Text(
      '我的收藏',
      style: TextStyle(color: Colors.black,fontSize: 20),
    ),
    Text(
      '密码锁',
      style: TextStyle(color: Colors.black,fontSize: 20),
    ),
    Text(
      '吐槽反馈',
      style: TextStyle(color: Colors.black,fontSize: 20),
    ),
    Text(
      '分享',
      style: TextStyle(color: Colors.black,fontSize: 20),
    ),
    Text(
      '关于日记',
      style: TextStyle(color: Colors.black,fontSize: 20),
    ),
    Text(
      '系统设置',
      style: TextStyle(color: Colors.black,fontSize: 20),
    ),
  ];

  List<Text> _des = [
    Text(
      '收藏的重要日记',
      style: TextStyle(color: Color.fromRGBO(162, 162, 162, 1),fontSize: 16),
    ),
    Text(
      '设置密码锁',
      style: TextStyle(color: Color.fromRGBO(162, 162, 162, 1),fontSize: 16),
    ),
    Text(
      '吐槽反馈你的想法',
      style: TextStyle(color: Color.fromRGBO(162, 162, 162, 1),fontSize: 16),
    ),
    Text(
      '分享应用给他人',
      style: TextStyle(color: Color.fromRGBO(162, 162, 162, 1),fontSize: 16),
    ),
    Text(
      '版本信息',
      style: TextStyle(color: Color.fromRGBO(162, 162, 162, 1),fontSize: 16),
    ),
    Text(
      '系统相关设置',
      style: TextStyle(color: Color.fromRGBO(162, 162, 162, 1),fontSize: 16),
    ),
  ];












  @override
  bool get wantKeepAlive => true;
}
