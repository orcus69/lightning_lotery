import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lightning_lotery/common/carousel/components/carouselItem.dart';
import 'package:lightning_lotery/utils/screenHelper.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class Carousel extends StatelessWidget {
  CarouselController carouselControler = CarouselController();

  @override
  Widget build(BuildContext context) {
    double carouselContainerHeight = MediaQuery.of(context).size.height * (ScreenHelper.isMobile(context) ? .7 : .85);

    return Container(
      height: carouselContainerHeight,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: CarouselSlider(
              carouselController: carouselControler,
              options: CarouselOptions(
                //autoPlay: true,
                viewportFraction: 1,
                scrollPhysics: NeverScrollableScrollPhysics(),
                height: carouselContainerHeight
              ),
              items: List.generate(5, (index) => Builder(
                builder: (BuildContext context){
                  return Container(
                    constraints: BoxConstraints(
                      minHeight: carouselContainerHeight
                    ),
                    child: ScreenHelper(
                      desktop: _buildDesktop(context, carouselItems[index].text, carouselItems[index].side),
                      tablet: _buildTablet(context, carouselItems[index].text, carouselItems[index].side),
                      mobile: _buildMobile(context, carouselItems[index].text, carouselItems[index].side),
                    ),
                  );
                },
              )).toList(),
            ),
          )
        ],
      ),
    );
  }


  ///Desktop layout
  Widget _buildDesktop(BuildContext context, Widget text, Widget side){
    return Center(
      child: ResponsiveWrapper(
        maxWidth: 1000.0,
        minWidth: 1000.0,
        defaultScale: false,
        child: Row(
          children: [
            Expanded(child: text),
            Expanded(child: side)
          ],
        ),
      ),
    );
  }

  ///Tablet layout
  Widget _buildTablet(BuildContext context, Widget text, Widget side){
    return Center(
      child: ResponsiveWrapper(
        maxWidth: 760.0,
        minWidth: 760.0,
        defaultScale: false,
        child: Row(
          children: [
            Expanded(child: text),
            Expanded(child: side)
          ],
        ),
      ),
    );
  }

  ///Mobile layout
  Widget _buildMobile(BuildContext context, Widget text, Widget side){
    return Container(
      padding: EdgeInsets.only(top: 16.0),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.height * .8,
      ),
      width: double.infinity,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          Container(child: text),
          Container(child: side)
        ],
      ),
    );
  }
}