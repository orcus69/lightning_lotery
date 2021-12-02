import 'package:flutter/material.dart';
import 'package:lightning_lotery/utils/screenHelper.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class Explanation extends StatelessWidget {
  const Explanation({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScreenHelper(
        desktop:  _buildUi(1000.0),
        tablet:   _buildUi(760.00),
        mobile:   _buildUi(MediaQuery.of(context).size.width* .8),
      ),
    );
  }

  Widget _buildUi(double width){
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints){
          return ResponsiveWrapper(
            maxWidth: width,
            minWidth: width,
            defaultScale: false,
            child: Container(
              child: Flex(
                direction: constraints.maxWidth > 720 ? Axis.horizontal : Axis.vertical,
                children: [
                  //lado de imagem
                  Expanded(
                    flex: constraints.maxWidth > 720 ? 1 : 0,
                    child: Image.asset(
                      "assets/bitcoin.png",
                      width: constraints.maxWidth > 720 ? null : 350,
                    )
                  ),
                  
                  SizedBox(width: 20.0,),

                  //Lado de texto
                  Expanded(
                    flex: constraints.maxWidth > 720 ? 1 : 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sobre',
                          style: TextStyle(color: Colors.yellow[700], fontWeight: FontWeight.bold, fontSize: 16.0)
                        ),

                        SizedBox(height: 15.0,),

                        Text(
                          'Loteria online usando\nBITCOIN',
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w900, height: 1.3, fontSize: 35.0)
                        ),

                        SizedBox(height: 15.0,),

                        Text(
                          'O sistema lightining lottery é baseado na rede lightning de pagamento usando bitcoin, todos os sorteios são pagos diretamente na sua carteira bitcoin automaticamente e de forma 100% gratuita, faça seu primeiro jogo!',
                          style: TextStyle(color: Colors.white, height: 1.5, fontSize: 15.0)
                        ),

                        SizedBox(height: 25.0,),

                        Row(
                          children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.yellow[700],
                                  borderRadius: BorderRadius.circular(8.0)
                                ),
                                height: 48.0,
                                padding: EdgeInsets.symmetric(horizontal: 28),

                                child: TextButton(
                                  onPressed: (){},
                                  child: Center(
                                    child: Text(
                                      "Jogue agora!",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.0)
                                    ),
                                  ),
                                )
                              ),
                            ),

                          ],
                        ),
                      ],

                    ),
                  )
                ]
              ),
            ),
          );
        },
      )
    );
  }
}