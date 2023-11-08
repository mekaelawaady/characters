import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          itemCount: 5, // Number of shimmer items
          itemBuilder: (context, index) {
            return ListTile(
              title: Container(
                height: 10.0,
                color: Colors.white,
              ),
              subtitle: Container(
                height: 10.0,
                color: Colors.white,
              ),
              leading: Container(
                width: 48.0,
                height: 48.0,
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
