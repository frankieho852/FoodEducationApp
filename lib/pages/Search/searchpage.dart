import 'package:flutter/material.dart';
import 'package:food_education_app/pages/DetailResult/detail_result_screen.dart';

class Searchpage extends StatefulWidget {
  @override
  _SearchpageState createState() => new _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List names;
  List filteredNames;
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
        });
      }
    });
  }

  @override
  void initState() {
    this._getNames();
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
    );
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
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
            print(filteredNames[index]);
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

  void _getNames() async {
    //todo: get all name of all products in firestore and store in templist
    List tempList = ["water", "noodle", "apple", "banana", "vita lemon tea","temp","temp","temp","temp","temp","temp"];
    setState(() {
      names = tempList;
      names.sort();
      filteredNames = [];// not showing any result when initstate
    });
  }
}
