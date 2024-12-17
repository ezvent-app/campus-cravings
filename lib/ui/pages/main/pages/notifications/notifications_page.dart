import 'package:auto_route/auto_route.dart';
import 'package:campus_cravings/ui/widgets/base_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return BaseWrapper(
      label: 'Notifications',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Push Notifications",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff2E3138)
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "We highly recommend enabling notifications to stay updated on all your order statuses in real time.",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff878E9B)
                        ),
                      ),
                  
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SMS Notifications",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff2E3138)
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Stay in the loop! Enable SMS notifications to receive real-time updates about your order statuses.",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff878E9B)
                        ),
                      ),

                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email Notifications",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff2E3138)
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Don’t miss a thing! Turn on email notifications for detailed updates on all your orders.",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff878E9B)
                        ),
                      ),

                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}