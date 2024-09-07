import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/pages/drivers/widgets/drivers_table.dart';
import 'package:flutter_web_dashboard/pages/drivers/widgets/top_page.dart';
import 'package:get/get.dart';

class DriversPage extends StatelessWidget {
  const DriversPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Column(
          children: [
            AppBar(
              title: Obx(
                    () => Text(
                  menuController.activeItem.value,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent, // Establece el color de fondo del AppBar
              elevation: 0, // Elimina la sombra del AppBar
            ),
            Expanded(
              child: Column(
                children: [
                  const TopPage(),
                  Expanded(
                    child: ListView(
                      children: const [DriversTable()],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
