import 'package:flutter/material.dart';

import 'package:flutter_postalcodes/services/PostOffice.dart';
import 'package:flutter_postalcodes/model/PostOffice.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Postal Codes'),
      ),
      body: Center(
        child: FutureBuilder(
          future: loadPostOffices(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
//                print(snapshot.data);
                return _buildPostOfficesList(context, snapshot.data as List<PostOffice>);
                // Display the data widget
              } else if (snapshot.hasError) {
                // Error
              }
              // Show a loading spinner
              return CircularProgressIndicator();
            }
        ),
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