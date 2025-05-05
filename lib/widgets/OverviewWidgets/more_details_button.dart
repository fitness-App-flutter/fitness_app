import 'package:flutter/material.dart';

class MoreDetailsButton extends StatelessWidget {
  const MoreDetailsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff7f54df), // لون الخلفية
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14), // استدارة الحواف
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // تعديل الحشو
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("More details clicked!")),
          );
        },
        child: const Row(
          mainAxisSize: MainAxisSize.min, // لجعل الصف يأخذ أقل مساحة ممكنة
          children: [
             Text(
              "More Details",
              style: TextStyle(
                color: Colors.white, // لون النص
                fontSize: 12, // حجم النص
              ),
            ),
             SizedBox(width: 64), // زيادة المسافة بين النص والأسهم
            Row(
              children: [
                Icon(
                  Icons.arrow_forward_ios, // أيقونة السهم (>)
                  color: Color(0xff9770e8), // اللون الأول
                  size: 24, // حجم الأيقونة
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xffb491f8),
                  size: 24, // حجم الأيقونة
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xffe1c9ff),
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}