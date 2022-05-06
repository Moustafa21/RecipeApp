import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'sizeConfig.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Special(
                      img: "images/download.jpg",
                      txt: 'Egyptian',
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(20),
                    ),
                    Special(
                      img: "images/download.jpg",
                      txt: 'amercan',
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(20),
                    ),
                    Special(
                      img: "images/download.jpg",
                      txt: 'asian',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Special extends StatelessWidget {
  const Special({
    required this.img,
    required this.txt,
    Key? key,
  }) : super(key: key);
  final String img, txt;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: getProportionateScreenWidth(242),
        height: getProportionateScreenWidth(100),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.asset(
                img,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //           begin: Alignment.topCenter,
              //           end: Alignment.bottomCenter,
              //           colors: [
              //         Colors.teal.withOpacity(0.4),
              //         Colors.teal.withOpacity(.15),
              //       ])),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15),
                    vertical: getProportionateScreenHeight(10)),
                child: Text.rich(
                    TextSpan(style: TextStyle(color: Colors.white), children: [
                  TextSpan(
                      text: "$txt\n",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(18.0),
                          fontWeight: FontWeight.bold)),
                  TextSpan(text: '100 food')
                ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
