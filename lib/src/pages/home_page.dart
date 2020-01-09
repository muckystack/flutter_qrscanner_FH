import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_qrscanner_fh/src/bloc/scans.dart';
import 'package:flutter_qrscanner_fh/src/models/scann_model.dart';
import 'package:flutter_qrscanner_fh/src/pages/direcciones_page.dart';
import 'package:flutter_qrscanner_fh/src/pages/mapas_page.dart';
import 'package:flutter_qrscanner_fh/src/utils/utils.dart' as utils;
import 'package:qrcode_reader/qrcode_reader.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QRScanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              scansBloc.borrarScanTODOS();
            },
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),

    );
  }


  
  _scanQR(BuildContext context) async{

    // print('Scan...');
    // String futureString;
    String futureString = 'https://fernando-herrera.com';
    // try {
    //   futureString = await new QRCodeReader().scan();
    // } catch (e) {
    //   futureString = e.toString();
    //   print('Error');
    // }

    // print('FutureStirng: $futureString');

    if(futureString != null) {
      print('TENEMOS INFORMACIÓN');
      // Llamamos el proceso de inserción
      final scan = ScanModel(valor: futureString);
      scansBloc.agregarScan(scan);

      if(Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.abrirScan(context, scan);
        });
      }else {
        utils.abrirScan(context, scan);
      }

      // final scan2 = ScanModel(valor: 'geo:56.704173,11.543808');
      // scansBloc.agregarScan(scan2);
      // DBProvider.db.nuevoScan(scan);
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