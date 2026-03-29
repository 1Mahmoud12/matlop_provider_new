import 'package:flutter/material.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/predection_model.dart';

class PositionedResultSearch extends StatelessWidget {
  const PositionedResultSearch({
    super.key,
    required this.predictions,
  });

  final List<Prediction> predictions;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 70,
      left: 20,
      right: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Scrollbar(
            thumbVisibility: true,
            thickness: 3,
            radius: const Radius.circular(10),
            child: ListView.builder(
              itemCount: predictions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(predictions[index].description),
                  trailing: const Icon(Icons.location_on_outlined),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
