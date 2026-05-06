import 'package:flutter/material.dart';
import '../widgets/support_header.dart';
import '../widgets/message_input_card.dart';
import '../widgets/search_help_section.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF8C42),
              Color(0xFFFF7A29),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SupportHeader(),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 80),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: const Column(
                    children: [
                      MessageInputCard(),
                      SearchHelpSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
