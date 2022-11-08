import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/models/ShPaymentCard.dart';
import 'package:shop_order/utils/ShColors.dart';
import 'package:shop_order/utils/ShConstant.dart';
import 'package:shop_order/utils/ShStrings.dart';
import 'package:shop_order/utils/ShWidget.dart';

// ignore: must_be_immutable
class ShAddCardScreen extends StatefulWidget {
  static String tag = '/ShAddCardScreen';
  ShPaymentCard? paymentCard;

  ShAddCardScreen({this.paymentCard});

  @override
  ShAddCardScreenState createState() => ShAddCardScreenState();
}

class ShAddCardScreenState extends State<ShAddCardScreen> {
  var cvvCont = TextEditingController();
  var nameCont = TextEditingController();
  var cardNumberCont = TextEditingController();
  var months = [
    "",
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12"
  ];
  var years = [
    "",
    "2020",
    "2021",
    "2022",
    "2023",
    "2024",
    "2025",
    "2026",
    "2027",
    "2028",
    "2029",
    "2030",
    "2031"
  ];
  String? selectedMonth = "";
  String? selectedYear = "";

  @override
  void initState() {
    super.initState();
    if (widget.paymentCard != null) {
      setState(() {
        cvvCont.text = widget.paymentCard!.cvv;
        nameCont.text = widget.paymentCard!.holderName;
        cardNumberCont.text = widget.paymentCard!.cardNo;
        selectedMonth = widget.paymentCard!.month;
        selectedYear = widget.paymentCard!.year;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sh_lbl_add_card, style: boldTextStyle(size: 18)),
        iconTheme: IconThemeData(
            color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(spacing_standard_new),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              headingText(sh_hint_card_number),
              16.height,
              TextFormField(
                keyboardType: TextInputType.number,
                autofocus: false,
                maxLength: 16,
                controller: cardNumberCont,
                textCapitalization: TextCapitalization.words,
                style: primaryTextStyle(),
                decoration: InputDecoration(
                    filled: false,
                    counterText: "",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(spacing_control)),
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(spacing_control)),
                        borderSide: BorderSide(color: Colors.grey, width: 0))),
              ),
              16.height,
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        headingText("Month"),
                        16.height,
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(20.0, 4.0, 8.0, 4.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(spacing_control))),
                          child: DropdownButton<String>(
                            underline: SizedBox(),
                            value: selectedMonth,
                            isExpanded: true,
                            items: months.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: primaryTextStyle()),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedMonth = newValue;
                              });
                            },
                          ),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  SizedBox(
                    width: spacing_standard_new,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        headingText("Year"),
                        SizedBox(
                          height: spacing_standard_new,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(20.0, 4.0, 8.0, 4.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(spacing_control))),
                          child: DropdownButton<String>(
                            underline: SizedBox(),
                            value: selectedYear,
                            isExpanded: true,
                            items: years.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: primaryTextStyle()),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedYear = newValue;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              16.height,
              headingText(sh_lbl_cvv),
              16.height,
              TextFormField(
                keyboardType: TextInputType.number,
                autofocus: false,
                controller: cvvCont,
                maxLength: 3,
                obscureText: true,
                textCapitalization: TextCapitalization.words,
                style: primaryTextStyle(),
                decoration: InputDecoration(
                    filled: false,
                    counterText: "",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(spacing_control)),
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(spacing_control)),
                        borderSide: BorderSide(color: Colors.grey, width: 0))),
              ),
              16.height,
              headingText(sh_hint_card_holder_name),
              16.height,
              TextFormField(
                keyboardType: TextInputType.text,
                autofocus: false,
                controller: nameCont,
                textCapitalization: TextCapitalization.words,
                style: primaryTextStyle(),
                decoration: InputDecoration(
                    filled: false,
                    counterText: "",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(spacing_control)),
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(spacing_control)),
                        borderSide: BorderSide(color: Colors.grey, width: 0))),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                // height: double.infinity,
                child: MaterialButton(
                  padding: EdgeInsets.all(spacing_standard),
                  child: text(sh_lbl_add_card,
                      fontSize: textSizeNormal,
                      fontFamily: fontMedium,
                      textColor: sh_white),
                  textColor: sh_white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(40.0)),
                  color: sh_colorPrimary,
                  onPressed: () => {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
