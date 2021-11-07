import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lightning_lotery/models/carousel/carouselItemModel.dart';
import 'package:lightning_lotery/pages/home.dart';

List<CarouselItemModel> carouselItems = List.generate(
  5, 
  (index) => CarouselItemModel(
    text: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          

          Text("LIGHTNING",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 40.0,
              height: 1.3,
            ),
          ),
          Text("LOTTERY",
            style: TextStyle(
              color: Colors.yellow[700],
              fontWeight: FontWeight.w900,
              fontSize: 40.0,
              height: 1.3,
            ),
          ),

          SizedBox(
            height: 18.0,
          ),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Loteria utilizando a rede lightning de pagamentos via ",
                  style: TextStyle(color: Colors.green, fontSize: 20.0)
                ),
                TextSpan(
                  text: "BITCOIN",
                  style: TextStyle(color: Colors.yellow[700], fontFamily: 'italic', fontSize: 20.0)
                )
              ]
            ),
          ),

          SizedBox(
            height: 10.0,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Faça um jogo de no minimo 6 numeros e receba o prêmio em ",
                  style: TextStyle(color: Colors.white, fontSize: 16.0)
                ),
                TextSpan(
                  text: "BITCOIN",
                  style: TextStyle(color: Colors.yellow[700], fontFamily: 'italic', fontSize: 16.0)
                )
              ]
            ),
          ),


        ],
      ),
    ), 
    
    side: Home()
  )

).toList();