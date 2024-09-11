import 'package:flutter/material.dart';

class Categorybase extends StatelessWidget {
  const Categorybase({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(

                spacing: 8.0,
            runSpacing: 8.0, 
              children: [
               _buildChip(Icons.directions_car, 'Lacak Kendaraan'),
              _buildChip(Icons.cancel, 'Batalkan Pesanan'),
              _buildChip(Icons.monetization_on, 'Pengembalian Dana'),
              _buildChip(Icons.check_circle, 'Konfirmasi Pesanan'),
              _buildChip(Icons.person, 'Mengubah Profile'),
              _buildChip(Icons.schedule, 'Perubahan Jadwal'),
              ],
            );
  }
}
Widget _buildChip(IconData icon, String label) {
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
            Icon(icon,color: Color.fromRGBO(103, 153, 195, 1),),
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