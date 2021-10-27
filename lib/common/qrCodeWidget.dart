import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QrcodeWidget extends StatefulWidget {
  const QrcodeWidget({ Key? key, required this.response}) : super(key: key);

  final Response response;

  @override
  _QrcodeWidgetState createState() => _QrcodeWidgetState();
}

class _QrcodeWidgetState extends State<QrcodeWidget> {
  @override
  Widget build(BuildContext context) {

    var response = widget.response;
    var paymentRequest = response.data['invoice']['payment_request'];

    Uint8List bytes = Base64Codec().decode(response.data['QRBASE64']);


    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '''Código da Transação''',
            overflow: TextOverflow.visible,
            style: TextStyle(
              height: 1.171875,
              fontSize: 18.0,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              color: Colors.black,

              /* letterSpacing: 0.0, */
            ),
          ),
          SizedBox(height: 8,),
          //QR CODE
          Container(
            width: 266.0,
            height: 247.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.memory(bytes,fit: BoxFit.contain,),
            ),
          ),
          SizedBox(height: 8,),

          //CODIGO GERADO
          
          Container(
            width: 310,
            height: 100,
            child: Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  "${paymentRequest}", 
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Roboto',
                    color: Colors.black,
                    /* letterSpacing: 0.0, */
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8,),
          //COPIAR CODIGO
          GestureDetector(
            onTap: (){ 
              Clipboard.setData(ClipboardData(text: paymentRequest.toString()));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Copiado para a área de transfêrencia!"),
                  backgroundColor: Colors.blueAccent,
                )
              );
            },
            child: Text(
              '''Copiar''',
              overflow: TextOverflow.visible,
              style: TextStyle(
                height: 1.171875,
                fontSize: 18.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 0, 163, 255),
          
                /* letterSpacing: 0.0, */
              ),
            ),
          )
        ],
      ),
    );
  }
}