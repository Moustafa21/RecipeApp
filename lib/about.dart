import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final Uri MoGit = Uri.parse('https://github.com/Moustafa21');
  final Uri MoIN =
      Uri.parse('https://www.linkedin.com/in/mostafa-magdy-01ab34180/');
  final String MoGM = 'tatamagdy2@gmail.com';
  final String MoNO = '01157392619';
  final Uri MsGit = Uri.parse('https://github.com/MahmodSamir');
  final Uri MsIN =
      Uri.parse('https://www.linkedin.com/in/mahmoud-samir-a786a1214/');
  final String MsGM = 'mahmoudasmirms01@gmail.com@gmail.com';
  final String MsNO = '01113189795';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "عنا",
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Color(0xff174354),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, top: 20, bottom: 60),
            child: Column(children: [
              Image(
                image: AssetImage("assets/MealBoard.png"),
                height: 80,
                width: 80,
              ),
              Divider(
                height: 10,
                color: Colors.grey[200],
              ),
              Text(
                "\nAre you into trying new foods? MealBoard helps you to find something different from all around the world.",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ]),
          ),
          Divider(
            height: 10,
            indent: 40,
            endIndent: 40,
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Row(children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30, bottom: 20),
                    child: Text(
                      "MAHMOUD",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
                    ),
                  ),
                  Row(children: [
                    Padding(padding: EdgeInsets.only(left: 10, right: 10)),
                    InkWell(
                        child: Icon(
                          SimpleIcons.gmail,
                          size: 25,
                          color: Colors.red[800],
                        ),
                        onTap: () => sendMailMs()),
                    Padding(padding: EdgeInsets.only(left: 10, right: 10)),
                    InkWell(
                      child: Icon(SimpleIcons.whatsapp,
                          size: 25, color: Colors.green[700]),
                      onTap: () => makePhoneCall(MsNO),
                    ),
                  ]),
                  Divider(
                    height: 10,
                  ),
                  Row(children: [
                    Padding(padding: EdgeInsets.only(left: 10, right: 10)),
                    InkWell(
                        child: Icon(
                          SimpleIcons.github,
                          size: 25,
                        ),
                        onTap: () => launchURL(MsGit)),
                    Padding(padding: EdgeInsets.only(left: 10, right: 10)),
                    InkWell(
                        child: Icon(
                          SimpleIcons.linkedin,
                          size: 25,
                          color: Colors.blue[900],
                        ),
                        onTap: () => launchURL(MsIN))
                  ])
                ],
              ),
              VerticalDivider(
                width: 50,
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, bottom: 20),
                    child: Text(
                      "MOUSTAFA",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
                    ),
                  ),
                  Row(children: [
                    Padding(padding: EdgeInsets.only(left: 10, right: 10)),
                    InkWell(
                        child: Icon(
                          SimpleIcons.gmail,
                          size: 25,
                          color: Colors.red[800],
                        ),
                        onTap: () => sendMailMO()),
                    Padding(padding: EdgeInsets.only(left: 10, right: 10)),
                    InkWell(
                      child: Icon(
                        SimpleIcons.whatsapp,
                        size: 25,
                        color: Colors.green[700],
                      ),
                      onTap: () => makePhoneCall(MoNO),
                    ),
                  ]),
                  Divider(
                    height: 10,
                  ),
                  Row(children: [
                    Padding(padding: EdgeInsets.only(left: 10, right: 10)),
                    InkWell(
                        child: Icon(
                          SimpleIcons.github,
                          size: 25,
                        ),
                        onTap: () => launchURL(MoGit)),
                    Padding(padding: EdgeInsets.only(left: 10, right: 10)),
                    InkWell(
                        child: Icon(
                          SimpleIcons.linkedin,
                          size: 25,
                          color: Colors.blue[900],
                        ),
                        onTap: () => launchURL(MoIN))
                  ]),
                ],
              ),
            ]),
          ),
          Container(
              margin: EdgeInsets.only(top: 20, left: 50),
              child: Row(children: [
                Text("Colleagues contributed in data gathering.")
              ])),
          Divider(
            height: 10,
            indent: 40,
            endIndent: 40,
          ),
          Container(
              margin: EdgeInsets.only(top: 50, left: 80),
              child: Row(children: [
                Text("FeedBack & Report Bugs    "),
                InkWell(
                  child: Icon(
                    SimpleIcons.gmail,
                    color: Colors.red[800],
                    size: 30,
                  ),
                  onTap: () => sendMailall(),
                )
              ])),
          Divider(
            height: 10,
            indent: 50,
            endIndent: 50,
          ),
          Container(
            margin: EdgeInsets.only(top: 70),
            child: Text(
              "\t\t\t\t\tGraduation Project 2022\nSupervisor: Dr/ Mohamed Marie.\n\t\t\t \tFCAI-Helwan University.",
              style: TextStyle(
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

void launchURL(Uri url) async {
  if (!await launchUrl(url)) throw 'Could not launch $url';
}

void makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

sendMailMO() async {
  const uri = 'mailto:tatamagdy2@gmail.com?subject=&body=';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}

sendMailMs() async {
  const uri = 'mailto:mahmoudsamirms01@gmail.com?subject=&body=';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}

sendMailall() async {
  const uri = 'mailto:recipesgpteam@gmail.com?subject=&body=';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}
