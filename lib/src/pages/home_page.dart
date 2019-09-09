import 'package:flutter/material.dart';
import 'package:flutter_qrscanner_fh/src/pages/direcciones_page.dart';
import 'package:flutter_qrscanner_fh/src/pages/mapas_page.dart';

import 'package:qrcode_reader/qrcode_reader.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QRScanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {},
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),

    );
  }


  
  _scanQR() async{

    // print('Scan...');
    String futureString;
    try {
      futureString = await new QRCodeReader().scan();
    } catch (e) {
      futureString = e.toString();
      print('Error');
    }

    print('FutureStirng: $futureString');

    if(futureString != null) {
      print('TENEMOS INFORMACIÓN');
    }
    

  }


  Widget _crearBottomNavigationBar() {

    return BottomNavigationBar(
      // Inidca el elemento que esta activo
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
        ),
      ],
    );

  }

  Widget _callPage(int paginaActual) {

    switch (paginaActual) {
      case 0:
          return MapasPage();
        break;
      case 1:
          return DireccionesPage();
        break;

      default: return MapasPage();
    }

  }
}