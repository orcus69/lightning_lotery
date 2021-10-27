import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {

  final String text;
  final Color ?color;
  final Color ?textColor;
  final VoidCallback onClicked;
  final bool? isLoading;
  final bool? isSelected;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    this.color,
    this.textColor,
    this.isLoading = false,
    this.isSelected = false
    }
    
  ):super(key: key);

  @override
  Widget build(BuildContext context){

    
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: isSelected! ? Colors.blue: color,
        minimumSize: Size.square(5),
        shape: StadiumBorder()
      ),
      child: FittedBox(
        child: isLoading! ? CircularProgressIndicator(color: Colors.white,) : Text(
          text, 
          style: TextStyle(fontSize: 20, color: textColor),
        ),
      ),
      onPressed: onClicked,
    );

  }
}