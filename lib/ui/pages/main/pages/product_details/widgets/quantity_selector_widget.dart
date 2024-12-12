import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuantitySelectorWidget extends ConsumerStatefulWidget {
  const QuantitySelectorWidget({super.key});

  @override
  ConsumerState createState() => _QuantitySelectorWidgetState();
}

class _QuantitySelectorWidgetState extends ConsumerState<QuantitySelectorWidget> {
  int value = 1;
  final int max = 10;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: value <= 1 ? null : (){
                  setState(() {
                    value--;
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Icon(
                  Icons.remove,
                  size: 20,
                  color: value <= 1 ? Colors.grey : Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: value >= max ? null : (){
                  setState(() {
                    value++;
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Icon(
                  Icons.add,
                  size: 20,
                  color: value >= max ? Colors.grey : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
