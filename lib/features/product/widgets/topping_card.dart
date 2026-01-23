import 'package:flutter/material.dart';

class ToppingCard extends StatelessWidget {
  const ToppingCard({super.key, required this.imageurl, required this.name, required this.onAdd, this.color, });
  final String imageurl ;
  final String name ;
  final   Function() onAdd ;
  final Color? color ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Image.asset(
             imageurl,
              height: 88,
              width: 80,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF3A2F2F),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),

              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  height: 28,
                  width: 28,
                  decoration:  BoxDecoration(
                    color: color ?? Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap: onAdd,
                    child: const Icon(
                      Icons.add,
                      size: 20,
                      weight: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
