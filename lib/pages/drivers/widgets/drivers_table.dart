import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';

class DriverDataSource extends DataTableSource {
  final List<Map<String, String>> data;
  final BuildContext context;

  DriverDataSource(this.data, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final driver = data[index];
    return DataRow(cells: [
      DataCell(CustomText(text: (index + 1).toString())),
      DataCell(CustomText(text: driver['name'] ?? '')),
      DataCell(CustomText(text: driver['email'] ?? '')),
      DataCell(CustomText(text: driver['project'] ?? '')),
      DataCell(CustomText(text: driver['phone'] ?? '')),
      DataCell(CustomText(text: driver['role'] ?? '')),
      DataCell(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.indigo, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.edit,
                color: Colors.indigo,
                size: 20,
              ),
            ),
            SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.delete,
                color: Colors.red,
                size: 20,
              ),
            ),
            SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                // Se envuelve la apertura del diálogo en un Future.delayed para evitar conflictos de estado
                Future.delayed(Duration(milliseconds: 100), () {
                  _showDialogWithTabs(context);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.all(4),
                child: Icon(
                  Icons.add_chart_rounded,
                  color: Colors.green,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  @override
  void selectAll(bool checked) {}
}

class DriversTable extends StatelessWidget {
  const DriversTable({super.key});

  @override
  Widget build(BuildContext context) {
    final data = List.generate(15, (index) => {
      'name': 'Juan Jose Merlos Alacama',
      'email': 'juan.merlos@uab.edu.bo',
      'project': 'Vida Saludable',
      'phone': '68756940',
      'role': 'Administrador',
    });

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 30),
      child: PaginatedDataTable(
        columns: const [
          DataColumn(label: Text("#")),
          DataColumn(label: Text("Nombre Completo")),
          DataColumn(label: Text("Correo Electrónico")),
          DataColumn(label: Text('Proyecto')),
          DataColumn(label: Text('Celular')),
          DataColumn(label: Text('Rol')),
          DataColumn(label: Text('Acción')),
        ],
        source: DriverDataSource(data, context), // Pasamos el contexto aquí
        rowsPerPage: 8,
        availableRowsPerPage: [8, 16, 24],
        header: null,
        columnSpacing: 12,
        dataRowHeight: 60,
        headingRowHeight: 40,
        showFirstLastButtons: true,
        showCheckboxColumn: false,
      ),
    );
  }
}

void _showDialogWithTabs(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DefaultTabController(
        length: 5,
        child: AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Título del Diálogo"),
              TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: "Tab 1"),
                  Tab(text: "Tab 2"),
                  Tab(text: "Tab 3"),
                  Tab(text: "Tab 4"),
                  Tab(text: "Tab 5"),
                ],
              ),
            ],
          ),
          content: SizedBox(
            height: 400, // Ajustar la altura del contenido si es necesario
            child: TabBarView(
              children: [
                _buildTabContent(context, "Tab 1"),
                _buildTabContent(context, "Tab 2"),
                _buildTabContent(context, "Tab 3"),
                _buildTabContent(context, "Tab 4"),
                _buildTabContent(context, "Tab 5"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar diálogo
              },
              child: Text('Cerrar'),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildTabContent(BuildContext context, String tabName) {
  return SingleChildScrollView(
    child: Column(
      children: [
        for (int i = 0; i < 5; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: "Input ${i + 1}"),
            ),
          ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Acción de guardar
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Datos guardados en $tabName"),
            ));
          },
          child: Text("Guardar"),
        ),
      ],
    ),
  );
}

