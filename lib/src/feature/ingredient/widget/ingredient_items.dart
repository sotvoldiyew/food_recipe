import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';

import '../data/ingridient_model.dart';

class IngridentItems extends StatefulWidget {
  const IngridentItems({super.key, required this.list});
  final List<Datum2> list;

  @override
  State<IngridentItems> createState() => _IngridentItemsState();
}

class _IngridentItemsState extends State<IngridentItems> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        final model = widget.list[index];
        return Card(
          elevation: 0,
          color: context.colors.primaryContainer,
          child: SizedBox(
            height: 80,
            width: double.infinity,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: ClipRRect(
                    child: Card(
                      elevation: 0,
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Image(
                          image: NetworkImage(model.icon ??
                              "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBw0NDQ0NDQ0NDQ0NDQ0NDQ0NDw8PDQ0NFRUWFhUVFRUYHSggGBolHRUVITEhJSkrLi4uFx8zODMtNygtLisBCgoKBQUFDgUFDisZExkrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrK//AABEIALcBEwMBIgACEQEDEQH/xAAYAAEBAQEBAAAAAAAAAAAAAAABAAIDB//EABoQAQEBAQEBAQAAAAAAAAAAAAABERIC8CH/xAAUAQEAAAAAAAAAAAAAAAAAAAAA/8QAFBEBAAAAAAAAAAAAAAAAAAAAAP/aAAwDAQACEQMRAD8A9jhghAkECQQSSACmigKDQAqSAJIEkgSSBBICgQJgMApIECAApFAVmtVmgyiAdiCBIIEhAUkABACg1kECAISBJIEkASSAoECYIQKSBAgEzSKArNarNABIHaGAgSCBQIFAgAaAFBrIIEAkkCQQEJAkkCIMAkEEQgIIACkUBWaaKDKSB1MEIEggSEBSQAEAAaACQAhIEkAISBJICWTAaLJApIEkAQLNAVmtVmgEEDrCIQaLMIEhAUkCCQCsmgAkASCAoICEgSSAllqASCBQQEIAhUAFFNZoBAg6QxmEGiy0BIQFJAgkArNaZoAEAgkCQQFBAUCBhjLUAwiECggSQBM01mgqzSzaALJB0hjErUBvSw1AaQQNIICEAQpAMg0UAkASQAoICQgahjLUAkRAUgBFQBVmrRaAoqrNoJBA6SmVhqUG5TKxp0G4WYQaTOkCggQqFAUU1mgggBGhAVoQNFkg0YyQaQQNDQtBDUNBVm1Wi0FWarWbQWpnUDpK1K5ytSg3K1K5ytaDenWJToNrWdOg1qZ1aBFCAaKqKCCAEBaBQQNFkg0WUDR1lA1o0DQOjVrNoG1m1Ws6CtZtVrNoFMagdJWpXKVqUHSVqVzlMoOkp1zla0G9OsatBvVrOrQaA0aBoGjQIFqBIICgtBos6tBos6tBvRrOrQa0aNGgbRaLWbQNrNotFoK1m1WsWg1oY378INytSuMrUoO0p1ylMoOsrWuWnQddOuUp0HTVrGrQdNGsatBrVrOjQatGs6Ogb0azq0GtWs6tBvVrGnQb1axq0G9WsaNBvRrFotBq0Ws6LQatZtZtZtBq1i+haxfQNanPSBnpqekganpqekgano9BAej0kB6PSQLpdJAuh0kA1aEC1dJAul0kB1dJAul0kA6V9BAuh0kA6ZvpIGb6ZvpIGb6ZvpIGekkD/9k="),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "${model.name}",
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text("${model.quantity}"),
                ),
              ],
            ),
          ),
        );
      },);
  }
}
