
import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  


final List<String> _categorylable = ['food', 'vegetables', 'egg', 'tea', ' cakes', 'fruits', 'chocalates'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 19,
            ),
          ),

          Container(
            height: 30,
            child: 
            Row(
              children: [
              Expanded(
                child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categorylable.length,
                itemBuilder: (context, index) {
                return ActionChip(
                  // backgroundColor: Colors.yellow.shade700,
                  onPressed: () {},
                  label: Text(
                    _categorylable[index],
                    style: TextStyle(
                      color: Colors.grey,
                      // fontSize: 20,
                      fontWeight: FontWeight.bold),
                    ),
                );
              }
              ),
              ),

              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
            ],
            ),
          ),
        ],
      ),
    );
  }
}