enum FormFieldType {
  email("email", "abc@example.com"),
  password("password", "******");

  const FormFieldType(this.name, this.placeholder);

  final String name;
  final String placeholder;

  String get label => name.toUpperCase();
}