import 'package:flutter/material.dart';
import 'package:cc_tracker/CCData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CCList extends StatefulWidget{
  const CCList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CCListState();
  }
}

class CCListState extends State<CCList>{
  List<CCData> data = [];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('CC Tracker'),
      ),
      body: ListView(
        children: _buildList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () => _loadCC(),
      ),
    );
  }

  _loadCC() async{
    final response = await http.get(Uri.parse(''));
    if(response.statusCode == 200) {
      var responseData= json.decode(response.body);
      var allData = responseData['data'] as List<dynamic>;
      List<CCData> ccDataList = [];

      for (var val in allData) {
        var record = CCData(name: val['name'],
            symbol: val['symbol'], rank: val['rank'], price: val['priceUSD']);
        ccDataList.add(record);
      }
    }
}

  List<Widget> _buildList() {
    return data.map((CCData f) => ListTile(
      title: Text(f.symbol),
      subtitle: Text(f.name),
      leading: CircleAvatar(child: Text(f.rank.toString())),
      trailing: Text('\$${f.price.toString()}'),
    )).toList();
  }
}

