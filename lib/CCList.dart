import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cc_tracker/CCData.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
    String? version = dotenv.env['VERSION'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Cryptocurrency tracker $version'),
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

String? apiKey = dotenv.env['CC_API_KEY'];
  Map<String, String> get headers => {
    'X-CMC_PRO_API_KEY': apiKey.toString(),
  };

  _loadCC() async {
    String? listRoute = dotenv.env['CC_LIST_ROUTE'];
    final response = await http.get(
      Uri.parse('$listRoute'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var responseData= json.decode(response.body);
      var allData = responseData['data'] as List<dynamic>;
      List<CCData> ccDataList = [];

      for (var val in allData) {
        var record = CCData(
            name: val['name'],
            symbol: val['symbol'],
            rank: val['cmc_rank'],
            price: val['quote']['USD']['price']
        );
        ccDataList.add(record);
      }
      setState(() {
        data = ccDataList;
      });
      if (kDebugMode) {
        print('CC Data is loaded!');
      }
    }
  }

  List<Widget> _buildList() {
    return data.map((CCData f) => ListTile(
      title: Text(f.symbol),
      subtitle: Text(f.name),
      leading: CircleAvatar(child: Text(f.rank.toString())),
      trailing: Text('\$${f.price.toStringAsFixed(4)}'),
    )).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadCC();
  }
}

