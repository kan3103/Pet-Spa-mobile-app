import 'package:flutter/material.dart';
import 'package:frontend/view_model/itemView_sqr.dart';

class PetCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String dob;
  final String petType;
  final Function(bool) onSelected;

  const PetCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.dob,
    required this.petType,
    required this.onSelected,
  }) : super(key: key);

  @override
  _PetCardState createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  bool isSelected = false;

  void _toggleSelection() {
    setState(() {
      isSelected = !isSelected;
      widget.onSelected(isSelected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSelection,
      child: Container(
        decoration: BoxDecoration(
          color:  Colors.pink.shade50,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child: getImageWidget(widget.imageUrl, 100, double.infinity),
                  /*
                  Image.network(
                    widget.imageUrl,
                    height: 100.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),*/
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        widget.dob,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        widget.petType,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Positioned(
            //   bottom: 8.0,
            //   right: 8.0,
            //   child: Checkbox(
            //     value: isSelected,
            //     onChanged: (value) {
            //       _toggleSelection();
            //     },
            //     shape: const CircleBorder(),
            //     side: BorderSide(color: const Color.fromARGB(255, 189, 189, 189)),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}