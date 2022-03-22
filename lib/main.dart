import 'package:books_for_me/models/models.dart';
import 'package:books_for_me/services/services.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController searchText = TextEditingController();

  late Future<BookModel> bookInf;
  ApiServices apiObj = new ApiServices();
  bool cntrl=false;

  getBook(String bookName)
  {
    setState(() {
      cntrl=true;
      bookInf = apiObj.getBook(bookName: bookName);
    });
  }

  initState() {
    super.initState();
  }

  spaceWidget()
  {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
              "https://foodtank.com/wp-content/uploads/2021/07/alfons-morales-YLSwjSy7stw-unsplash.jpg"
          ),
          Text("Sonsuz kütüphaneye hoş geldin.", style: TextStyle(color: Colors.white),)
        ],
      )
    );
  }

  responseWidget()
  {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
      width: MediaQuery.of(context).size.width*0.8,
      child: FutureBuilder<BookModel>(
        future: bookInf,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width*0.4,
                            child: Image.network(snapshot.data?.bookCover ?? "http://haber.webdeogren.com/wp-content/uploads/2020/01/resim-yok.png", fit: BoxFit.contain,)
                        )
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width*0.3, child: Text(snapshot.data?.bookName ?? "BOŞ", maxLines: 2, overflow: TextOverflow.clip, style: TextStyle(fontSize: 27, color: Colors.blue[700]),)),
                        SizedBox(width: MediaQuery.of(context).size.width*0.3, child: Text(snapshot.data?.bookAuthor ?? "BOŞ", style: TextStyle(fontSize: 17, color: Colors.blue[500]))),
                        Text(snapshot.data?.bookPage.toString() ?? "BOŞ"),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                        child: SingleChildScrollView(
                            child: Text(snapshot.data?.bookDescription ?? "BOŞ", ))),
                  ],
                ),
              ],
            );
          }
          else if(snapshot.hasError){
            return Text("${snapshot.error}");
          }
          return Container(child: Center(child: Text("Bilgi geliyor...", style: TextStyle(fontSize: 24),)));
        }

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(186,159,115,1),
        toolbarHeight: 100,
        title: Column(
          children: [
            Text("Books For Me", style: TextStyle(color: Colors.white70, fontSize: 28),),
            Icon(Icons.menu_book, color: Colors.yellow,)
          ],
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.pinkAccent,
                    ),
                    margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 50,
                    child: TextFormField(
                      controller: searchText,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.edit, color: Colors.white,),
                        labelText: "Hangi kitabı arıyorsun?",
                        labelStyle: TextStyle(
                          color: Colors.white
                        )
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: (){
                        getBook(searchText.text);
                      },
                    ),
                  )
                ],
              ),
              cntrl == true ? responseWidget() : spaceWidget(),
            ],
          ),
        ),
      ),
    );
  }
}


