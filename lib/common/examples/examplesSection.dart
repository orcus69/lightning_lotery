import 'package:flutter/material.dart';
import 'package:lightning_lotery/common/examples/components/lightininProcess.dart';
import 'package:lightning_lotery/utils/screenHelper.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

final List<LightningProcess> lightningProcess = [
  LightningProcess(title: "PAYMENT", imagePath: "money.png", subtitle: "Payments are maded through lightning network"),
  LightningProcess(title: "BITCOIN", imagePath: "bitcoin.png", subtitle: "All rewards are pay in Bitcoin"),
  LightningProcess(title: "FREE", imagePath: "free.png", subtitle: "Play for free and win rewards"),
  LightningProcess(title: "Lightning Network", imagePath: "lightning.png", subtitle: "A decentralized network using smart contract functionality in the blockchain of Bitcoin"),
];

class ExamplesSection extends StatelessWidget {
  const ExamplesSection({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ScreenHelper(
        desktop:  _buildUi(context, 1000),
        tablet:   _buildUi(context, 760),
        mobile:   _buildUi(context, MediaQuery.of(context).size.width * .8),
      ),
      
    );
  }

  Widget _buildUi(BuildContext context, double width){
    return ResponsiveWrapper(
      maxWidth: width,
      minWidth: width,
      defaultScale: false,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50,),

          Container(
            child: LayoutBuilder(
              builder: (_context, constrains){
                return ResponsiveGridView.builder(
                  padding: EdgeInsets.all(0.0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  alignment: Alignment.topCenter,
                  gridDelegate: ResponsiveGridDelegate(
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    maxCrossAxisExtent: ScreenHelper.isTablet(context) || ScreenHelper.isMobile(context) ? constrains.maxWidth/2.0 : 250,
                    childAspectRatio: ScreenHelper.isDesktop(context) ? 1 : MediaQuery.of(context).size.aspectRatio * 1.5,
                  ), 
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                lightningProcess[index].imagePath,
                                width: 40.0,
                              ),

                              SizedBox(width: 15.0,),

                              Text(
                                lightningProcess[index].title,
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)
                              ),
                            ],
                          ),

                          SizedBox(height: 20.0,),

                          Text(
                            lightningProcess[index].subtitle,
                            style: TextStyle(color: Colors.yellow[700], fontSize: 14, height: 1.5)
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: lightningProcess.length,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}