import 'package:flutter/material.dart';
import 'package:flutter_qrscanner_fh/src/models/scann_model.dart';
import 'package:url_launcher/url_launcher.dart';

abrirScan(BuildContext context, ScanModel scan) async {

  if(scan.tipo == 'http'){

    if (await canLaunch(scan.valor)) {
      await launch(scan.valor);
    } else {
      throw 'No se puede abrir ${scan.valor}';
    }
  }else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
    // print('GEO...');
  }
}