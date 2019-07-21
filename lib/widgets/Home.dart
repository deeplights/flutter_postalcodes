import 'package:flutter/material.dart';

import 'package:flutter_postalcodes/services/PostOffice.dart';
import 'package:flutter_postalcodes/model/PostOffice.dart';
import 'PinCodes.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  static String defaultPostOffice = "New Delhi";
  TextEditingController homeTextController = new TextEditingController(text: defaultPostOffice);
  final FocusNode _homeTextFocus = FocusNode();
  String postOffice = defaultPostOffice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Postal Codes'),
      ),
      body: Center(
        child: Column(
         children: <Widget>[
           Padding(
             padding: EdgeInsets.all(8.0),
             child: TextFormField(
               controller: homeTextController,
               focusNode: _homeTextFocus,
               textInputAction: TextInputAction.done,
               onFieldSubmitted: (text) {
                 setState(() {
                   postOffice = homeTextController.text;
                 });
                 _homeTextFocus.unfocus();
               },
               decoration: InputDecoration(
                 labelText: "Enter Post Office area",
                 hintText: "Post Office",
                 prefixIcon: Icon(Icons.home),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.all(Radius.circular(25.0))
                 )
               ),
             ),
           ),
           Expanded(
             child: FutureBuilder(
               future: loadPostOffices(postOffice),
               builder: (context, snapshot) {
                 if (snapshot.hasData) {
//                print(snapshot.data);
                   return _buildPostOfficesList(context, snapshot.data as List<PostOffice>);
                   // Display the data widget
                 } else if (snapshot.hasError) {
                   return Center(child: Text("Error, No post offices found!"));
                 }
                 // Show a loading spinner
                 return Center(child:CircularProgressIndicator());
               }
           )
           ),
         ],
        )
      ),
    );
  }

  Widget _buildPostOfficesList(BuildContext context, List<PostOffice> postOffices) {
    postOffices.sort((a, b) => a.pinCode.compareTo(b.pinCode));
    Map<String, List<PostOffice>> byDivision = Map();
    postOffices.forEach((po){
      byDivision.putIfAbsent(po.division, () => new List());
      byDivision[po.division].add(po);
    });
    List<String> keys = byDivision.keys.toList();
    keys.sort((a, b) => a.compareTo(b));
    return ListView.builder(
      itemCount: keys.length,
      itemBuilder: (context, i) {
        return ExpansionTile(
          initiallyExpanded: true,
          title: Text(keys[i]),
          children: byDivision[keys[i]].map((po) => _buildPostOffice(context, po)).toList(),
        );
      },
    );
  }

  Widget _buildPostOffice(BuildContext context, PostOffice po) {
    return ListTile(
      title: Text(po.name),
      subtitle: Text(po.branchType),
      leading: Text(po.pinCode),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PinCodesPage(pinCode: po.pinCode)));
      },
    );
  }
}