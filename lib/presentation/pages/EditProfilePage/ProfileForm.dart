import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/helpers/show_toast.dart';
import 'package:lettutor/models/User.dart';
import 'package:lettutor/service/UserService.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key, required this.user});

  final User user;

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  bool _isLoading = true;
  bool _isSubmitting = false;

  void _onSubmit() {
    setState(() {
      _isSubmitting = true;
    });
    const UserService().updateDetail(widget.user).then((value) {
      setState(() {
        _isSubmitting = false;
      });
      showSuccessSnackBar(context, "Edit profile successful");
    });
  }

  final _nameController = TextEditingController();
  final _countryController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  DateTime? _dob;

  String _getDateLabel(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _countryController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Widget _label(BuildContext context, String label, {bool isRequired = false}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          if (isRequired)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                "*",
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.red),
              ),
            ),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      const UserService()
          .getDetail(widget.user)
          .then((value) => widget.user.detail = value)
          .then((value) => setState(() {
                _isLoading = false;
                _nameController.text = widget.user.name!;
                _countryController.text = widget.user.detail?.country ?? "";
                _phoneController.text =
                    widget.user.detail?.phoneNumber.phoneNumber ?? "";
                _dobController.text =
                    _getDateLabel(widget.user.detail?.birthday);
                _dob = widget.user.detail?.birthday;
              }));
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final theme = Theme.of(context);
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(context, "Name", isRequired: true),
          TextFormField(
            controller: _nameController,
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(
            height: 24,
          ),
          _label(context, "Email Address"),
          TextFormField(
            initialValue: widget.user.email,
            readOnly: true,
            decoration:
                InputDecoration(fillColor: Colors.grey.shade300, filled: true),
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(
            height: 24,
          ),
          _label(context, "Country", isRequired: true),
          Container(
            decoration: BoxDecoration(
              // color: Colors.white54,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade600,
                width: 1,
              ),
            ),
            child: CountryCodePicker(
              //
              countryList: const [
                ...codes,
                {
                  "name": "",
                  "code": "",
                  "dial_code": "",
                }
              ],
              initialSelection: "",
              showDropDownButton: true,
              onChanged: (CountryCode countryCode) {
                _countryController.text = countryCode.name!;
              },
              showOnlyCountryWhenClosed: true,
              showCountryOnly: true,
              showFlag: false,
              alignLeft: true,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          _label(context, "Phone Number", isRequired: true),
          TextFormField(
            controller: _phoneController,
            readOnly: widget.user.detail?.phoneNumber.isVerified ?? false,
            decoration: widget.user.detail?.phoneNumber.isVerified ?? false
                ? InputDecoration(fillColor: Colors.grey.shade300, filled: true)
                : null,
            style: theme.textTheme.bodySmall,
          ),
          if (widget.user.detail?.phoneNumber.isVerified ?? false)
            Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                border: Border.all(color: Colors.green),
              ),
              child: const Text(
                "Verified",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                ),
              ),
            ),
          const SizedBox(
            height: 24,
          ),
          _label(context, "Birthday", isRequired: true),
          TextFormField(
            autovalidateMode: AutovalidateMode.always,
            validator: (value) {
              return value!.isNotEmpty ? null : "Please input your dob";
            },
            controller: _dobController,
            onTap: () async {
              _dob = await showDatePicker(
                context: context,
                initialDate: _dob ?? DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 10),
                lastDate: DateTime(DateTime.now().year + 10),
              );
              _dobController.text = _getDateLabel(_dob);
            },
            style: theme.textTheme.bodySmall,
            decoration: const InputDecoration(
              isDense: true,
              suffixIcon: Icon(
                Icons.calendar_month,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              style:
                  FilledButton.styleFrom(backgroundColor: theme.primaryColor),
              onPressed: _isSubmitting ? () {} : _onSubmit,
              child: IndexedStack(
                  alignment: Alignment.center,
                  index: _isSubmitting ? 1 : 0,
                  children: [
                    Text(
                      'Submit',
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.white),
                    ),
                    const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ))
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
