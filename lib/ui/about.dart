import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
        title: Text('关于'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            FlutterLogo(
              size: 100.0,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15.9),
              padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
              constraints: BoxConstraints(
                maxHeight: double.infinity,
                minHeight: 50,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: Divider.createBorderSide(
                    context,color: Colors.grey,width: 0.6,
                  ),
                ),
              ),
              child: Row(
                //为了数字类文字居中
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('作者：xxx'),

                ],
              ),
            ),
            SizedBox(height: 10,),
            Text(
              '综合实践：实现一个简单的日记本',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
