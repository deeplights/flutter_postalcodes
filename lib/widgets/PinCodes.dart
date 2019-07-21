import 'package:flutter/material.dart';

import 'package:flutter_postalcodes/services/PostOffice.dart';
import 'package:flutter_postalcodes/model/PostOffice.dart';

class PinCodesPage extends StatefulWidget {
  final String pinCode;
  PinCodesPage({this.pinCode});

  @override
  State<StatefulWidget> createState() {
    return _PinCodesPageState();
  }
}

class _PinCodesPageState extends State<PinCodesPage> {
  TextEditingController _searchPinCodeController = new TextEditingController();
  final FocusNode _searchPinCodeFocus = FocusNode();
  String pinCode;

  @override
  void initState() {
    super.initState();
    this.pinCode = widget.pinCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pin Codes'),
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _searchPinCodeController,
                  focusNode: _searchPinCodeFocus,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (text) {
                    setState(() {
                      pinCode = _searchPinCodeController.text;
                    });
                    _searchPinCodeFocus.unfocus();
                  },
                  decoration: InputDecoration(
                      labelText: "Enter Pin Code",
                      hintText: "Pin Code",
                      prefixIcon: Icon(Icons.pin_drop),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0))
                      )
                  ),
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                      future: loadPinCodes(pinCode),
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
    return ListView(
      children: postOffices.map((po) => _buildPostOffice(context, po)).toList(),
    );
  }

  Widget _buildPostOffice(BuildContext context, PostOffice po) {
    return ListTile(
      title: Text(po.name),
      subtitle: Text(po.district),
      leading: Text(po.pinCode),
      trailing: Text(po.branchType),
    );
  }
}