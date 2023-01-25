import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => GirisEkran(),
        "/AnaEkranSayfasiRotasi": (context) => Iskele(),
      },
      //title: "TO DO APP",
      //home: Iskele(),
    );
  }
}

class GirisEkran extends StatefulWidget {
  const GirisEkran({Key? key}) : super(key: key);

  @override
  State<GirisEkran> createState() => _GirisEkranState();
}

class _GirisEkranState extends State<GirisEkran> {
  //TextEditingController tec2 = TextEditingController();
  TextEditingController tec3 = TextEditingController();

  girisYap() {
    Navigator.pushNamed(context, "/AnaEkranSayfasiRotasi",
        arguments: tec3.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text("Giriş Ekranı"),
        centerTitle: true,
      ),
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/sky.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        margin: EdgeInsets.all(11),
        transformAlignment: AlignmentDirectional.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 13),
              controller: tec3,
              //keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Yapılacaklar listenizin ismini yazınız..",
                  filled: true,
                  fillColor: Colors.white54),

              onTap: () {
                setState(() {
                  tec3.text = "";
                });
              },
            ),
            SizedBox(height: 15),
            ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green.shade800),
                ),
                onPressed: () {
                  girisYap();
                },
                icon: Icon(Icons.start),
                label: Text("Giriş Yap")),
            SizedBox(height: 15),
            ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.app_registration),
                label: Text("Yeni Liste Oluşturmak:")),
            SizedBox(width: 10, height: 10),
            Text(
              "Eğer daha önceden oluşturduğunuz bir listeniz yoksa yeni bir liste ismi girerek giriş yapa tıklayınız",
              style: TextStyle(
                backgroundColor: Colors.white54,
                fontStyle: FontStyle.italic,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class Iskele extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
          centerTitle: true,
          title: Text("YAPILACAKLAR LİSTESİ",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              )),
          shadowColor: Colors.deepPurple,
          backgroundColor: Colors.deepPurple),
      body: AnaEkran(),
    );
  }
}

class AnaEkran extends StatefulWidget {
  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  TextEditingController tec1 = TextEditingController(
      text: "Ürünü yazınız.(ekmek,su,kalem,kitap oku vb...)");
  TextEditingController tec2 = TextEditingController(
      text: ("Türünü yazınız.(alışveriş,kırtasiye,yemek,aktivite vb..)"));

  cikisYap() {
    Navigator.pop(context);
  }

/*
 var gecici = FirebaseFirestore.instance
      .collection('todoApp')
      .snapshots()
      .listen((data) => data.docs.forEach((doc) => print(doc['yapilacak'])));
  List AlisverisListesi = [];
  List AlisverisListesi2 = [];
var gelenVeri1 = "";
  var gelenVeri2 = "";

  elemanEkle() {
    setState(() {
      veriGetir();
      AlisverisListesi.add(gelenVeri1);
      AlisverisListesi2.add(gelenVeri2);
      //AlisverisListesi.add(tec1.text);
      //tec1.clear();
    });
  }
  elemanCikar() {
    setState(() {
      veriGetir();
      AlisverisListesi.remove(gelenVeri1);
      AlisverisListesi2.remove(gelenVeri2);

      //AlisverisListesi.remove(tec1.text);
      // tec2.clear();
    });
  }
  veriGetir() {
    FirebaseFirestore.instance
        .collection('todoApp')
        .doc(tec1.text)
        .get()
        .then((gelenVeri) {
      setState(() {
        gelenVeri1 = gelenVeri.data()!['yapilacak'];
        gelenVeri2 = gelenVeri.data()!['yapilacakTuru'];
      });
    });
  }
   */
  veriEkle(var iletilenArg) {
    FirebaseFirestore.instance
        .collection('$iletilenArg')
        .doc(tec1.text)
        .set({'yapilacak': tec1.text, 'yapilacakTuru': tec2.text}).whenComplete(
            () => print("yazı eklendi"));
  }

  veriSil(var iletilenArg) {
    FirebaseFirestore.instance
        .collection('$iletilenArg')
        .doc(tec1.text)
        .delete()
        .whenComplete(() => print("yazı silindi"));
  }

  @override
  Widget build(BuildContext context) {
    var iletilenArg = ModalRoute.of(context)?.settings.arguments;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 4),
        borderRadius: BorderRadius.circular(20),
        color: Colors.deepPurple[300],
        boxShadow: const [
          BoxShadow(color: Colors.deepPurple, spreadRadius: 10, blurRadius: 10)
        ],
      ),
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Flexible(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('$iletilenArg')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                return ListView(
                  children: snapshot.data!.docs
                      .map((doc) => ListTile(
                            title: Text(doc['yapilacak']),
                            subtitle: Text(doc['yapilacakTuru']),
                          ))
                      .toList(),
                );
              },
            ),
          ),
          TextField(
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 11),
            controller: tec1,
            onTap: () {
              setState(() {
                tec1.text = "";
              });
            },
          ),
          TextField(
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 11),
            controller: tec2,
            onTap: () {
              setState(() {
                if (tec2.text ==
                    "Türünü yazınız.(alışveriş,kırtasiye,yemek,aktivite vb..)") {
                  tec2.text = "";
                }
              });
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                    veriEkle(iletilenArg);
                    //elemanEkle();
                  },
                  icon: Icon(Icons.add),
                  label: Text(
                    "Listeye Ekle",
                    style: TextStyle(
                      fontSize: 16.75,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  )),
              SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () {
                    veriSil(iletilenArg);
                    //elemanCikar();
                  },
                  icon: Icon(Icons.remove),
                  label: Text("Listeden Çıkar",
                      style: TextStyle(
                        fontSize: 16.75,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ))),
            ],
          ),
        ],
      ),
    );
  }
}
