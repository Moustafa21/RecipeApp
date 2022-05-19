import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_plus/share_plus.dart';
import 'package:untitled/Details.dart';
class itemCards extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String duration;
  final String ing;
  final String steps;
  final String category;
  final String country;
  final String docID;

  itemCards(
      @required this.imageUrl,
      @required this.title,
      @required this.duration,
      this.ing,
      this.steps,
      this.category,
      this.country,
      this.docID);
  State<StatefulWidget> createState() => _itemCardsState();
}

class _itemCardsState extends State<itemCards> {
  bool isfav = false;
  bool _isFavorited = false;
  var auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    checkFav();
  }

  checkFav() async {
    final snap = await FirebaseFirestore.instance
        .collection("users-favorites")
        .doc(auth.currentUser!.email)
        .collection("items")
        .doc(widget.title)
        .get();
    if (snap.exists) {
      setState(() {
        _isFavorited = true;
      });
    } else {
      setState(() {
        _isFavorited = false;
      });
    }
  }

  void selectMeal(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
          builder: (context) => Details(
              widget.title,
              widget.imageUrl,
              widget.duration,
              widget.ing,
              widget.steps,
              widget.category,
              widget.country,
              widget.docID)),
    );
  }

  sharing() {
    try {
      Share.share("مشاركة وصفة ${widget.title} من تطبيق كذا"
          "\n\n\n"
          "مدة التحضير"
          "\t"
          "${widget.duration} دقيقة"
          "\n\n\n"
          "المكونات"
          "\n"
          "${widget.ing}"
          "\n\n\n"
          "طريقة التحضير"
          "\n"
          "${widget.steps}"
          "\n\n\n"
          "صورة"
          "\n\n"
          "${widget.imageUrl}");
    } catch (e) {
      print(e);
    }
  }

  Future addToFavorite() async {
    setState(() {
      isfav = true;
    });
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("users-favorites");
    return collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(widget.title)
        .set({
      'url': widget.imageUrl,
      'Recipe': widget.steps,
      'Ingredients': widget.ing,
      'RecipeName': widget.title,
      'RecipeTime': widget.duration,
    });
  }

  Future unFavorite() async {
    setState(() {
      isfav = false;
    });

    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("users-favorites");
    return collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(widget.title)
        .delete();
  }

  Future delete() async {
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("Items");
    return collectionRef
        .doc(widget.country)
        .collection(widget.country)
        .doc(widget.category)
        .collection(widget.category)
        .doc(widget.docID)
        .delete();
  }

  void _delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: const Text('برجاء التأكيد'),
              content: Text("هل انت متأكد من مسح ${widget.title}؟"),
              actions: [
                TextButton(
                    onPressed: () {
                      delete();
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                    child: const Text('نعم')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('لا'))
              ],
            ),
          );
        });
  }

  var _auth = FirebaseAuth.instance;
  var logedInUSer;
  getCuurrentUser() {
    User? user = _auth.currentUser?.email as User?;
    logedInUSer = user?.email;
  }

  @override
  Widget build(BuildContext context) {
    isfav() async {
      final snap = await FirebaseFirestore.instance
          .collection("users-favorites")
          .doc(auth.currentUser!.email)
          .collection("items")
          .doc(widget.title)
          .get();
      if (snap.exists && _isFavorited) {
        setState(() {
          _isFavorited = false;
          unFavorite();
        });
      } else {
        setState(() {
          _isFavorited = true;
          addToFavorite();
        });
      }
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: InkWell(
          onTap: () => selectMeal(context),
          child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 4,
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.network(
                        widget.imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 10,
                      child: Container(
                        width: 220,
                        color: Colors.black54,
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        child: Text(widget.title,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            softWrap: true,
                            overflow: TextOverflow.fade),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer, size: 30),
                          SizedBox(width: 6),
                          Text(
                            "${widget.duration} ق",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Visibility(
                          child: Container(
                            margin: EdgeInsets.only(right: 150),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => isfav(),
                                  icon: _isFavorited
                                      ? Icon(
                                    Icons.favorite_sharp,
                                    color: Colors.red,
                                  )
                                      : Icon(Icons.favorite_border),
                                  iconSize: 30,
                                ),
                              ],
                            ),
                          ),
                          visible: _auth.currentUser?.email == 'admin@gmail.com'
                              ? false
                              : true),
                      Row(
                        children: [
                          _auth.currentUser?.email == 'admin@gmail.com'
                              ? Container(
                            margin: EdgeInsets.only(right: 200),
                            child: IconButton(
                              onPressed: () => _delete(context),
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              iconSize: 30,
                            ),
                          )
                              : IconButton(
                            onPressed: () => sharing(),
                            icon: Icon(Icons.share),
                            iconSize: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}