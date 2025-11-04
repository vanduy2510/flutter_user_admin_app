import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'update_user_screen.dart';

class UserListScreen extends StatelessWidget {
  final String currentUserId;
  final bool isAdmin;

  const UserListScreen({
    super.key,
    required this.currentUserId,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    final usersRef = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách người dùng'),
        backgroundColor: Colors.blueAccent,
        actions: [
          if (isAdmin)
            IconButton(
              icon: const Icon(Icons.admin_panel_settings),
              tooltip: 'Chế độ Admin',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Đang ở chế độ Admin")),
                );
              },
            ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Chưa có người dùng nào."));
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final userDoc = users[index];
              final user = userDoc.data() as Map<String, dynamic>;
              final userId = userDoc.id;

              final username = user['username'] ?? 'Không có tên';
              final email = user['email'] ?? 'Không có email';
              final img = user['img'] ?? '';
              final lastSeen = user['lastSeen'];

              // 🔹 Chuyển lastSeen sang định dạng dễ đọc
              String lastSeenText = 'Chưa từng đăng nhập';
              if (lastSeen != null && lastSeen is Timestamp) {
                final dt = lastSeen.toDate();
                lastSeenText =
                '${dt.day}/${dt.month}/${dt.year} - ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
              }

              ImageProvider? avatar;
              if (img.isNotEmpty) {
                try {
                  avatar = MemoryImage(base64Decode(img));
                } catch (_) {
                  avatar = null;
                }
              }

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: avatar,
                  child: avatar == null ? const Icon(Icons.person) : null,
                ),
                title: Text(username),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(email),
                    Text('🕒 Lần hoạt động gần nhất: $lastSeenText',
                        style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (userId == currentUserId)
                      const Text('(Bạn)',
                          style: TextStyle(color: Colors.blue, fontSize: 12)),
                    if (isAdmin)
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UpdateUserScreen(
                                userId: userId,
                                userData: user,
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
