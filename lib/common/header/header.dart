import 'package:flutter/material.dart';
import 'package:lightning_lotery/models/header/headerItems.dart';
import 'package:lightning_lotery/utils/globals.dart';
import 'package:lightning_lotery/utils/screenHelper.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_value.dart';

List<HeaderItem> headerItem = [
  HeaderItem(title: "Home", onTap: (){},),
  HeaderItem(title: "Roadmap", onTap: (){},),
  HeaderItem(title: "Sobre", onTap: (){},),
  HeaderItem(title: "Start", onTap: (){}, isButtom: true,),
];

//Logo do cabeçalho
class HeaderLogo extends StatelessWidget {
  const HeaderLogo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: (){},
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Lightining ",
                  style: TextStyle(color: Colors.white, fontSize: 32.0)
                ),
                TextSpan(
                  text: "Lottery",
                  style: TextStyle(color: Colors.yellow[700], fontFamily: 'italic', fontSize: 30.0)
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}

//Itens do menu
class HeaderRow extends StatelessWidget {
  const HeaderRow({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveVisibility(
      visible: false,
      visibleWhen: [
        Condition.largerThan(name: MOBILE),
      ],
      child: Row(
        children: headerItem.map((item) => item.isButtom ? MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.yellow[700],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextButton(
              onPressed: item.onTap,
              child: Text(
                item.title, 
                style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ) : MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            margin: EdgeInsets.only(right: 30.0),
            child: GestureDetector(
              onTap: item.onTap,
              child: Text(
                item.title,
                style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )).toList(),
      ),

    );
  }
}

class Header extends StatelessWidget {
  const Header({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScreenHelper(
        desktop: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: buildHeader(),
        ),
        mobile: buildMobileHeader(),
        tablet: buildHeader(),
      ),
    );
  }

  //Menu mobile
  Widget buildMobileHeader(){
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeaderLogo(),

            GestureDetector(
              onTap: (){
                Globals.scafoldKey.currentState!.openEndDrawer();
              },
              child: Icon(Icons.menu_sharp, color: Colors.white, size: 28.0,),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeader(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeaderLogo(),
          HeaderRow(),
        ],
      ),
    );
  }
}