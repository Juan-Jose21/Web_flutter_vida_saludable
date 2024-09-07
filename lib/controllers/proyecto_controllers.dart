import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/models/proyecto_models.dart';
import 'package:flutter_web_dashboard/providers/proyecto_providers.dart';
import 'package:get/get.dart';

import '../models/response_api.dart';

class ProyectoController extends GetxController {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();

  ProyectoProviders proyectoProviders = ProyectoProviders();

  var proyectos = <Proyecto>[].obs; // Lista observable de proyectos

  @override
  void onInit() {
    super.onInit();
    listarProyectos();
  }

  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      controller.text = "${pickedDate.toLocal()}".split(' ')[0];
    }
  }

  void createProyecto() async {
    String nombre = nombreController.text.trim();
    String startDateText = startDateController.text.trim();
    String endDateText = endDateController.text.trim();

    if (nombre.isEmpty || startDateText.isEmpty || endDateText.isEmpty) {
      Get.snackbar('Formulario no válido', 'Todos los campos deben estar llenos');
      return;
    }

    DateTime? dateTimeInicio = DateTime.tryParse(startDateText);
    DateTime? dateTimeFin = DateTime.tryParse(endDateText);

    if (dateTimeInicio == null || dateTimeFin == null) {
      Get.snackbar('Fecha no válida', 'Las fechas proporcionadas no son válidas');
      return;
    }

    Proyecto proyecto = Proyecto(
      nombre: nombre,
      fecha_inicio: dateTimeInicio,
      fecha_fin: dateTimeFin,
    );

    ResponseApi responseApi = await proyectoProviders.create(proyecto);

    if (responseApi.success == true) {
      Get.snackbar('Registro exitoso', responseApi.message ?? '');
      listarProyectos();
    } else {
      Get.snackbar('Error', responseApi.message ?? 'No se pudo registrar');
    }
  }

  void listarProyectos() async {
    ResponseApi responseApi = await proyectoProviders.getAll();
    if (responseApi.success == true) {
      proyectos.value = List<Proyecto>.from(responseApi.data);
    } else {
      print('Error al listar proyectos: ${responseApi.message}');
    }
  }

}
