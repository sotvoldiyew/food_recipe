import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int selectedIndex = 0;

  final List<Map<String, String>> notifications = [
    {
      'title': 'New Recipe Alert!',
      'description':
          'Lorem Ipsum tempor incididunt ut labore et dolore, in voluptate velit esse cillum',
      'time': '10 mins ago',
    },
    {
      'title': 'New Recipe Alert!',
      'description':
          'Lorem Ipsum tempor incididunt ut labore et dolore, in voluptate velit esse cillum',
      'time': '30 mins ago',
    },
    {
      'title': 'Save Recipe Alert!',
      'description':
          'Lorem Ipsum tempor incididunt ut labore et dolore, in voluptate velit esse cillum',
      'time': '30 mins ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilterButton(
                  text: 'All',
                  isSelected: selectedIndex == 0,
                  onTap: () => setState(() => selectedIndex = 0),
                ),
                FilterButton(
                  text: 'Read',
                  isSelected: selectedIndex == 1,
                  onTap: () => setState(() => selectedIndex = 1),
                ),
                FilterButton(
                  text: 'Unread',
                  isSelected: selectedIndex == 2,
                  onTap: () => setState(() => selectedIndex = 2),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return NotificationTile(notification: notifications[index]);
              },
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 40), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      //   ],
      // ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected ? context.colors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            color:
                isSelected ? context.colors.onPrimary : context.colors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final Map<String, String> notification;

  const NotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(notification['title'] ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(notification['description'] ?? ''),
          const SizedBox(height: 5),
          Text(notification['time'] ?? ''),
        ],
      ),
      trailing: const Icon(Icons.notifications),
      isThreeLine: true,
    );
  }
}
