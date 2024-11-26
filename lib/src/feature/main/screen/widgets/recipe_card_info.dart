import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';

class RecipeCardInfo extends StatelessWidget {
  final String title;
  final String author;
  final String time;
  final double rating;
  final String image;

  const RecipeCardInfo({
    super.key,
    required this.title,
    required this.author,
    required this.time,
    required this.rating,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.onPrimary,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: context.colors.outlineVariant,
              blurRadius: 6.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  const CircleAvatar(
                    radius: 18,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                      child: Image(
                        image: AssetImage('assets/images/steak.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'By $author',
                    style: TextStyle(
                      fontSize: 14,
                      color: context.colors.outline,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 16,
                        color: context.colors.outline,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(color: context.colors.outline),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      for (int i = 0; i < 5; i++) const Icon(Icons.star),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
