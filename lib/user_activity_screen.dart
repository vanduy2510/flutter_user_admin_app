import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserActivityScreen extends StatelessWidget {
  const UserActivityScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nhật ký hoạt động')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user_logs').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) return const Center(child: Text('Chưa có hoạt động'));
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (c, i) {
              final d = docs[i];
              final email = d['email'] ?? '';
              final action = d['action'] ?? '';
              final ts = d['timestamp'] as Timestamp?;
              final time = ts != null ? ts.toDate().toString().substring(0, 16) : 'Không rõ';
              return ListTile(
                leading: const Icon(Icons.history),
                title: Text('$email - $action'),
                subtitle: Text(time),
              );
            },
          );
        },
      ),
    );
  }
}
