import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/app_colors.dart';
import '../constants/app_text.dart';
import '../models/contact.dart';
import 'contact_input.dart';
import 'contact_photo.dart';

class ContactFormSheet extends StatefulWidget {
  const ContactFormSheet({super.key});

  @override
  State<ContactFormSheet> createState() => _ContactFormSheetState();
}

class _ContactFormSheetState extends State<ContactFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _picker = ImagePicker();
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_refreshPreview);
    _emailController.addListener(_refreshPreview);
    _phoneController.addListener(_refreshPreview);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _refreshPreview() {
    setState(() {});
  }

  Future<void> _pickImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 1000,
    );

    if (image != null && mounted) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }

  String? _requiredValue(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppText.requiredField;
    }
    return null;
  }

  String? _checkEmail(String? value) {
    final required = _requiredValue(value);
    if (required != null) return required;
    if (!value!.contains('@') || !value.contains('.')) {
      return AppText.invalidEmail;
    }
    return null;
  }

  void _saveContact() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.of(context).pop(
      Contact(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        imagePath: _imagePath,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 18),
          decoration: const BoxDecoration(
            color: AppColors.panel,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: _pickImage,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.cream),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ContactPhoto(
                          imagePath: _imagePath,
                          width: 112,
                          height: 112,
                          borderRadius: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        children: [
                          _previewLine(
                            _nameController.text.isEmpty
                                ? AppText.userName
                                : _nameController.text,
                          ),
                          _previewLine(
                            _emailController.text.isEmpty
                                ? AppText.emailExample
                                : _emailController.text,
                          ),
                          _previewLine(
                            _phoneController.text.isEmpty
                                ? AppText.phoneExample
                                : _phoneController.text,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                ContactInput(
                  controller: _nameController,
                  hint: AppText.enterUserName,
                  keyboardType: TextInputType.name,
                  validator: _requiredValue,
                ),
                const SizedBox(height: 8),
                ContactInput(
                  controller: _emailController,
                  hint: AppText.enterUserEmail,
                  keyboardType: TextInputType.emailAddress,
                  validator: _checkEmail,
                ),
                const SizedBox(height: 8),
                ContactInput(
                  controller: _phoneController,
                  hint: AppText.enterUserPhone,
                  keyboardType: TextInputType.phone,
                  validator: _requiredValue,
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _saveContact,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cream,
                      foregroundColor: AppColors.background,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      AppText.enterUser,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _previewLine(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.cream, width: 0.8)),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: AppColors.cream, fontSize: 12),
      ),
    );
  }
}
