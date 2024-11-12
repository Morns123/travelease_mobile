import 'package:flutter/material.dart';

class Categorybase extends StatelessWidget {
  const Categorybase({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(

                spacing: 8.0,
            runSpacing: 8.0, 
              children: [
               _buildChip(Icons.directions_car, 'Lacak Kendaraan',Colors.blueGrey),
              _buildChip(Icons.cancel, 'Batalkan Pesanan',Colors.redAccent),
              _buildChip(Icons.monetization_on, 'Pengembalian Dana',Colors.amber),
              _buildChip(Icons.check_circle, 'Konfirmasi Pesanan',Colors.green),
              _buildChip(Icons.person, 'Mengubah Profile',Colors.blueAccent),
              _buildChip(Icons.schedule, 'Perubahan Jadwal',const Color.fromARGB(255, 1, 1, 4)),
              ],
            );
  }
}
Widget _buildChip(IconData icon, String label,Color? color) {
    return Chip(
      backgroundColor: Colors.white,
      side: BorderSide.none,
      label: Container(
        constraints: BoxConstraints(
          maxWidth: 55,
          
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,color: color,),
            SizedBox(height: 4.0), // Jarak vertikal antara ikon dan teks
            Text(label,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11,),),
          ],
        ),
      ),
    );
  }