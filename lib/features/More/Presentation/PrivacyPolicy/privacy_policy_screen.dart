import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Privacy policy',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Terms and Conditions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _privacyPolicyContent,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Color(0xFF666666),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const String _privacyPolicyContent = '''Lorem ipsum dolor sit amet consectetur. Nibh tempor tortor adipiscing dui dolor ipsum potenti. Id purus est elementum odio mauris. Habitant eget augue suspendisse eu porta a imperdiet elementum elit. Neque pharetra pellentesque fusce fames enim ultrices blandit viverra quam. Amet netus elementum aliquet vitae egestas egestas. Nisi amet facilisi posuere penatibus orci molestie velit. In mauris morbi quis at bibendum arcu pharetra risus aliquet. Bibendum ornare pharetra curabitur ultrices lacinia integer. Rhoncus volutpat elit dui condimentum. Vestibulum malesuada hendrerit lacus neque mauris odio. Curabitur cras leo sed elementum fermentum tellus facilisis semper.

Facilisi dignissim odio id volutpat amet commodo hac faucibus. Tincidunt convallis eget condimentum aliquet cursus arcu posuere cras in. Aenean in dui diam orci tellus. Pulvinar eut elit in nulla molestie placerat non. Enim sapien praesent faucibus sed a et. Quam amet massa urna lorem nullam urna semper. Nunc scelerisque habitant ultrices eget a dolor laoreet. Sagittis viverra bibendum neque tristique donec. Commodo fringilla faucibus enim eget augue vestibulum. Placerat maecenas aliquam sit nunc eros molestie dignissim dictumst. Cursus mauris aliquam sit semper lorem id. Fusce sem enim gravida massa integer. Libero duis sem lectus velit nec urna ac metus. Sed at tempor rhoncus pellentesque non arcu dolor et mattis. Volutpat sed eget nullam tellus. A mauris maecenas aliquet turpis mattis diam felis potenti. Mi tellus aliquam nunc ut. Cras lectus viverra sit id lectus lectus. Interdum sapien mollis feugiat turpis ullamcorper aliquam. Aliquam sollicitudin morbi tellus interdum bibendum vitae enim. Lacus non faucibus ipsum viverra eget aliquam. Arcu velit diam sit vitae faucibus ipsum dui sagittis aliquet. In sed vulputate nam porttitor dolor morbi faucibus dolor. Tincidunt arcu feugiat dictum urna placerat. Donec venenatis morbi id pretium. Enim nulla.''';
}
