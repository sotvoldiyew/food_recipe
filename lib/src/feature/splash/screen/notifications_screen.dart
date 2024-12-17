import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> notifications = [
    {
      'title': 'New Recipe Alert!',
      'description': 'Lorem Ipsum tempor incididunt ut labore et dolore, in voluptate velit esse cillum',
      'time': '10 mins ago',
    },
    {
      'title': 'New Recipe Alert!',
      'description': 'Lorem Ipsum tempor incididunt ut labore et dolore, in voluptate velit esse cillum',
      'time': '30 mins ago',
    },
    {
      'title': 'Save Recipe Alert!',
      'description': 'Lorem Ipsum tempor incididunt ut labore et dolore, in voluptate velit esse cillum',
      'time': '30 mins ago',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xff121212),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xff129575),
                indicator: BoxDecoration(
                  color: const Color(0xff129575),
                  borderRadius: BorderRadius.circular(14),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Read'),
                  Tab(text: 'Unread'),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                NotificationsList(notifications: notifications),
                NotificationsList(notifications: notifications),
                NotificationsList(notifications: notifications),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationsList extends StatelessWidget {
  final List<Map<String, String>> notifications;

  const NotificationsList({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(30.0),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return NotificationTile(notification: notifications[index]);
      },

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

class NotificationTile extends StatefulWidget {
  final Map<String, String> notification;

  const NotificationTile({super.key, required this.notification});

  @override
  _NotificationTileState createState() => _NotificationTileState();
}
class _NotificationTileState extends State<NotificationTile> {
  bool _isSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:  15.0,vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.notification['title'] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.notification['description'] ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.notification['time'] ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSuccess = !_isSuccess;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Color(0xffFDEEDC),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(height: 30,
                  _isSuccess ? 'assets/images/unRead.png' : 'assets/images/reaf.png',
                ),

              ),
            ),
          ),
        ],
      ),

    );
  }
}
