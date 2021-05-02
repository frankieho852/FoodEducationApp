import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/pages/DetailResult/detail_result_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Searchpage extends StatefulWidget {
  @override
  _SearchpageState createState() => new _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  String _scanBarcode='unknown';
  List names=[];
  List filteredNames = [];
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search a food');

  _SearchpageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = [];
        });
      } else {
        setState(() {
          _searchText = _filter.text;
          _searchProductByName();
        });
      }
    });
  }

  @override
  void initState() {
    //this._getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: _buildList(),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
      actions: [
        Flexible(
            child: InkWell(
              onTap:(){scanBarcodeNormal();},
              child: Container(
                margin: const EdgeInsets.all(8.0),
                width: 30,
                  child: SvgPicture.asset('assets/icons/qr-code.svg')),
            )),
      ],
    );
  }

  Widget _buildList() {

    if (_searchText.isNotEmpty) {
      List tempList= [];
      for (int i = 0; i < names.length; i++) {
        if (names[i]
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(names[i]);
        }
      }
      filteredNames = tempList;
    }


    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index]),
          onTap: () {
            print("filteredNames: "+filteredNames[index]);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailResult(
                          searchname: filteredNames[index],
                        )));
          },
        );
      },
    );
  }
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
      //todo:use barcodeScanRes to find the specific product and them
      String name="todo";
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailResult(
                searchname: name,
              )));
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Type here to search'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search A Food');
        _filter.clear();
      }
    });
  }

  void _searchProductByName() async {
    //todo: get all name of all products in firestore and store in templist

    //List tempList;

    CollectionReference foodProductCollection =
    FirebaseFirestore.instance.collection('foodProduct');

//   List<String> x = ["brand", "a", "Tee"];
  //  List<String> b = _searchText.split(' ');
    // method 2

    // foodProductCollection.orderBy('name').where('keywords', arrayContainsAny:b).limit(10).get().then((value) {
    foodProductCollection.orderBy('name').startAt([_searchText]).limit(10).get().then((value) { //.endAt([_searchText +"\uf8ff"])  //startAt
      List tempList=[];
      //print(value.docsd);
      for(DocumentSnapshot product in value.docs){
        print("Finding: "+"_searchText:"+_searchText + " "+product.data()["name"]);  //debug
        tempList.add(product.data()['name']);
      }
      setState(() {
        names = tempList;
        print("names:");
        print(names);
        names.sort(); // todo: can remove
        filteredNames = [];// not showing any result when initstate
      });
    });

    //names = tempList;
    // tempList = ["water", "noodle", "apple", "banana", "vita lemon tea","temp","temp","temp","temp","temp","temp"];
    /*
    setState(() {
      names = tempList;
      //filteredNames = [];// not showing any result when initstate
    });

     */
  }
}
