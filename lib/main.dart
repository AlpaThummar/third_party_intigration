import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:currency_picker/currency_picker.dart';
void main(){

  runApp(MaterialApp(home: intigration(),));
}
class intigration extends StatefulWidget {
  const intigration({Key? key}) : super(key: key);

  @override
  State<intigration> createState() => _intigrationState();
}

class _intigrationState extends State<intigration> {
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();
  String rate="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Currancy Converter"),),
      body: Column(children: [
        TextField(controller: t1,decoration: InputDecoration(hintText: "Enter Amount"),),
        TextField(onTap: () {
          showCurrencyPicker(
            context: context,
            showFlag: true,
            showCurrencyName: true,
            showCurrencyCode: true,
            onSelect: (Currency currency) {
              t2.text=currency.code;
              print('Select currency: ${currency.name}');
            },
          );
        },controller: t2,decoration: InputDecoration(hintText: "from"),),
        TextField(onTap: () {
          showCurrencyPicker(
            context: context,
            showFlag: true,
            showCurrencyName: true,
            showCurrencyCode: true,
            onSelect: (Currency currency) {
              t3.text=currency.code;
              print('Select currency: ${currency.name}');
            },
          );

        },controller: t3,decoration: InputDecoration(hintText: "to"),),
        ElevatedButton(onPressed: () async {
          String amount,to,from;
          amount=t1.text;
          from=t2.text;
          to=t3.text;

          var url = Uri.parse('https://demo2811.000webhostapp.com/currency.php');
          var response = await http.post(url, body: {'from': '$from', 'to': '$to','amount': '$amount'});
          print('Response status: ${response.statusCode}');
          print('Response body: ${response.body}');

          Map m=jsonDecode(response.body);
          print(m['info']['rate']);
         // rate=m['info']['rate'].toString();
          rate=m['result'].toString();

          setState(() {});
        }, child: Text("Submit")),
        Container(child: Text("Amount: ${rate}"),)
      ]),
    );
  }
}
