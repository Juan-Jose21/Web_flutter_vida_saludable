import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/proyecto_controllers.dart';
import '../../../models/proyecto_models.dart';

class DriverDataSource extends DataTableSource {
  final List<Proyecto> proyectos; // Cambia a List<Proyecto>

  DriverDataSource(this.proyectos);

  @override
  DataRow? getRow(int index) {
    if (index >= proyectos.length) return null;
    final proyecto = proyectos[index];
    return DataRow(cells: [
      DataCell(CustomText(text: (index + 1).toString())),
      DataCell(CustomText(text: proyecto.nombre ?? '')),
      DataCell(CustomText(text: proyecto.fecha_inicio != null ? DateFormat('dd/MM/yyyy').format(proyecto.fecha_inicio!) : '')),
      DataCell(CustomText(text: proyecto.fecha_fin != null ? DateFormat('dd/MM/yyyy').format(proyecto.fecha_fin!) : '')),
      DataCell(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                // Implementa la acción de editar
              },
              child: Container(
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
            ),
            SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                // Implementa la acción de eliminar
              },
              child: Container(
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
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => proyectos.length;

  @override
  int get selectedRowCount => 0;

  @override
  void selectAll(bool checked) {}
}

class ClientsTable extends StatelessWidget {
  const ClientsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final ProyectoController proyectoController = Get.find<ProyectoController>();

    return Obx(() {
      if (proyectoController.proyectos.isEmpty) {
        return Center(child: Text('No hay proyectos disponibles'));
      }

      return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 30),
        child: PaginatedDataTable(
          columns: const [
            DataColumn(label: Text("#")),
            DataColumn(label: Text("Nombre del Proyecto")),
            DataColumn(label: Text("Fecha Inicio")),
            DataColumn(label: Text('Fecha Final')),
            DataColumn(label: Text('Acción')),
          ],
          source: DriverDataSource(proyectoController.proyectos),
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
    });
  }
}

