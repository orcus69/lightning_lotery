import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lightning_lotery/common/examples/examplesSection.dart';
import 'package:lightning_lotery/common/explanation/explanation.dart';
import 'package:lightning_lotery/common/header/header.dart';
import 'package:lightning_lotery/common/carousel/carousel.dart';
import 'package:lightning_lotery/pages/home.dart';
import 'package:lightning_lotery/utils/globals.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Lightning-Lottery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: Theme.of(context).copyWith(
        platform: TargetPlatform.android,
        scaffoldBackgroundColor: Color.fromRGBO(7, 17, 26, 1),
        primaryColor: Color.fromRGBO(21, 181, 114, 1),
        canvasColor: Color.fromRGBO(7, 17, 26, 1),
      ),
      builder: (context,widget)=>ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.resize(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.resize(2460, name: "4K"),

        ],
        background: Container(
          color: Color.fromRGBO(7, 17, 26, 1),

        )
      ),
      home: MyHomePage(title: 'Lightning-Lottery'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Globals.scafoldKey,
      endDrawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index){
                return headerItem[index].isButtom ? MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 28.0),
                      child: TextButton(
                        onPressed: headerItem[index].onTap,
                        child: Text(
                          headerItem[index].title,
                          style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                : ListTile(
                  title: Text(
                    headerItem[index].title,
                    style: TextStyle(color: Colors.white,),
                  ),
                );
              }, 
              separatorBuilder: (BuildContext context, int index){
                return SizedBox(
                  height: 10.0,
                );
              }, 
              itemCount: headerItem.length
            ),
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Header
              Container(
                child: Header(),
              ),
              
              Carousel(),

              SizedBox(height: 20),

              ExamplesSection(),
              
              Explanation(),
              
            ],
          ),
        ),
      ),
    );
  }

  

}
