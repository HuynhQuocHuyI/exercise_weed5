import 'package:flutter/material.dart';

class ViewEmptyNote extends StatelessWidget {
  const ViewEmptyNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/welcome_image.png',
            width: 200,
            height: 200,
          ),
          SizedBox(height: 40),
          Text(
            'Xin chào!',
            style: TextStyle(
              color: Color(0xff1565C0),
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Chưa có ghi chú nào',
            style: TextStyle(color: Color(0xff757575), fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Nhấn nút + để tạo ghi chú mới',
            style: TextStyle(color: Color(0xff9E9E9E), fontSize: 14),
          ),
        ],
      ),
    );
  }
}
