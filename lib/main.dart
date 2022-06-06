
import 'package:flutter/material.dart';
import 'package:flutter_notes/ui/home.dart';
import 'package:flutter_notes/utils/note_db_helper.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'ui/home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Toast三方库包裹最外层
    return OKToast(
        child: MaterialApp(
          title: '日记本',
          theme: ThemeData(

            primarySwatch: Colors.grey,
          ),
          home: const MyHomePage(),
        ),
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      radius: 20,
      position: ToastPosition.bottom,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 默认选中第一项
  int _selectedIndex = 0;
  var _pageController = new PageController(initialPage: 0);



  @override
    void initState() {
      super.initState();
      _pageController.addListener(() {
        print(_pageController.position);
    });

    }



  //

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:_buildBody(context),
      );
  }

  //构建页面主体
  _buildBody(BuildContext context) {
    //SafeArea包裹，保证不会在刘海屏等屏幕下出现裁剪、适配
    return SafeArea(
        child: Stack(
          children: <Widget>[
            //PageView实现引导页页面切换
            PageView(
              //监听控制类
              controller: _pageController,
              onPageChanged: _onSelectChanged,
              children: <Widget>[
                //引导页第一个页面
                Container(
                  color: Color.fromRGBO(232, 229, 222, 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          '每一天都是电影',
                        style: TextStyle(
                          color: Color.fromRGBO(132, 112, 101, 1),
                          fontSize: 22,
                        ),

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '记录精彩的生活，让每一天都有所回忆',
                        style: TextStyle(
                          color: Color.fromRGBO(66, 84, 94, 1),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                //引导页第二个页面
                Container(
                  color: Color.fromRGBO(232, 229, 222, 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '简约至尚',
                        style: TextStyle(
                          color: Color.fromRGBO(72, 186, 249, 1),
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        '从内到外力求简约、精美、个性......',
                        style: TextStyle(
                          color: Color.fromRGBO(66, 84, 94, 1),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                //引导页第三个页面
                Container(
                  color: Color.fromRGBO(232, 229 , 222, 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '此刻，回忆独一无二',
                        style: TextStyle(
                          color: Color.fromRGBO(98, 95, 78, 1),
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: (){
                          toPage(context);

                        },
                        child: Text(
                          '开始体验之旅>>',
                          style: TextStyle(
                            color: Color.fromRGBO(66, 84, 94, 1),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //绘制引导页的三个圆点指示器
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (_selectedIndex == 0)?Colors.white70:Colors.black12,
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (_selectedIndex == 1)?Colors.white70:Colors.black12,
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (_selectedIndex == 2)?Colors.white70:Colors.black12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }

  void _onSelectChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 切换
  void setPageViewItemSelect(int indexSelect) {
    _pageController.animateToPage(indexSelect,
        duration: const Duration(milliseconds: 300 ), curve: Curves.ease);
  }

  toPage(BuildContext context) {

    //跳转并关闭当前页面
     Navigator.of(context).pushAndRemoveUntil(
         MaterialPageRoute(builder: (context){
           return HomePage();
         }),
             (route) =>route == null,
     );



  }










}
