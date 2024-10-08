import 'dart:convert';
import 'package:body_king/utils/encrypt.dart';
import 'package:body_king/utils/storage.dart';
import 'package:flutter/foundation.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import '../apis/auth.dart';
import '../services/api_response.dart';
import '../apis/models/auth_res.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthApi _authApi = AuthApi();
  RSAPublicKey? _publicKey;

  @override
  void initState() {
    super.initState();
    _fetchPublicKey();
  }

  void _fetchPublicKey() async {
    try {
      ApiResponse<PublicKeyResponse> response = await _authApi.getPublicKey();
      if (kDebugMode) {
        print(response.data.publicKey);
      }
      setState(() {
        _publicKey = parsePublicKeyFromPem(response.data.publicKey); // Adjust according to your response structure
      });
      await LocalStorage().set('publicKey', response.data.publicKey);
      print('Public Key fetched: $_publicKey');
    } catch (e) {
      print('Failed to fetch public key: $e');
    }
  }

  void _login() async {
    if ((_formKey.currentState?.validate() ?? false) &&  _publicKey != null) {
      try {
        // 生成随机对称密钥
        final symmetricKey = generateRandomKey(32);
        final symmetricKeyBase64 = base64.encode(symmetricKey);
        if (kDebugMode) {
          print('Generated Symmetric Key (Base64): $symmetricKeyBase64');
        }

        // 对密码进行哈希
        final hashedPassword = sha256.convert(utf8.encode(_passwordController.text)).toString();
        if (kDebugMode) {
          print('Hashed Password: $hashedPassword');
        }

        // 使用对称密钥加密哈希后的密码
        final encryptedPassword = encryptWithAES(hashedPassword, symmetricKey);
        if (kDebugMode) {
          print('Encrypted Password: $encryptedPassword');
        }

        // 使用公钥加密对称密钥
        final encryptedSymmetricKey = encryptWithRSA(symmetricKeyBase64, _publicKey!);
        if (kDebugMode) {
          print('Encrypted Symmetric Key (Base64): $encryptedSymmetricKey');
        }

        final response = await _authApi.login(
          _usernameController.text, encryptedPassword.encrypted,
          encryptedPassword.iv,
          encryptedSymmetricKey
        );
        if (kDebugMode) {
          print('Login successful: $response');
        }

        await LocalStorage().set('token', response.data.access_token);
        Navigator.pushReplacementNamed(context, '/');
        // Handle successful login
      } catch (e) {
        if (kDebugMode) {
          print('Login failed: $e');
        }
        // Handle login error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Handle login logic
                      print('Username: ${_usernameController.text}');
                      print('Password: ${_passwordController.text}');
                      _login();
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
