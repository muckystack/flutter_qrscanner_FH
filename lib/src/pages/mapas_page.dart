import 'package:flutter/material.dart';
import 'package:flutter_qrscanner_fh/src/providers/db_provider.dart';

class MapasPage extends StatelessWidget {
  const MapasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScanModel>>(
      future: DBProvider.db.getTodosScans(),
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if(!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        
        final scans = snapshot.data;

        if(scans.length == 0) {
          return Center(child: Text('No hay información'));
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            // Crear una llave unica con la cual identificar el objeto de la lista
            key: UniqueKey(),
            background: Container(
              // Cambia el color del fondo que aparece cuando se desliza
              color: Colors.red,
            ),
            onDismissed: (direcction) => DBProvider.db.deleteScan(scans[i].id),
            child: ListTile(
              leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor),
              title: Text(scans[i].valor),
              subtitle: Text('ID: ${scans[i].id}'),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,)
            ),
          ),
        );
      },
    );
  }
}