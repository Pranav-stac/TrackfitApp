import 'package:dietify/Login&Signup/Login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signup() async {
    final url = Uri.parse('https://stable-simply-porpoise.ngrok-free.app/signup/'); // Replace with your API endpoint
    final response = await http.post(
      url,
      body: {
        'username': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup successful')),
      );

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                'Create Account',
                style: TextStyle(
                  color: const Color(0xFF00FFE0),
                  fontFamily: 'Satoshi',
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 40),
              _buildTextField(
                label: 'Name',
                hintText: 'Enter your Name',
                controller: _nameController,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Email',
                hintText: 'Enter your Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Password',
                hintText: 'Enter your Password',
                controller: _passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  await _signup();

                  setState(() {
                    _isLoading = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00FFE0),
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'Satoshi',
                        ),
                      ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF00FFE0),
            fontSize: 14,
            fontFamily: 'Satoshi',
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A), // Updated box color
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              hintText: hintText,
              hintStyle: const TextStyle(
                fontFamily: 'Satoshi',
                color: Color.fromARGB(255, 157, 157, 157),
              ),
            ),
            style: const TextStyle(
              color: Color(0xFF00FFE0),
              fontFamily: 'Satoshi',
            ),
          ),
        ),
      ],
    );
  }
}
