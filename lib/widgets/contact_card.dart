import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text.dart';
import '../models/contact.dart';
import 'contact_photo.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.contact, required this.onDelete});

  final Contact contact;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ContactPhoto(
                  imagePath: contact.imagePath,
                  width: double.infinity,
                  height: double.infinity,
                  borderRadius: 16,
                ),
                Positioned(
                  left: 7,
                  bottom: 7,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 130),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cream,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      contact.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.background,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(7, 5, 7, 6),
            child: Column(
              children: [
                _detailRow(Icons.email_rounded, contact.email),
                const SizedBox(height: 5),
                _detailRow(Icons.phone_rounded, contact.phone),
                const SizedBox(height: 7),
                SizedBox(
                  width: double.infinity,
                  height: 31,
                  child: ElevatedButton.icon(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_rounded, size: 15),
                    label: const Text(AppText.delete),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.zero,
                      elevation: 0,
                      textStyle: const TextStyle(fontSize: 11),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.background, size: 16),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.background, fontSize: 9),
          ),
        ),
      ],
    );
  }
}
