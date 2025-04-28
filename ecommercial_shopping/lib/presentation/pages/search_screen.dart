import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.deepOrange, // Đặt màu cho icon "arrow back"
        ),
        elevation: 0,
        title: Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search your favourite food",
              prefixIcon: Icon(Icons.search, color: Colors.deepOrange),
              suffixIcon: Icon(Icons.filter_alt, color: Colors.deepOrange),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                // Thêm viền màu cam khi focus
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.deepOrange,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                // Viền mặc định khi không focus
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.deepOrange,
                  width: 1.0,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ),
      body: Center(
        child: Text("Your content here"),
      ),
    );
  }
}
