import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../constants/app_text.dart';
import '../models/contact.dart';
import '../widgets/contact_card.dart';
import '../widgets/contact_form_sheet.dart';
import '../widgets/route_logo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Contact> _contacts = [];

  Future<void> _addContact() async {
    final contact = await showModalBottomSheet<Contact>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const ContactFormSheet(),
      ),
    );

    if (contact != null && mounted) {
      setState(() {
        _contacts.add(contact);
      });
    }
  }

  void _deleteContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  void _deleteAll() {
    setState(() {
      _contacts.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(22, 16, 22, 14),
              child: RouteLogo(fontSize: 42),
            ),
            Expanded(child: _contacts.isEmpty ? _emptyList() : _contactGrid()),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_contacts.isNotEmpty) ...[
            FloatingActionButton.small(
              heroTag: AppText.delete,
              onPressed: _deleteAll,
              backgroundColor: AppColors.red,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.delete_rounded),
            ),
            const SizedBox(height: 10),
          ],
          FloatingActionButton.small(
            heroTag: AppText.enterUser,
            onPressed: _addContact,
            backgroundColor: AppColors.cream,
            foregroundColor: AppColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }

  Widget _emptyList() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            AppAssets.emptyListAnimation,
            width: 150,
            height: 150,
            repeat: true,
          ),
          const SizedBox(height: 16),
          const Text(
            AppText.emptyContacts,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.cream,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactGrid() {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 90),
      itemCount: _contacts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) {
        return ContactCard(
          contact: _contacts[index],
          onDelete: () => _deleteContact(index),
        );
      },
    );
  }
}
