import 'package:flutter/material.dart';
import '../screens/help_topic_detail_screen.dart';

class HelpTopicItem extends StatelessWidget {
  final String title;

  const HelpTopicItem({
    super.key,
    required this.title,
  });

  List<HelpSection> _getHelpContent(String topic) {
    switch (topic.toLowerCase()) {
      case 'how do i contact customer':
        return [
          HelpSection(
            title: 'In-App Chat',
            content:
                'You can contact customers directly through the in-app chat feature. Once you accept a delivery request, a chat button will appear on the delivery details screen. Tap it to send messages, share your location, or call the customer directly.',
          ),
          HelpSection(
            title: 'E-mail',
            content:
                'For non-urgent matters or detailed inquiries, you can reach out to customers via email. The customer\'s email address will be available in the order details section. Make sure to include your order reference number when sending emails for faster resolution.',
          ),
        ];
      case 'what if i cant find them':
        return [
          HelpSection(
            title: 'Use In-App Navigation',
            content:
                'Our app provides turn-by-turn navigation to help you reach the customer\'s location. Make sure your GPS is enabled and follow the directions provided. If the pin location seems incorrect, contact the customer immediately.',
          ),
          HelpSection(
            title: 'Contact Customer',
            content:
                'If you\'re having trouble locating the customer, use the in-app call or chat feature to reach them. Ask for landmarks, building names, or additional directions to help you find their exact location.',
          ),
        ];
      case 'what do i do if order gets missing':
        return [
          HelpSection(
            title: 'Report Immediately',
            content:
                'If an order goes missing, report it immediately through the app. Go to the delivery details screen and tap "Report Issue". Select "Missing Order" and provide all relevant details about when and where you last had the package.',
          ),
          HelpSection(
            title: 'Contact Support',
            content:
                'Reach out to our support team as soon as possible. They will guide you through the investigation process and help resolve the situation. Make sure to document everything and keep all communication records.',
          ),
        ];
      default:
        return [
          HelpSection(
            title: 'General Help',
            content:
                'For assistance with this topic, please contact our support team through the "Send us a message" option on the support screen.',
          ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF1A1A1A),
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Color(0xFF666666),
          size: 20,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HelpTopicDetailScreen(
                title: title,
                sections: _getHelpContent(title),
              ),
            ),
          );
        },
      ),
    );
  }
}
